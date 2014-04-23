//
//  TBCoreConfigDao.m
//  Core
//
//  Created by enfeng on 13-8-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "TBCoreConfigDao.h"

@implementation TBCoreConfigDao

- (void)saveValue:(NSDictionary *)paramDict {

    NSNumber *pKey = [paramDict objectForKey:@"pKey"];
    NSData *pValue = [paramDict objectForKey:@"pValue"];

    NSString *sql = @"replace into tb_config(tb_key, tb_value) values(?, ?);";
    [self.db executeUpdate:sql, pKey, pValue];
}

- (NSData *)getValue:(NSNumber *)pKey {
    FMResultSet *rs = [self.db executeQuery:@"select * from tb_config where tb_key=?", pKey];
    NSData *data = nil;

    if ([rs next]) {
        data = [rs dataForColumn:@"tb_value"];
    }
    [rs close];

    return data;
}

- (NSDictionary *)getValues {
    FMResultSet *rs = [self.db executeQuery:@"select * from tb_config"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:30];

    while ([rs next]) {
        NSData *data = [rs dataForColumn:@"tb_value"];
        int key = [rs intForColumn:@"tb_key"];
        NSNumber *pKey = [NSNumber numberWithInt:key];
        if (data) {
            [dict setObject:data forKey:pKey];
        }
    }
    [rs close];

    return dict;
}


@end
