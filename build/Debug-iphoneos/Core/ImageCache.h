//
//  ImageCache.h
//  Tuan800
//
//  Created by mac mac on 11-11-16.
//  Copyright 2011年 mac. All rights reserved.
//	File created using Singleton XCode Template by Mugunth Kumar (http://blog.mugunthkumar.com)
//  More information about this template on the post http://mk.sg/89
//  Permission granted to do anything, commercial/non-commercial with this file apart from removing the line/URL above

#import <Foundation/Foundation.h>
#import "ImageHelper-Files.h"

@interface ImageCache : NSObject {
    NSMutableDictionary *myCache;
}

+ (ImageCache*) sharedInstance;
@property (nonatomic, strong) NSMutableDictionary *myCache;

- (void)addImageToCache:(NSString*)imageName;
- (void)removeImageFromCache:(NSString*)imageName;
- (UIImage *) getImageByName: (NSString *) someKey;
- (void) respondToMemoryWarning;//内存警告时清除
@end
