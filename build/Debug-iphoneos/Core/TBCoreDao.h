//
//  TBCoreDao.h
//  Core
//
//  Created by enfeng on 13-8-30.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDatabase.h"

@interface TBCoreDao : NSObject {

    FMDatabase *_db;
}
@property(nonatomic, readonly) FMDatabase *db;

- (id)initWithPath:(NSString *)aPath;

- (void)createTable:(NSString *)tableSql;
@end
