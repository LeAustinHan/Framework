//
//  TN800IponeI18n.m
//  iphone_ipad
//
//  Created by enfeng yang on 11-12-8.
//  Copyright (c) 2011年 mac. All rights reserved.
//
#import "TBI18n.h"
#import "TBSourceI18n.h"

NSString* TBSourceLocalizedString(NSString* key, NSString* defaultValue) {
    return TBLocalizedString(key, defaultValue, @"source.bundle");
}