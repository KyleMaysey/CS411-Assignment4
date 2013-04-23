//
//  MetroDatabase.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/20/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MetroRoute.h"

@interface MetroDatabase : NSObject
{
    sqlite3* metroConnect;  //For opening metrolink database connection
}

//Purpose: Acquire database, instantiating if needed
+ (MetroDatabase *) getDatabase;

//Purpose:  Performs query to get list of route name for Metrolink
//Return:   NSArray of NSStrings
- (NSArray*) getRoutes;

//Purpose:  Peforms query to get all information regarding all trips for Metrolink
//Return:   NSArray of MetroRoute objects
- (NSArray*) getTripsForRoute: (NSString *) route;

//Purpose:  Performs query to get stop information given a trip number for Metrolink
//Return:   NSArray of NSString tuples(in the form of NSArrays) in the format @[ stopname, stoptime]
- (NSArray*) getStopsForTrip: (NSNumber*) trip;

@end
