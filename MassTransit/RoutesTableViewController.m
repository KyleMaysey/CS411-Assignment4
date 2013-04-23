//
//  RoutesTableViewController.m
//  MassTransit
//
//  Created by Kyle Maysey on 4/17/13.
//  Copyright (c) 2013 Kyle Maysey. All rights reserved.
//

#import "RoutesTableViewController.h"
#import "MassTransitViewController.h"
#import "PDFViewController.h"
#import "OCTARoute.h"

@interface RoutesTableViewController ()

@end

@implementation RoutesTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

//Purpose:  Load routeLists from the requested database
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    if ([self.databaseName isEqualToString:@"Metrolink"])
    {
        self.routeList = [[MetroDatabase getDatabase] getRoutes];
        
        
    }
    else if( [self.databaseName isEqualToString:@"OCTA"])
    {
        self.routeList = [[OCTADatabase getDatabase] getRoutes];
        
    }
    

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.routeList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    if( cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Load cell with information appropriate for the service selected
    if ([self.databaseName isEqualToString:@"Metrolink"])
    {
        cell.textLabel.text = [self.routeList objectAtIndex:indexPath.row];
    }
    else
    {
        OCTARoute *thisRoute = [self.routeList objectAtIndex:indexPath.row];
        cell.textLabel.text = thisRoute.routeID;
        
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

//Purpose:  Perform segue for proper service when a cell is selected
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    if ([self.databaseName isEqualToString:@"Metrolink"])
    {
        [self performSegueWithIdentifier:@"detailSegue" sender:self];
    }
    else if([self.databaseName isEqualToString:@"OCTA"])
    {
        [self performSegueWithIdentifier:@"octaSegue" sender:self];
    }
    
}

//Purpose:  Perform selected segue from the tapped cell
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        MassTransitViewController* detailView = segue.destinationViewController;
        
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        
        detailView.routeName = [self.routeList objectAtIndex:selectedIndex.row];
        detailView.databaseName = self.databaseName;
    }
    
    if( [segue.identifier isEqualToString:@"octaSegue"])
    {
        PDFViewController* pdfView = segue.destinationViewController;
        
        NSIndexPath* selectedIndex = [self.tableView indexPathForSelectedRow];
        
        OCTARoute* thisRoute = [self.routeList objectAtIndex:selectedIndex.row];
        
        pdfView.routeURL = thisRoute.routeURL;
    }
}

@end
