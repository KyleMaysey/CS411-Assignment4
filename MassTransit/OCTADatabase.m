//
//  OCTADatabase.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/22/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "OCTADatabase.h"
#import "OCTARoute.h"

@implementation OCTADatabase

static OCTADatabase* oDatabase;     //Persistent reference to OCTADatabase object

+(OCTADatabase *) getDatabase
{
    if (oDatabase == nil)
    {
        oDatabase = [[OCTADatabase alloc] init];
    }
    return oDatabase;
}

-(id) init
{
    self = [super init];
    
    if(self)
    {
        NSString* oDatPath = [[NSBundle mainBundle] pathForResource:@"OCTA" ofType:@"sq3"];
        
        
        if( sqlite3_open([oDatPath UTF8String], &OCTAConnect) != SQLITE_OK)
        {
            NSLog(@"Failed to open SQL Database");
        }
        
        
    }
    
    return self;
}

- (void) dealloc
{
    sqlite3_close(OCTAConnect);
}

//Purpose:  Performs query to get list of OCTARoute objects for OCTA service
//Return:   NSArray of OCTARoute objects
//Function adapted from example provided by Professor Shafae
- (NSArray*) getRoutes
{
    
    NSMutableArray* routeListReturn = [[NSMutableArray alloc] init];
    NSString* query = @"select route_id, route_url from routes;";
    sqlite3_stmt *stmt;
    const unsigned char* text;
    NSString *routeName, *routeURL;
    
    if( sqlite3_prepare_v2(OCTAConnect, [query UTF8String], [query length], &stmt, nil) == SQLITE_OK)
    {
        while( sqlite3_step(stmt) == SQLITE_ROW)
        {
            text = sqlite3_column_text(stmt, 0);
            if( text )
                routeName = [NSString stringWithCString: (const char*)text encoding:NSUTF8StringEncoding];
            else
                routeName = nil;
            
            text = sqlite3_column_text(stmt, 1);
            if( text)
                routeURL = [NSString stringWithCString:(const char*)text encoding:NSUTF8StringEncoding];
            else
                routeURL = nil;
            
            OCTARoute* oRoute = [[OCTARoute alloc] initWithRouteID:routeName andRouteURL:routeURL];
            
            [routeListReturn addObject: oRoute];
        }
        sqlite3_finalize(stmt);
    }
    
    return routeListReturn;
}

@end
