//
//  DateUtil.m
//  FBNewsFeed
//
//  Created by LMAN on 3/9/16.
//  Copyright © 2016 Star. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSString*)getMMMDDYYYY:(NSString*)strDate {
    
    NSDateFormatter* formatter = nil;
    if (formatter == nil) {
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    }
    
    NSDate * date = [NSDate date];
    date = [formatter dateFromString:strDate];
    
    [formatter setDateFormat:@"MMM dd yyyy"];
    
    return [formatter stringFromDate:date];
}

@end
