//
// Created by enfeng on 13-5-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "Reachability.h"

@interface TBNetworkWrapperAdapter : NSObject {
    NSString *requestKey;
    NSInteger requestTimeOut;
    NetworkStatus networkStatus;
}
@property (nonatomic, retain) NSString* requestKey;
@property (nonatomic, assign) NSInteger requestTimeOut;
@property (nonatomic, assign) NetworkStatus networkStatus;
+ (TBNetworkWrapperAdapter*) sharedInstance;
@end