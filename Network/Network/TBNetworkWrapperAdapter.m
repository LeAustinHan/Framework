//
// Created by enfeng on 13-5-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "TBNetworkWrapperAdapter.h"

@implementation TBNetworkWrapperAdapter

@synthesize requestKey;
@synthesize requestTimeOut;
@synthesize networkStatus;

#pragma mark -
#pragma mark Singleton Methods

- (id)init
{
    self = [super init];
    if (self) {
        self.requestTimeOut = 15;//超时，默认
    }
    return self;
}

+ (TBNetworkWrapperAdapter*)sharedInstance {
    static TBNetworkWrapperAdapter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

#pragma mark -
#pragma mark Custom Methods

// Add your custom methods here

@end