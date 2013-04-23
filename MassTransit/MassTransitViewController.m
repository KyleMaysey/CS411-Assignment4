//
//  MassTransitViewController.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/17/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "MassTransitViewController.h"
#import "PDFViewController.h"

@interface MassTransitViewController ()



@end

@implementation MassTransitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Perform database query to get trip information for the selected route
    if ([self.databaseName isEqualToString:@"Metrolink"])
    {
        self.routeInfo = [[MetroDatabase getDatabase] getTripsForRoute:self.routeName];
    }
    
    //Format output using HTML for display
    [(UIWebView*)self.routeOutput loadHTMLString: [self makeHTMLPage] baseURL: nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//Purpose:  Operate on list of metrolink routes and format information into HTML
-(NSString *) makeHTMLPage
{
    NSString* temp = @"<html>";
    
    for (MetroRoute* rInfo in self.routeInfo) {
        temp = [NSString stringWithFormat:@"%@%@<hr>", temp, [rInfo HTMLOutput]];
    }
    
    
    return [NSString stringWithFormat:@"%@</html>", temp];
}
 
@end
