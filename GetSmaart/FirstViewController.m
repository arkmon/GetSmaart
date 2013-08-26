//
//  FirstViewController.m
//  GetSmaart
//
//  Created by Arkadiusz Dowejko on 23/08/2013.
//  Copyright (c) 2013 SmaartPublishing. All rights reserved.
//

#import "FirstViewController.h"
#import "AFNetworking.h"
#import "ArticleViewController.h"
#import "CustomNavigationBar.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.titleView = [self titleView];
    self.navigationItem.rightBarButtonItem = [self checkInButton];
       
    //NSLog(@"Up and running");
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.95 blue:0.90 alpha:1.0];
    // above code apply formatting to my table
    
    NSURL *url = [NSURL URLWithString:@"http://getsmaart.com/article/json"];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    //above code defines my url for json formatted data
    NSURLRequest *request = [NSURLRequest requestWithURL:url]; // im setting up the request with url
    
    //code below creates the json request operation and proceed with the request
    
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                success:^(NSURLRequest *req, NSHTTPURLResponse *response, id jsonObject) {
                                                                    //NSLog(@"Response: %@", jsonObject);
                                                                    self.results = [jsonObject objectForKey:@"results"]; //if success: put all objects from fesults to the array
                                                                    self.displayItems = [[NSMutableArray alloc] initWithArray:self.results]; //copy array to mutable array
                                                                    [self.tableView reloadData]; //refresh the table
                                                                    //NSLog(@"Response: %@", _displayItems); //show what is in the array in log
                                                                } failure:^(NSURLRequest *req, NSHTTPURLResponse *response, NSError *error, id jsonObject) {
                                                                    //NSLog(@"Success %d", response.statusCode);
                                                                    NSLog(@"Error: %@", error);
                                                                    // if failure, show me the error
                                                                }];
    [operation start];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (UIView *)titleView {
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat width = 0.95 * self.view.frame.size.width;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, navBarHeight)];
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    UIButton *logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat logoY = floorf((navBarHeight - logo.size.height) / 2.0f);
    [logoButton setFrame:CGRectMake(0, logoY, logo.size.width, logo.size.height)];
    [logoButton setImage:logo forState:UIControlStateNormal];
    
    UIImage *bubble = [UIImage imageNamed:@"notification-bubble-empty.png"];
    UIImageView *bubbleView = [[UIImageView alloc] initWithImage:bubble];
    
    const CGFloat Padding = 5.0f;
    CGFloat bubbleX =
    logoButton.frame.size.width +
    logoButton.frame.origin.x +
    Padding;
    CGFloat bubbleY = floorf((navBarHeight - bubble.size.height) / 2.0f);
    CGRect bubbleRect = bubbleView.frame;
    bubbleRect.origin.x = bubbleX;
    bubbleRect.origin.y = bubbleY;
    bubbleView.frame = bubbleRect;
    
    [containerView addSubview:logoButton];
    [containerView addSubview:bubbleView];
    
    return containerView;
}

- (UIBarButtonItem *)checkInButton {
    UIImage *checkInImage = [UIImage imageNamed:@"global-checkin-button.png"];
    UIImage *checkInPressed = [UIImage imageNamed:@"global-checkin-button-pressed.png"];
    UIButton *checkInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [checkInButton setBackgroundImage:checkInImage forState:UIControlStateNormal];
    [checkInButton setBackgroundImage:checkInPressed forState:UIControlStateHighlighted];
    
    const CGFloat BarButtonOffset = 5.0f;
    [checkInButton setFrame:CGRectMake(BarButtonOffset, 0, checkInImage.size.width, checkInImage.size.height)];
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, checkInImage.size.width, checkInImage.size.height)];
    [containerView addSubview:checkInButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    return item;
}

- (void)viewDidUnload {
    [super viewDidUnload];
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
    return self.displayItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }

    
    self.tweet = [self.displayItems objectAtIndex:indexPath.row]; // in dictionairy i want only one lecturer
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = [self.tweet objectForKey:@"name"]; //print value
    
    // cell.detailText.text = [self.tweet objectForKey:@"lastName"];
    // cell.deptLabel.text = [self.tweet objectForKey:@"department"];
    // NSString *url = [self.tweet objectForKey:@"profile_image"];
    //  [cell.imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"avatar.png"]];
    // if no image, put one from the directory
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) { // if my table is clicked
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow]; //define the path for selected row
        NSArray *object = _displayItems[indexPath.row]; //put only selected lecturer to new array
        NSLog(@"String %@", object); // show me what is inside
        [[segue destinationViewController] setDetailItem:object]; // send the array to the next view
    }
    
}


@end
