//
//  NewsFeedDetailVC.m
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import "NewsFeedDetailVC.h"
#import <UIImageView+AFNetworking.h>
#import "FBMedia.h"

@interface NewsFeedDetailVC ()

@end

@implementation NewsFeedDetailVC

#pragma mark - 
#pragma mark - UIView Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if ([_feed.story isEqualToString:@""]) {
        _lblTitle.text = _feed.name;
    } else {
        _lblTitle.text = _feed.story;
    }
    
    if (![_feed.type isEqualToString:@"photo"]
        && ![_feed.type isEqualToString:@"video"]) {
        _imgFeed.hidden = YES;
    } else {
        
        _imgFeed.hidden = NO;
    }
    
    if (_feed.attachs.count == 0) {
        return;
    }
    
    FBMedia * fbMedia = [_feed.attachs objectAtIndex:0];
    [_imgFeed setImageWithURL:[NSURL URLWithString:fbMedia.src]];
}

@end
