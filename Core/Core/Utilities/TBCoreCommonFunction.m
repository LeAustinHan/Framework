//
//  TBCommonFunction.m
//  Core
//
//  Created by enfeng yang on 12-6-12.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "TBCoreCommonFunction.h"

#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

#import <ifaddrs.h>
#import <arpa/inet.h>

NSString *GetIPAddress (void) {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
// retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
// Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if (temp_addr->ifa_addr->sa_family == AF_INET) {
// Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
// Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *) temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
// Free memory
    freeifaddrs(interfaces);
    return address;
}

NSString *GetWifiMacAddress(void) {
    return GetWifiMacAddressWithSeparator(@":");
}

NSString *GetWifiMacAddressWithSeparator(NSString *sep) {
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;

    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;

    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }

    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }

    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        free(buf);
        return NULL;
    }

    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }

    ifm = (struct if_msghdr *) buf;
    sdl = (struct sockaddr_dl *) (ifm + 1);
    ptr = (unsigned char *) LLADDR(sdl);
    NSString *outString = [NSString stringWithFormat:
            @"%02x%@%02x%@%02x%@%02x%@%02x%@%02x",
            *ptr,
            sep,
            *(ptr + 1),
            sep,
            *(ptr + 2),
            sep,
            *(ptr + 3),
            sep,
            *(ptr + 4),
            sep,
            *(ptr + 5)];
    free(buf);
    return [outString uppercaseString];
}

BOOL RequireSysVerGreaterOrEqual(NSString *reqSysVer) {
    BOOL ret = NO;
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending) {
        ret = YES;
    }
    return ret;
}

BOOL NeedResetUIStyleLikeIOS7(void) {

    BOOL isAfterVersion7 = RequireSysVerGreaterOrEqual(@"7");
    if (!isAfterVersion7) {
        return NO;
    }

    //如果不是通过sdk7编译的，那么也不需要设置坐标

#ifdef __IPHONE_7_0
    return YES;
#else
            return NO;
#endif

}