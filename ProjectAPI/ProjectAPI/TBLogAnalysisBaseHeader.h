//
//  TBLogAnalysisBaseHeader.h
//  Core
//
//  Created by enfeng yang on 12-2-7.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreTelephony/CTCarrier.h>

@interface TBLogAnalysisBaseHeader : NSObject <NSCoding, NSCopying> {
    NSString *phoneModel;//手机型号
    NSString *systemName;//系统类型
    NSString *resolution;//分辨率
    CTCarrier *carrier;//运营商
    NSString *appName;//软件名称
    NSString *deviceId;
    NSString *partner;//渠道id 需要传入
    NSString *telNum;//手机号码  需要传入, 可以为@""
    NSString *phoneVersion;
    NSString *appVersion; //系统版本
    int networkStatus; //网络类型
    NSString *macAddress;

    NSString *platform; //平台名称
}
@property(nonatomic, copy) NSString *phoneModel;//手机型号
@property(nonatomic, copy) NSString *systemName;//系统类型
@property(nonatomic, copy) NSString *resolution;//分辨率
@property(nonatomic, strong) CTCarrier *carrier;//运营商
@property(nonatomic, copy) NSString *appName;//软件名称
@property(nonatomic, copy) NSString *deviceId;
@property(nonatomic, copy) NSString *partner;//渠道id
@property(nonatomic, copy) NSString *telNum;//手机号码
@property(nonatomic, copy) NSString *phoneVersion;
@property(nonatomic, copy) NSString *appVersion;
@property(nonatomic, assign) int networkStatus;
@property(nonatomic, copy) NSString *macAddress;
@property(nonatomic, copy) NSString *platform;

- (id)initWithCoder:(NSCoder *)coder;

- (void)encodeWithCoder:(NSCoder *)coder;

- (id)copyWithZone:(NSZone *)zone;
@end

