//
//  TBLogAnalysisBaseHeader.m
//  Core
//
//  Created by enfeng yang on 12-2-7.
//  Copyright (c) 2012年 mac. All rights reserved.
//


#import "TBLogAnalysisBaseHeader.h"

@implementation TBLogAnalysisBaseHeader
@synthesize phoneModel;//手机型号
@synthesize systemName;//系统类型
@synthesize resolution;//分辨率
@synthesize carrier;//运营商
@synthesize appName;//软件名称
@synthesize deviceId;
@synthesize partner;//渠道id
@synthesize telNum;//手机号码
@synthesize phoneVersion;
@synthesize appVersion;
@synthesize networkStatus;
@synthesize macAddress;

@synthesize platform;

- (id)copy {
    TBLogAnalysisBaseHeader *header = [[TBLogAnalysisBaseHeader alloc] init];
    header.phoneModel = self.phoneModel;
    header.systemName = self.systemName;
    header.resolution = self.resolution;
    header.carrier = self.carrier;
    header.appName = self.appName;
    header.deviceId = self.deviceId;
    header.partner = self.partner;
    header.telNum = self.telNum;
    header.phoneVersion = self.phoneVersion;
    header.appVersion = self.appVersion;
    header.networkStatus = self.networkStatus;
    header.macAddress = self.macAddress;
    header.platform = self.platform;

    return header;
}

- (void)dealloc {
 
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.phoneModel = [coder decodeObjectForKey:@"phoneModel"];
        self.systemName = [coder decodeObjectForKey:@"systemName"];
        self.resolution = [coder decodeObjectForKey:@"resolution"];
        self.appName = [coder decodeObjectForKey:@"appName"];
        self.deviceId = [coder decodeObjectForKey:@"deviceId"];
        self.partner = [coder decodeObjectForKey:@"partner"];
        self.telNum = [coder decodeObjectForKey:@"telNum"];
        self.phoneVersion = [coder decodeObjectForKey:@"phoneVersion"];
        self.appVersion = [coder decodeObjectForKey:@"appVersion"];
        self.networkStatus = [coder decodeIntForKey:@"networkStatus"];
        self.macAddress = [coder decodeObjectForKey:@"macAddress"];
        self.platform = [coder decodeObjectForKey:@"platform"];
    }

    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.phoneModel forKey:@"phoneModel"];
    [coder encodeObject:self.systemName forKey:@"systemName"];
    [coder encodeObject:self.resolution forKey:@"resolution"];
    [coder encodeObject:self.appName forKey:@"appName"];
    [coder encodeObject:self.deviceId forKey:@"deviceId"];
    [coder encodeObject:self.partner forKey:@"partner"];
    [coder encodeObject:self.telNum forKey:@"telNum"];
    [coder encodeObject:self.phoneVersion forKey:@"phoneVersion"];
    [coder encodeObject:self.appVersion forKey:@"appVersion"];
    [coder encodeInt:self.networkStatus forKey:@"networkStatus"];
    [coder encodeObject:self.macAddress forKey:@"macAddress"];
    [coder encodeObject:self.platform forKey:@"platform"];
}

- (id)copyWithZone:(NSZone *)zone {
    TBLogAnalysisBaseHeader *copy = [[[self class] allocWithZone:zone] init];

    if (copy != nil) {
        copy.phoneModel = self.phoneModel;
        copy.systemName = self.systemName;
        copy.resolution = self.resolution;
        copy.carrier = self.carrier;
        copy.appName = self.appName;
        copy.deviceId = self.deviceId;
        copy.partner = self.partner;
        copy.telNum = self.telNum;
        copy.phoneVersion = self.phoneVersion;
        copy.appVersion = self.appVersion;
        copy.networkStatus = self.networkStatus;
        copy.macAddress = self.macAddress;
        copy.platform = self.platform;
    }

    return copy;
}


@end
