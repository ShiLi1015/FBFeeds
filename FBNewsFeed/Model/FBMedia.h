//
//  FBMedia.h
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBMedia : NSObject

@property (nonatomic, retain) NSString * src;
@property (nonatomic, retain) NSString * url;

- (void)initMedia;

- (void)setMediaFrom:(id)json;

@end
