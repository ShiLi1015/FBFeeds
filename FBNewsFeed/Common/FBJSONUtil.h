//
//  NtreisJSONUtil.h
//  ntreis
//
//  Created by LMAN on 2/18/15.
//  Copyright (c) 2015 idragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBJSONUtil : NSObject

+ (id) getStatusObject:             (id) json;
+ (long) getStatusCode:             (id) json;
+ (NSString *) getStatusMessage:    (id) json;

+ (NSArray *) getResponseArray:     (id) json;

+ (NSString *) getStringValue:      (id) json key:(NSString *) key;
+ (NSNumber *) getIntegerValue:     (id) json key:(NSString *) key;
+ (NSNumber *) getDoubleValue:      (id) json key:(NSString *) key;
+ (NSString *) getJsonStringValue:  (id) json key:(NSString *) key;

+ (id) getObjectFromJson:           (NSString *) json;

@end
