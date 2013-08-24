//
//  ArticleViewController.m
//  GetSmaart
//
//  Created by Arkadiusz Dowejko on 24/08/2013.
//  Copyright (c) 2013 SmaartPublishing. All rights reserved.
//

#import "ArticleViewController.h"
#import "AFNetworking.h"
#import "FirstViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view with data from second view
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    
    if (self.detailItem) {
        
        
        self.titleLabel.text = [self.detailItem objectForKey:@"name"];
        self.articleTextView.text = [self.detailItem objectForKey:@"article"];
        
        
    }
        
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureView];
    
    //NSLog(@"String %@",);
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_articleTextView release];
    [_titleLabel release];
    [super dealloc];
}
@end
