//
//  FBFeed.h
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBFeed : NSObject

@property (nonatomic, retain) NSString * fId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * story;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * createdTime;
@property (nonatomic, retain) NSMutableArray * attachs;

- (void)initFeed;

- (void)setFeedFrom:(id)json;

@end
