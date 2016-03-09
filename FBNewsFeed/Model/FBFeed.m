//
//  FBFeed.m
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import "FBFeed.h"
#import "FBJSONUtil.h"
#import "FBMedia.h"

@implementation FBFeed

- (id)init {
    
    self = [super init];
    
    [self initFeed];
    
    return self;
}

- (void)initFeed {
    
    _fId = @"";
    _name = @"";
    _story = @"";
    _type = @"";
    _createdTime = @"";
    _attachs = nil;
    _attachs = [[NSMutableArray alloc] init];
}

- (void)setFeedFrom:(id)json {
    
    _fId = [FBJSONUtil getStringValue:json key:@"id"];
    _name = [FBJSONUtil getStringValue:json key:@"name"];
    _story = [FBJSONUtil getStringValue:json key:@"story"];
    _type = [FBJSONUtil getStringValue:json key:@"type"];
    _createdTime = [FBJSONUtil getStringValue:json key:@"created_time"];
 
    id attachments = [json objectForKey:@"attachments"];
    if (attachments != nil) {
        
        id attach_data = [attachments objectForKey:@"data"];
        
        if (attach_data == nil || [attach_data count] == 0) {
            return;
        }
        
        if ([attach_data[0] objectForKey:@"subattachments"] != nil) {
            attach_data = [[attach_data[0] objectForKey:@"subattachments"] objectForKey:@"data"];
        }
        
        for (id data in attach_data) {
         
            FBMedia * fbMedia = [[FBMedia alloc] init];
            [fbMedia setMediaFrom:data];
            [_attachs addObject:fbMedia];
        }
    }
}

@end
