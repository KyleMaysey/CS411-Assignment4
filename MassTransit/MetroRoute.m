//
//  MetroRoute.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/20/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "MetroRoute.h"

@implementation MetroRoute


//Purpose: Initialize object with all the information for a Metrolink trip
-(id) initWithTripID:(NSNumber*)tid andTrainNumber:(NSString *)tNum andStops:(NSArray *)sList
{
    self = [super init];
    
    if(self)
    {
        _tripID = tid;
        _trainNumber = tNum;
        _stopList = sList;
    }
    
    return self;
}

//Purpose:  Format trip information in HTML
//Return:   NSString formatted for being embedded in HTML output
-(NSString*) HTMLOutput
{
    NSString* temp;
    
    temp = [NSString stringWithFormat:@"Train Number: %@<br>%@ ➜<br> %@<br>", self.trainNumber, self.stopList[0][0], [self.stopList lastObject][0]];
    
    for (NSArray* stops in self.stopList)
    {
        temp = [NSString stringWithFormat:@"%@<br>Stop Name:<br>%@<br>Arrival Time:<br>%@<br>", temp, stops[0], stops[1]];
    }
  
    return temp;
//    return [NSString stringWithFormat: @"%@</html>", temp];
}

@end
