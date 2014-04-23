//
//  NSDictionaryAdditions.m
//  Core
//
//  Created by enfeng on 13-10-12.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "NSDictionaryAdditions.h"

@implementation NSDictionary (TBAdditions)

- (id) objectForKey:(id)aKey convertNSNullToNil:(BOOL) convertNSNull {
    id ret = [self objectForKey:aKey];
    if ([ret isKindOfClass:[NSNull class]]) {
        ret = nil;
    }
    return ret;
}
@end
