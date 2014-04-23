//
//  TBGlobalCore.m
//  Core
//
//  Created by enfeng on 12-12-17.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import "TBGlobalCore.h"

@implementation TBGlobalCore
#import <objc/runtime.h>

// No-ops for non-retaining objects.
static const void* TBRetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
static void TBReleaseNoOp(CFAllocatorRef allocator, const void *value) { }

NSMutableArray* TBCreateNonRetainingArray(void) {
    CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
    callbacks.retain = TBRetainNoOp;
    callbacks.release = TBReleaseNoOp;
    return (NSMutableArray*)CFBridgingRelease(CFArrayCreateMutable(nil, 0, &callbacks));
}

NSMutableDictionary* TBCreateNonRetainingDictionary(void) {
    CFDictionaryKeyCallBacks keyCallbacks = kCFTypeDictionaryKeyCallBacks;
    CFDictionaryValueCallBacks callbacks = kCFTypeDictionaryValueCallBacks;
    callbacks.retain = TBRetainNoOp;
    callbacks.release = TBReleaseNoOp;
    return (NSMutableDictionary*)CFBridgingRelease(CFDictionaryCreateMutable(nil, 0, &keyCallbacks, &callbacks));
}

void TBSwapMethods(Class cls, SEL originalSel, SEL newSel) {
    Method originalMethod = class_getInstanceMethod(cls, originalSel);
    Method newMethod = class_getInstanceMethod(cls, newSel);
    method_exchangeImplementations(originalMethod, newMethod);
}
@end
