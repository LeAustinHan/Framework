//
//  NSDictionaryAdditions.h
//  Core
//
//  Created by enfeng on 13-10-12.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TBAdditions)

- (id) objectForKey:(id)aKey convertNSNullToNil:(BOOL) convertNSNull;
@end
