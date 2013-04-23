//
//  MetroRoute.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/20/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MetroRoute : NSObject

@property (nonatomic, retain) NSNumber* tripID;         //trip_id from Metrolink database
@property (nonatomic, retain) NSString* trainNumber;    //trip_short_name from Metrolink database
@property (nonatomic, retain) NSArray* stopList;        //NSArray of NSString tuples(in the form of NSArrays) in the format @[ stopname, stoptime]

//Purpose: Initialize object with all the information for a Metrolink trip
-(id) initWithTripID: (NSNumber*) tid andTrainNumber: (NSString*) tNum andStops: (NSArray*) sList;

//Purpose:  Format trip information in HTML
//Return:   NSString formatted for being embedded in HTML output
-(NSString*) HTMLOutput;

@end
