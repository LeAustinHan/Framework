//
//  TBCoreConfigDao.h
//  Core
//
//  Created by enfeng on 13-8-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "TBCoreDao.h"

@interface TBCoreConfigDao : TBCoreDao

/**
* @params paramDict
*   key: pKey(NSNumber*)
*   key: pValue(NSData*)
*/
- (void) saveValue:(NSDictionary *)paramDict;

/**
* @param pKey
*/
- (NSData*) getValue:(NSNumber *)pKey;

/**
* 查询所有配置
*/
- (NSDictionary *) getValues;

@end
