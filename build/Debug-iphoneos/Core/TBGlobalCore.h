//
//  TBGlobalCore.h
//  Core
//
//  Created by enfeng on 12-12-17.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBGlobalCore : NSObject
/**
 * 创建一个可变数组，不会对数组中的元素增加引用计数
 *
 * 主要用于delegate数组
 */
NSMutableArray* TBCreateNonRetainingArray(void);

/**
 * Creates a mutable dictionary which does not retain references to the values it contains.
 *
 * Typically used with dictionaries of delegates.
 */
NSMutableDictionary* TBCreateNonRetainingDictionary(void);

/**
 * Swap the two method implementations on the given class.
 * Uses method_exchangeImplementations to accomplish this.
 */
void TBSwapMethods(Class cls, SEL originalSel, SEL newSel);
@end
