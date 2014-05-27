//
//  HHBaseNetworkApi.m
//  ProjectAPI
//
//  Created by LeAustinHan on 14-4-23.
//  Copyright (c) 2014年 hanhan. All rights reserved.
//

#import "HHBaseNetworkApi.h"

#import "TBErrorDescription.h"
#import "HHCoreMacros.h"
#import "TBLogAnalysisBaseHeader.h"

static TBLogAnalysisBaseHeader *logAnalysisHeader;

@implementation HHBaseNetworkApi

- (id)init {
    self = [super init];
    if (self) {
        //ll
    }
    
    return self;
}

+ (void)setLLogAnalysisBaseHeader:(TBLogAnalysisBaseHeader *)header {
    
    logAnalysisHeader = [header copy];
}

- (void)dealloc {
    
}


- (void)send:(TBASIFormDataRequest *)request {
    // 请求中增加user-agent参数
    
    if (logAnalysisHeader) {
        NSMutableString *str = [NSMutableString stringWithCapacity:6];
        [str appendString:@"tbbz"];
        [str appendFormat:@"|%@", logAnalysisHeader.appName];
        [str appendFormat:@"|%@", logAnalysisHeader.macAddress];
        [str appendFormat:@"|%@", logAnalysisHeader.platform];
        [str appendFormat:@"|%@", logAnalysisHeader.appVersion];
        [str appendFormat:@"|%@", logAnalysisHeader.partner];
        HHPRINT(@"User-Agent =%@", str);
        [request addRequestHeader:@"User-Agent" value:str];
    }
    
    [super send:request];
}

- (TBErrorDescription *) getErrorDescription :(ASIHTTPRequest *) request {
    TBErrorDescription *tbd = [[TBErrorDescription alloc] init];
    tbd.errorCode = request.responseStatusCode;
    tbd.errorMessage = request.error.description;
    
    if (tbd.errorCode>=400 && tbd.errorCode<500) {
        NSString *str = request.responseString;
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error = nil;
        NSDictionary *dict =
        [NSJSONSerialization JSONObjectWithData:data
                                        options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                          error:&error];
        tbd.userInfo = dict;
    }
    
    return tbd;
}

@end