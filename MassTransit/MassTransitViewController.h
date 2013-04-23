//
//  MassTransitViewController.h
//  MassTransit
//
//  Created by Kyle Maysey on 4/17/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetroDatabase.h"
#import "MetroRoute.h"

@interface MassTransitViewController : UIViewController

@property (nonatomic, strong) NSArray* routeInfo;       //Array of routes for Metrolink
@property (nonatomic, strong) NSString* routeName;      //Name of metrolink route selected
@property (nonatomic, strong) NSString* databaseName;   //Name of the selected service
@property (nonatomic, strong) IBOutlet UIWebView *routeOutput;  //Webview for route output

@end
