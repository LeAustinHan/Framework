//
//  TBCommonFunction.h
//  Core
//
//  Created by enfeng yang on 12-6-12.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *GetIPAddress(void);

/**
 * 获取Wifi地址
 */
NSString *GetWifiMacAddress(void);

/**
 * 获取Wifi地址
 */
NSString *GetWifiMacAddressWithSeparator(NSString *sep);

/**
* 需要的最低系统版本
*/
BOOL RequireSysVerGreaterOrEqual(NSString *reqSysVer);

/**
* 用于设置页面坐标
*/
BOOL NeedResetUIStyleLikeIOS7(void);
