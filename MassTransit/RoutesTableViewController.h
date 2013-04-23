//
//  RoutesTableViewController.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/17/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetroDatabase.h"
#import "OCTADatabase.h"

@interface RoutesTableViewController : UITableViewController

@property (nonatomic, strong) NSArray* routeList;       //Stores routeList for requested database
@property (nonatomic, strong) NSString* databaseName;   //Stores the name of the requested service

@end
