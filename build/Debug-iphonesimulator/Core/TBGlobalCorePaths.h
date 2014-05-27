#import <Foundation/Foundation.h>

/**
 * @return YES if the URL begins with "bundle://"
 */
BOOL TBIsBundleURL(NSString *URL);

/**
 * @return YES if the URL begins with "documents://"
 */
BOOL TBIsDocumentsURL(NSString *URL);

/**
 * Used by TBPathForBundleResource to construct the bundle path.
 *
 * Retains the given bundle.
 *
 * @default nil (See TBGetDefaultBundle for what this means)
 */
void TBSetDefaultBundle(NSBundle *bundle);

/**
 * Retrieves the default bundle.
 *
 * If the default bundle is nil, returns [NSBundle mainBundle].
 *
 * @see TBSetDefaultBundle
 */
NSBundle *TBGetDefaultBundle(void);

/**
 * @return The main bundle path concatenated with the given relative path.
 */
NSString *TBPathForBundleResource(NSString *relativePath);

/**
 * @return The documents path concatenated with the given relative path.
 */
NSString *TBPathForDocumentsResource(NSString *relativePath);
