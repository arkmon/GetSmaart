//
//  ArticleViewController.h
//  GetSmaart
//
//  Created by Arkadiusz Dowejko on 24/08/2013.
//  Copyright (c) 2013 SmaartPublishing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"
#import "AFNetworking.h"

@interface ArticleViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextView *articleTextView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) id detailItem;
@end
