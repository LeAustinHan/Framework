//
//  HHCoreMacros.h
//  Core
//
//  Created by LeAustinHan on 14-4-21.
//  Copyright (c) 2014年 hanhan. All rights reserved.
//

#import <Foundation/Foundation.h>

//内存释放
#define HH_RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }
#define HH_INVALIDATE_TIMER(__TIMER) { [__TIMER invalidate]; __TIMER = nil; }
#define HH_RELEASE_CF_SAFELY(__REF) { if (nil != (__REF)) { CFRelease(__REF); __REF = nil; } }
#define HHIMAGE(_URL) [[TBURLCache sharedCache] imageForURL:_URL]

//打印
#ifdef DEBUG
#define HHPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define HHPRINT(xx, ...)  ((void)0)
#endif 


//剪切板
#define HHPasteString(string)   [[UIPasteboard generalPasteboard] setString:string];
#define HHPasteImage(image)     [[UIPasteboard generalPasteboard] setImage:image];

//主代理
#define HHApp ((AppDelegate *)[UIApplication sharedApplication].delegate)

//屏幕尺寸
#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)
#define kScreen_Frame    (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define kScreen_CenterX  kScreen_Width/2
#define kScreen_CenterY  kScreen_Height/2

//系统版本
#define isIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]==4)
#define isIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]==5)
#define isIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]==6)
#define isAfterIOS4 ([[[UIDevice currentDevice] systemVersion] intValue]>4)
#define isAfterIOS5 ([[[UIDevice currentDevice] systemVersion] intValue]>5)
#define isAfterIOS6 ([[[UIDevice currentDevice] systemVersion] intValue]>6)
#define isAfteriOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)