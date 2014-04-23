//
//  TBCoreDao.m
//  Core
//
//  Created by enfeng on 13-8-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "TBCoreDao.h"
#import "FMDatabase.h"
#import "HHCoreMacros.h"

@implementation TBCoreDao
@synthesize db = _db;

- (id)init {
    self = [super init];
    if (self) {
    }

    return self;
}

- (id)initWithPath:(NSString *)aPath {
    self = [super init];
    if (self) {
        _db = [[FMDatabase alloc] initWithPath:aPath];
        if (![_db open]) {
            NSLog(@"Could not open db.");
        }
    }

    return self;
}

- (void)createTable:(NSString *)tableSql {
    [_db executeUpdate:tableSql];
}

- (void)dealloc {

    [_db close]; 
}

@end
