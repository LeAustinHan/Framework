//
//  TBFileUtil.m
//  Core
//
//  Created by enfeng yang on 12-1-29.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "TBFileUtil.h"
 
#define kImgExtJpg @"jpg"
#define kImgExtPng @"png"
#define kImgExtGif @"gif"
#define kImgExtBmp @"bmp"

static NSString* tbFileBaseDir = @"tuan800";

@interface NSString (JRStringAdditions) 

- (BOOL) containsString:(NSString *) string;
- (BOOL) containsString:(NSString *) string
                options:(NSStringCompareOptions) options;

@end

@implementation NSString (JRStringAdditions) 

- (BOOL) containsString:(NSString *) string
                options:(NSStringCompareOptions) options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL) containsString:(NSString *) string {
    return [self containsString:string options:0];
}

@end

@implementation TBFileUtil

+ (void)setBaseDir:(NSString*)newValue {
    tbFileBaseDir = newValue;
}

+ (NSString*) isImageContentType:(NSString*)contentType {
    contentType = [contentType lowercaseString];
    
    if ([contentType containsString:@"jpeg"]) {
        return kImgExtJpg;
    }
    if ([contentType containsString:@"pjpeg"]) {
        return kImgExtJpg;
    }
    if ([contentType containsString:@"gif"]) {
        return kImgExtGif;
    }
    if ([contentType containsString:@"png"]) {
        return kImgExtPng;
    }
    if ([contentType containsString:@"x-png"]) {
        return kImgExtPng;
    }
    if ([contentType containsString:@"x-ms-bmp"]) {
        return kImgExtBmp;
    }
    
    return nil;
}

+ (NSString *)getBaseDir {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:@"Caches"];
    dir = [dir stringByAppendingPathComponent:tbFileBaseDir];
    
    NSFileManager *fm = [NSFileManager defaultManager]; 
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:dir isDirectory:&isDir]) {
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    return dir;
}

+ (NSString *)getDocumentBaseDir {
    // 获取Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:@"data"];
    dir = [dir stringByAppendingPathComponent:tbFileBaseDir];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:dir isDirectory:&isDir]) {
        [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    
    return dir;
}

/**
 * 获取缓存目录，所有缓存数据都放在该目录下
 * isCreate：如不存在，是否需要创建
 */
+ (NSString *) getCacheDirWithCreate:(BOOL)isCreate {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:@"Caches"];
    dir = [dir stringByAppendingPathComponent:tbFileBaseDir];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:dir isDirectory:&isDir]) {
        // 不存在
        if (isCreate) {
            [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            return dir;
        }else {
            return @"";
        }
    }else{
        // 存在
        return dir;
    }
}

/** 剪切文件到另一个文件。
 *  1.如果源文件不存在则不剪切
 *  2.如果强制剪切则需要传isForce参数，强制剪切会删除旧目标文件。
 *  成功剪切返回YES
 */
+ (BOOL)moveFile:(NSString *)sourceFile ToFile:(NSString *)targetFile forceMove:(BOOL)isForce {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:sourceFile]) {
        if ([fm fileExistsAtPath:targetFile] && isForce) {
            // 强制剪切
            // 1.删除旧目标文件
            BOOL removeResult = [fm removeItemAtPath:targetFile error:nil];
            if (removeResult) {
                // 2.剪切
                return [fm moveItemAtPath:sourceFile toPath:targetFile error:NULL];
            }
        }else if(![fm fileExistsAtPath:targetFile]){
            // 剪切
            return [fm moveItemAtPath:sourceFile toPath:targetFile error:NULL];
        }else {
            // 不剪切
            return NO;
        }
    }
    
    return NO; // 剪切失败
}

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+ (void)copyAppDbFileToDocument:(NSString *)dbName {    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *toPath = [TBFileUtil getBaseDir];
    toPath = [toPath stringByAppendingPathComponent:dbName];
    BOOL ok = [fm fileExistsAtPath:toPath];
    
    NSString *apppath = [[NSBundle mainBundle] resourcePath];
    NSString *fromPath = [apppath stringByAppendingPathComponent:dbName];
    NSError *error1, *error2;
    NSDictionary *fileAttributes1 = [[NSFileManager defaultManager] attributesOfItemAtPath:toPath error:&error1];
    NSDictionary *fileAttributes2 = [[NSFileManager defaultManager] attributesOfItemAtPath:fromPath error:&error2];
    NSDate *toDate = [fileAttributes1 objectForKey:NSFileModificationDate];
    NSDate *fromDate = [fileAttributes2 objectForKey:NSFileModificationDate];
    NSComparisonResult result = [fromDate compare:toDate];
    if (!ok || result == NSOrderedDescending) {
        [fm copyItemAtPath:fromPath toPath:toPath error:NULL];
    }
}

+ (NSString *)getDbFilePath:(NSString *)dbName {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *toPath = [TBFileUtil getBaseDir];
    toPath = [toPath stringByAppendingPathComponent:dbName];
    BOOL ok = [fm fileExistsAtPath:toPath];
    if (ok) {
        return toPath;
    }
    return nil;
}

+ (void)createDir:(NSString *)dir {
    NSFileManager *fm = [NSFileManager defaultManager]; 
    [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
}

+ (NSString *)getDefaultImgDir { 
    NSString *dir = [TBFileUtil getBaseDir];
    return [dir stringByAppendingPathComponent:@"image"];
}

+ (void) deleteFile:(NSString*) filePath {
    NSFileManager *fm = [NSFileManager defaultManager]; 
    BOOL ret = [fm fileExistsAtPath:filePath];
    if (!ret) {
        return;
    }
    
    NSError *error;
    [fm removeItemAtPath:filePath error:&error];
    if (error) {
        NSLog(@"Error: %@ delete file:%@", error, filePath);
    }
}

+ (void) deleteAllCachesImages {
    NSString *filePath = [TBFileUtil getDefaultImgDir];
    NSFileManager *fm = [NSFileManager defaultManager]; 
    [fm removeItemAtPath:filePath error:nil];
}

/**
 * 获取缓存目录，所有缓存数据都放在该目录下
 * isCreate：如不存在，是否需要创建
 */
+ (NSString *) getCacheDir:(BOOL)isCreate {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex:0];
    dir = [dir stringByAppendingPathComponent:@"Caches"];
    dir = [dir stringByAppendingPathComponent:tbFileBaseDir];

    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fm fileExistsAtPath:dir isDirectory:&isDir]) {
        // 不存在
        if (isCreate) {
            [fm createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:NULL];
            return dir;
        }else {
            return @"";
        }
    }else{
        // 存在
        return dir;
    }
}

/** 剪切文件到另一个文件。
 *  1.如果源文件不存在则不剪切
 *  2.如果强制剪切则需要传isForce参数，强制剪切会删除旧目标文件。
 *  成功剪切返回YES
 */
+ (BOOL)moveFile:(NSString *)sourceFile ToFile:(NSString *)targetFile force:(BOOL)isForce {

    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:sourceFile]) {
        if ([fm fileExistsAtPath:targetFile] && isForce) {
            // 强制剪切
            // 1.删除旧目标文件
            BOOL removeResult = [fm removeItemAtPath:targetFile error:nil];
            if (removeResult) {
                // 2.剪切
                return [fm moveItemAtPath:sourceFile toPath:targetFile error:NULL];
            }
        }else if(![fm fileExistsAtPath:targetFile]){
            // 剪切
            return [fm moveItemAtPath:sourceFile toPath:targetFile error:NULL];
        }else {
            // 不剪切
            return NO;
        }
    }

    return NO; // 剪切失败
}

@end
