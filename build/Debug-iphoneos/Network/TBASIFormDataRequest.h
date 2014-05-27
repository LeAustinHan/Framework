//
//  TBASIFormDataRequest.h
//  Core
//
//  Created by enfeng yang on 12-1-10.
//  Copyright (c) 2012年 mac. All rights reserved.
//

#import <Foundation/Foundation.h> 
#import "ASIFormDataRequest.h"

@interface TBASIFormDataRequest : ASIFormDataRequest {
    NSInteger serviceMethodFlag;
    NSObject *serviceData;
}
@property(nonatomic, retain) NSObject *serviceData;
@property(nonatomic, assign) NSInteger serviceMethodFlag;
@end