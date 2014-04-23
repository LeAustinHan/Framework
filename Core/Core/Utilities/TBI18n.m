//
//  TBI18n.m
//  iphone_ipad
//
//  Created by enfeng yang on 11-12-7.
//  Copyright (c) 2011年 mac. All rights reserved.
//

#import "TBI18n.h"
NSLocale* TBCurrentLocale(void) {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defaults objectForKey:@"AppleLanguages"];
    if (languages.count > 0) {
        NSString* currentLanguage = [languages objectAtIndex:0];
        return [[NSLocale alloc] initWithLocaleIdentifier:currentLanguage];
        
    } else {
        return [NSLocale currentLocale];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* TBLocalizedString(NSString* key, NSString* defaultValue, NSString* bundleName) {
    static NSBundle* bundle = nil;
    if (nil == bundle) {
        NSString* path = [[[NSBundle mainBundle] resourcePath]
                          stringByAppendingPathComponent:bundleName];

        bundle = [NSBundle bundleWithPath:path];
    }
    
    return [bundle localizedStringForKey:key value:defaultValue table:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* TBDescriptionForError(NSError* error) {
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        // Note: If new error codes are added here, be sure to document them in the header.
        if (error.code == NSURLErrorTimedOut) {
            return TBLocalizedString(@"Connection Timed Out", @"",@"");
            
        } else if (error.code == NSURLErrorNotConnectedToInternet) {
            return TBLocalizedString(@"No Internet Connection", @"",@"");
            
        } else {
            return TBLocalizedString(@"Connection Error", @"",@"");
        }
    }
    return TBLocalizedString(@"Error", @"",@"");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString* TBFormatInteger(NSInteger num) {
    NSNumber* number = [NSNumber numberWithInt:num];
    NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString* formatted = [formatter stringFromNumber:number];

    return formatted;
}
