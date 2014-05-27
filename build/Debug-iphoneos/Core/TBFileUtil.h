//
//  TBFileUtil.h
//  Core
//
//  Created by enfeng yang on 12-1-29.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
 

@interface TBFileUtil : NSObject {
  
}

/**
 * 设置基础目录名称，不用带上完整路径；默认是tuan800
 * 如tuan800, hui800, tao800
 */
+ (void)setBaseDir:(NSString*)newValue;

+ (void)copyAppDbFileToDocument:(NSString *)dbName;

+ (NSString *)getDbFilePath:(NSString *)dbName;

+ (void)createDir:(NSString *)dir;

+ (NSString *) getDefaultImgDir;

/**
 * 获取基础目录，所有缓存都放在该目录下
 */
+ (NSString *) getBaseDir;

/**
 * 获取Documents目录
 */
+ (NSString *)getDocumentBaseDir;

/**
 * 获取缓存目录，所有缓存数据都放在该目录下
 * isCreate：如不存在，是否需要创建
 */
+ (NSString *) getCacheDirWithCreate:(BOOL)isCreate;

/** 剪切文件到另一个文件。
 *  1.如果源文件不存在则不剪切
 *  2.如果强制剪切则需要传isForce参数，强制剪切会删除旧目标文件。
 *  成功剪切返回YES
 */
+ (BOOL)moveFile:(NSString *)sourceFile ToFile:(NSString *)targetFile forceMove:(BOOL)isForce;

+ (void) deleteFile:(NSString*) filePath;

/**
 * 删除所有缓存目录下的图片
 */
+ (void) deleteAllCachesImages;

/**
 * @return 图片扩展名, 如果图片不存在则返回nil
 */
+ (NSString*) isImageContentType:(NSString*)contentType;


/**
 * 获取缓存目录，所有缓存数据都放在该目录下
 * isCreate：如不存在，是否需要创建
 */
+ (NSString *) getCacheDir:(BOOL)isCreate;


/** 剪切文件到另一个文件。
 *  1.如果源文件不存在则不剪切
 *  2.如果强制剪切则需要传isForce参数，强制剪切会删除旧目标文件。
 *  成功剪切返回YES
 */
+ (BOOL)moveFile:(NSString *)sourceFile ToFile:(NSString *)targetFile force:(BOOL)isForce;
@end