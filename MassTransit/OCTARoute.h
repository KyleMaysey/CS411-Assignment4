//
//  OCTARoute.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/22/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCTARoute : NSObject

@property (nonatomic, retain) NSString* routeID;    //OCTA route Number
@property (nonatomic, retain) NSString* routeURL;   //OCTA route information pdf URL link

//Purpose: Initialize object with OCTA route information
-(id) initWithRouteID: (NSString*) rid andRouteURL: (NSString*) rURL;

@end
