//
//  OCTADatabase.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/22/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

@interface OCTADatabase : NSObject
{
    sqlite3* OCTAConnect;   //Connection to OCTA database
}

//Purpose:  Acquire reference to OCTADatabase, instansiates if needed
+ (OCTADatabase *) getDatabase;

//Purpose:  Performs query to get list of OCTARoute objects for OCTA service
//Return:   NSArray of OCTARoute objects
- (NSArray*) getRoutes;

@end
