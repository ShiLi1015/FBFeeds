//
//  NewsFeedDetailVC.h
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBFeed.h"

@interface NewsFeedDetailVC : UIViewController

@property (nonatomic, strong) FBFeed * feed;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgFeed;

@end
