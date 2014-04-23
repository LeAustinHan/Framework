#import "TBGlobalCorePaths.h"


static NSBundle *globalBundle = nil;


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL TBIsBundleURL(NSString *URL) {
    return [URL hasPrefix:@"bundle://"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL TBIsDocumentsURL(NSString *URL) {
    return [URL hasPrefix:@"documents://"];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
void TBSetDefaultBundle(NSBundle *bundle) {
    
    globalBundle = bundle;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSBundle *TBGetDefaultBundle(void) {
    return (nil != globalBundle) ? globalBundle : [NSBundle mainBundle];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString *TBPathForBundleResource(NSString *relativePath) {
    NSString *resourcePath = [TBGetDefaultBundle() resourcePath];
    return [resourcePath stringByAppendingPathComponent:relativePath];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
NSString *TBPathForDocumentsResource(NSString *relativePath) {
    static NSString *documentsPath = nil;
    if (nil == documentsPath) {
        NSArray *dirs = NSSearchPathForDirectoriesInDomains(
                NSDocumentDirectory, NSUserDomainMask, YES);
        documentsPath = [dirs objectAtIndex:0];
    }
    return [documentsPath stringByAppendingPathComponent:relativePath];
}
