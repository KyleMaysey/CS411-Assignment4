//
//  MetroDatabase.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/20/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "MetroDatabase.h"

@implementation MetroDatabase


static MetroDatabase* mDatabase;   //Persistent reference for MetroDatabase object


//Purpose: Acquire database, instantiating if needed
+(MetroDatabase *) getDatabase
{
    if (mDatabase == nil)
    {
        mDatabase = [[MetroDatabase alloc] init];
    }
    return mDatabase;
}

-(id) init
{
    self = [super init];
    
    if(self)
    {
        NSString* mDatPath = [[NSBundle mainBundle] pathForResource:@"Metrolink" ofType:@"sq3"];
    
        
        if( sqlite3_open([mDatPath UTF8String], &metroConnect) != SQLITE_OK)
        {
            NSLog(@"Failed to open SQL Database");
        }

        
    }
    
    return self;
}

- (void) dealloc
{
    sqlite3_close(metroConnect);
}

//Purpose:  Performs query to get list of route name for Metrolink
//Return:   NSArray of NSStrings
//Function adapted from example provided by Professor Shafae
- (NSArray*) getRoutes
{
    
    NSMutableArray* routeListReturn = [[NSMutableArray alloc] init];
    NSString* query = @"select route_id from routes;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *routeName;
    
    if( sqlite3_prepare_v2(metroConnect, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK)
    {
        while( sqlite3_step(stmt) == SQLITE_ROW)
        {
            text = sqlite3_column_text(stmt, 0);
            if( text )
                routeName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeName = nil;
            

            [routeListReturn addObject: routeName];
        }
        sqlite3_finalize(stmt);
    }

    return routeListReturn;
}

//Purpose:  Peforms query to get all information regarding all trips for Metrolink
//Return:   NSArray of MetroRoute objects
//Function adapted from example provided by Professor Shafae
- (NSArray*) getTripsForRoute: (NSString*) route
{
    NSMutableArray* tripList = [[NSMutableArray alloc] init];
    
    NSString* query = [NSString stringWithFormat:@"select trip_id, trip_short_name from trips where route_id = \"%@\";", route];
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *trainNum;
    NSNumber* tid;
    NSArray* stopList;
    
    if( sqlite3_prepare_v2(metroConnect, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK)
    {
        
        while( sqlite3_step(stmt) == SQLITE_ROW){
            tid = [NSNumber numberWithInt:(sqlite3_column_int(stmt, 0))];
            text = sqlite3_column_text(stmt, 1);
            if(text)
                trainNum = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                trainNum = nil;

            stopList = [[MetroDatabase getDatabase] getStopsForTrip:tid];
            
            MetroRoute *thisTrip = [[MetroRoute alloc] initWithTripID:tid andTrainNumber:trainNum andStops:stopList];
            [tripList addObject: thisTrip];
        }
        sqlite3_finalize(stmt);
    }
    return tripList;
}

//Purpose:  Performs query to get stop information given a trip number for Metrolink
//Return:   NSArray of NSString tuples(in the form of NSArrays) in the format @[ stopname, stoptime]
//Function adapted from example provided by Professor Shafae
- (NSArray*) getStopsForTrip:(NSNumber *)trip
{
    NSMutableArray* stopList = [[NSMutableArray alloc] init];
    
    NSString* query = [NSString stringWithFormat:@"select stop_name, arrival_time from stops, stop_times where trip_id=%d and stop_times.stop_id = stops.stop_id;", [trip intValue]];
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *stopName, *stopTime;
    
    if( sqlite3_prepare_v2(metroConnect, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK)
    {
        
        while( sqlite3_step(stmt) == SQLITE_ROW){
            text = sqlite3_column_text(stmt, 0);
            if(text)
            {
                stopName = [NSString stringWithCString:(const char*)text encoding:NSUTF8StringEncoding];
            }
            else
            {
                stopName = nil;
            }
            
            text = sqlite3_column_text(stmt, 1);
            if(text)
                stopTime = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                stopTime = nil;
            
            NSArray* stopTuple = @[stopName, stopTime];
            
            [stopList addObject: stopTuple];
        }
        sqlite3_finalize(stmt);
    }
    return stopList;
}

@end
