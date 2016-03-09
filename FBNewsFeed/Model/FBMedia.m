//
//  FBMedia.m
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import "FBMedia.h"
#import "FBJSONUtil.h"

@implementation FBMedia

- (id)init {
    
    self = [super init];
    
    [self initMedia];
    
    return self;
}

- (void)initMedia {
    
    _src = @"";
    _url = @"";
}

- (void)setMediaFrom:(id)json {

    _src = [FBJSONUtil getStringValue:[[json objectForKey:@"media"] objectForKey:@"image"] key:@"src"];
    _url = [FBJSONUtil getStringValue:json key:@"url"];
}

@end
