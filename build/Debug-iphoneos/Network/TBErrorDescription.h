//
//  TBErrorDescription.h
//  TBUI
//
//  Created by enfeng on 14-1-10.
//  Copyright (c) 2014年 com.tuan800.framework.ui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBErrorDescription : NSObject {
    int _errorCode;
    NSString *_errorMessage;
    
    NSObject *_userInfo; //用户自定义信息
}
@property (nonatomic) int errorCode;
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) NSObject *userInfo;
@end
