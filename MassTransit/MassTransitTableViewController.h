//
//  MassTransitTableViewController.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/17/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MassTransitTableViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray* serviceList; //Load list of services

@end
