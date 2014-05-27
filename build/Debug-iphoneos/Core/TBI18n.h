//
//  TBI18n.h
//  iphone_ipad
//
//  Created by enfeng yang on 11-12-7.
//  Copyright (c) 2011年 mac. All rights reserved.
//


/**
 * Gets the current system locale chosen by the user.
 *
 * This is necessary because [NSLocale currentLocale] always returns en_US.
 */
NSLocale* TBCurrentLocale(void);
/**
 * @return A localized string from the TB bundle.
 */
NSString* TBLocalizedString(NSString* key, NSString* defaultValue,NSString* bundleName);

/**
 * @return A localized description for NSURLErrorDomain errors.
 *
 * Error codes handled:
 * - NSURLErrorTimedOut
 * - NSURLErrorNotConnectedToInternet
 * - All other NSURLErrorDomain errors fall through to "Connection Error".
 */
NSString* TBDescriptionForError(NSError* error);

/**
 * @return The given number formatted as XX,XXX,XXX.XX
 *
 * TODO(jverkoey 04/19/2010): This should likely be locale-aware.
 */
NSString* TBFormatInteger(NSInteger num);