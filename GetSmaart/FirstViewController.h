//
//  FirstViewController.h
//  GetSmaart
//
//  Created by Arkadiusz Dowejko on 23/08/2013.
//  Copyright (c) 2013 SmaartPublishing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSArray *results;
@property (retain, nonatomic) NSMutableArray *displayItems;
@property (retain, nonatomic) IBOutlet UISearchBar *serchBar;
@property (retain, nonatomic)  NSDictionary *tweet;
@end
