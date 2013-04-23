//
//  OCTARoute.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/22/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "OCTARoute.h"

@implementation OCTARoute

//Purpose: Initialize object with OCTA route information
-(id) initWithRouteID:(NSString *)rid andRouteURL:(NSString *)rURL
{
    self = [super init];
    
    if(self)
    {
        _routeID = rid;
        _routeURL = rURL;
    }
    
    return self;
}

@end
