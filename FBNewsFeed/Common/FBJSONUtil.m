//
//  NtreisJSONUtil.m
//  ntreis
//
//  Created by LMAN on 2/18/15.
//  Copyright (c) 2015 idragon. All rights reserved.
//

#import "FBJSONUtil.h"

@implementation FBJSONUtil

+ (id)getStatusObject:(id)json
{
    if (!json) return nil;
    
    return [json valueForKey:@"status"];
}

+ (long)getStatusCode:(id)json
{
    id status = [FBJSONUtil getStatusObject:json];
    if (!status) return -1;
    
    NSNumber * code = [status valueForKey:@"code"];
    if (!code) return -1;
    
    return [code longValue];
}

+ (NSString *)getStatusMessage:(id)json
{
    id status = [FBJSONUtil getStatusObject:json];
    if (!status) return @"Unknown Error";
    
    NSString * message = [status valueForKey:@"message"];
    if (!message) return @"Unknown Error";
    
    return message;
}

+ (NSArray *)getResponseArray:(id)json
{
    id response = [json valueForKey:@"response"];
    if (!response) return [NSArray array];
    
    return response;
}

+ (NSString *)getStringValue:(id)json key:(NSString *)key
{
    id jsValue = [json valueForKey:key];
    
    if ([jsValue isKindOfClass:[NSString class]])
    {
        if ([[jsValue lowercaseString] isEqualToString:@"null"])
            return @"";
        
        return jsValue;
    }
    
    if ([jsValue isKindOfClass:[NSNumber class]])
    {
        return [(NSNumber *) jsValue stringValue];
    }
    
    return @"";
}

+ (NSNumber *)getIntegerValue:(id)json key:(NSString *)key
{
    id jsValue = [json valueForKey:key];
    
    if ([jsValue isKindOfClass:[NSNumber class]])
    {
        return jsValue;
    }
    
    if ([jsValue isKindOfClass:[NSString class]])
    {
        if ([jsValue isEqualToString:@"<null>"])
            return [NSNumber numberWithInt:0];
        
        return [NSNumber numberWithInt:[jsValue intValue]];
    }
    
    return [NSNumber numberWithInt:0];
}

+ (NSNumber *) getDoubleValue:(id)json key:(NSString *)key
{
    id jsValue = [json valueForKey:key];
    
    if ([jsValue isKindOfClass:[NSNumber class]])
    {
        return jsValue;
    }
    
    if ([jsValue isKindOfClass:[NSString class]])
    {
        return [NSNumber numberWithDouble:[jsValue doubleValue]];
    }
    
    return [NSNumber numberWithDouble:0.0];
}

+ (NSString *)getJsonStringValue:(id)json key:(NSString *)key
{
    id dictData = [json valueForKey:key];
    NSError * error;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictData
                                                        options:0
                                                          error:&error];
    
    if (!jsonData) return @"";
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (id)getObjectFromJson:(NSString *)json
{
    NSError * error;
    
    if (!json) return nil;
    
    return [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
}

@end
