//
// Created by enfeng on 13-6-19.
// Copyright (c) 2013 mac. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <objc/runtime.h>
#import "NSObjectAdditions.h"


@implementation NSObject (TBExtend)

- (void)resetNullProperty {
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);

    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propName];
        id propValue = [self valueForKey:name];
        if ([propValue isKindOfClass:[NSNull class]]) {
            [self setValue:nil forKey:name];
        }
    }
    free(properties);
}
@end