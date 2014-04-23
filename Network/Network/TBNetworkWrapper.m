//
// Created by enfeng on 13-5-19.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "ASIDownloadCache.h"
#import "TBNetworkWrapper.h"
#import "Network/TBNetworkWrapperAdapter.h"
#import "Core/Core.h"

NSString *const TBRequestMethodGet = @"GET";
NSString *const TBRequestMethodPost = @"POST";
NSString *const TBRequestMethodPut = @"PUT";
NSString *const TBRequestMethodDelete = @"DELETE";
NSString *const TBRequestMethodHEAD = @"HEAD";
NSString *const TBServiceMethod = @"serviceMethod";

@interface TBNetworkWrapper ()
- (void)removeRequestFromArray:(ASIHTTPRequest *)pRequest;

- (void)destroyRequestWithErrorCallback:(ASIHTTPRequest *)request;
@end

@implementation TBNetworkWrapper
@synthesize requestKey, syn;
@synthesize requestArray;
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        TBNetworkWrapperAdapter *adapterService = [TBNetworkWrapperAdapter sharedInstance];
        self.requestKey = adapterService.requestKey;
        self.requestArray = [NSMutableArray arrayWithCapacity:5];
    }

    return self;
}

- (void)setObjectPropertyValue:(NSObject *)obj value:(id)value forKey:(NSString *)key {
    NSString *setterStr = [NSString stringWithFormat:@"set%@%@:",
                           [[key substringToIndex:1] capitalizedString],
                           [key substringFromIndex:1]];
    
    if ([obj respondsToSelector:NSSelectorFromString(setterStr)]) {
        
        @try {
            if ([value isKindOfClass:[NSNull class]]) {
                [obj setValue:nil forKey:key];
            } else {
                [obj setValue:value forKey:key];
            }
        } @catch (NSException *ex) {
            HHPRINT(@">________类型不一致______属性设置失败：%@", key);
        }
        
    } else {
        HHPRINT(@">>>>>>>>>>>>>>>>>###>>>>>>>>>>>>>>>>>>>属性设置失败：%@", key);
    }
}


- (NSString *)appendRequestKeyWithUrl:(NSString *)urlStr {
    TBNetworkWrapperAdapter *adapterService = [TBNetworkWrapperAdapter sharedInstance];

    if (adapterService.requestKey == nil) {
        return urlStr;
    }

    NSRange aRange = [urlStr rangeOfString:@"requestKey"];
    if (aRange.location != NSNotFound) {
        return urlStr;
    }
    NSString *ret;
    aRange = [urlStr rangeOfString:@"?"];
    if (aRange.location == NSNotFound) {
        ret = [NSString stringWithFormat:@"%@?requestKey=%@", urlStr, adapterService.requestKey];
    } else {
        ret = [NSString stringWithFormat:@"%@&requestKey=%@", urlStr, adapterService.requestKey];
    }
    return ret;
}

- (void)send:(TBASIFormDataRequest *)request withRequestKey:(BOOL)rt {
    if (rt) {
        NSURL *url = [request url];
        NSString *urlStr = [url absoluteString];
        urlStr = [self appendRequestKeyWithUrl:urlStr];
        url = [NSURL URLWithString:urlStr];
        HHPRINT(@"send url api:%@", urlStr);

        request.url = url;
    }
    [requestArray addObject:request];

    TBNetworkWrapperAdapter *serviceAdapter = [TBNetworkWrapperAdapter sharedInstance];
//    if (serviceAdapter.networkStatus == kNotReachable) {
//        [self destroyRequestWithErrorCallback:request];
//        return;
//    }

    [request setTimeOutSeconds:serviceAdapter.requestTimeOut];
    request.numberOfTimesToRetryOnTimeout = 0;
    if (syn) {
        [request startSynchronous];
    } else {
        [request startAsynchronous];
    }
}

- (void)send:(TBASIFormDataRequest *)request {
    [self send:request withRequestKey:YES];
}

- (void)sendWithoutRequestKey:(TBASIFormDataRequest *)request {
    [self send:request withRequestKey:NO];
}

- (void)removeRequestFromArray:(ASIHTTPRequest *)pRequest {
    int inx = -1;
    for (ASIHTTPRequest *req in requestArray) {
        inx++;
        if (req == pRequest) {
            [req setDelegate:nil];
            [req cancel];
            [requestArray removeObjectAtIndex:inx];
            break;
        }
    }
}

- (void)removeAllRequestFromArray {
    if (!requestArray) {
        return;
    }
    for (TBASIFormDataRequest *req in requestArray) {
        [req setDelegate:nil];
        [req cancel];
    }
    [requestArray removeAllObjects];
}

#pragma mark ------------request delegate-------------
- (void)destroyRequestWithErrorCallback:(TBASIFormDataRequest *)request {
    NSNumber *flag = [NSNumber numberWithInt:request.serviceMethodFlag];
    [self removeRequestFromArray:request];

    if (delegate && [delegate respondsToSelector:@selector(didNetworkError:)]) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                flag, TBServiceMethod,
                request, @"request",
                nil];
        [delegate didNetworkError:dict];
        return;
    }
}

- (void)requestFinished:(TBASIFormDataRequest *)pRequest {
    @try {
        [self removeRequestFromArray:pRequest];
    }
    @catch (NSException *exception) {

    }
    @finally {

    }

}

- (void)requestFailed:(TBASIFormDataRequest *)pRequest {

    @try {
        [self destroyRequestWithErrorCallback:pRequest];
    }
    @catch (NSException *exception) {

    }
    @finally {

    }
}

- (BOOL)isHttpStatusOk:(ASIFormDataRequest *)pRequest {
    int status = pRequest.responseStatusCode;
    if (status >= 200 && status < 300) {
        return YES;
    }
    return NO;
}

- (BOOL)isResponseDidNetworkError:(ASIFormDataRequest *)request {
    int status = request.responseStatusCode;
    if (status >= 200 && status < 300) {
        return NO;
    }

    SEL sel = @selector(didNetworkError:);
    if ([request isKindOfClass:[TBASIFormDataRequest class]]) {
        TBASIFormDataRequest *request2 = (TBASIFormDataRequest*)request;
        
        NSNumber *flag = [NSNumber numberWithInt:request2.serviceMethodFlag];
        if (self.delegate && [self.delegate respondsToSelector:sel]) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  flag, TBServiceMethod,
                                  request2, @"request",
                                  nil];
            [self.delegate didNetworkError:dict];
        }
    }
    


    //不抛出异常了，否则会阻塞调试
//    NSException *exception = [NSException exceptionWithName:@"Invalid status code"
//                                                     reason:[NSString stringWithFormat:@"status code: %d is invalid", request.responseStatusCode]
//            userInfo:nil];
//    @throw exception;

//    [NSException raise:@"Invalid status code" format:@"status code: %d is invalid", request.responseStatusCode];
    return YES;
}

- (void)dealloc {
    [self removeAllRequestFromArray];
}

- (NSString *)cachedResponseJSonStringForURL:(NSURL *)url {
    ASIDownloadCache *sharedCache = [ASIDownloadCache sharedCache];

    NSData *data = [sharedCache cachedResponseDataForURL:url];
    NSString *jsonStr = nil;
    if (data) {
//        NSDictionary *dict = nil;
        jsonStr = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
//        @try {
//            dict = [jsonStr JSONValue];
//        }
//        @catch (NSException *exception) {
//
//        }
//        if (dict == nil) { //如果json转换失败, 则清除缓存数据
//            [sharedCache removeCachedDataForURL:url];
//        }
    }
    return jsonStr;
}

- (void)sendRequest:(NSString *)urlStr
             params:(NSDictionary *)params
         methodFlag:(int)flag
   needAppendParams:(BOOL)needAppendParams
      requestMethod:(NSString *)requestMethod
 setRequestProperty:(void (^)(TBASIFormDataRequest *request))setRequestProperty {

    BOOL isGet = [requestMethod isEqualToString:TBRequestMethodGet];
    BOOL isDelete = [requestMethod isEqualToString:TBRequestMethodDelete];
    BOOL isHead = [requestMethod isEqualToString:TBRequestMethodHEAD];

    BOOL isGetParams = NO;
    if (isGet || isDelete || isHead) {
        isGetParams = YES;
    }

    NSURL *url = nil;
    if (needAppendParams && isGetParams) {
        url = [self wrapperUrlForRequestMethodGet:urlStr params:params];
    } else {
        url = [NSURL URLWithString:urlStr];
    }

    TBASIFormDataRequest *request = [TBASIFormDataRequest requestWithURL:url];
    request.delegate = self;
    request.serviceMethodFlag = flag;
    [request setRequestMethod:requestMethod];
    request.serviceData = params;
    //支持gzip
    request.allowCompressedResponse = YES;

    //设置request属性
    setRequestProperty(request);

    if (needAppendParams && !isGetParams) {
        [self wrapperPostRequest:params request:request];
    }

    [self send:request];
}

- (NSURL *)wrapperUrlForRequestMethodGet:(NSString *)urlStr params:(NSDictionary *)params {
    if (params == nil || params.count < 1) {
        return [NSURL URLWithString:urlStr];
    }

    NSMutableArray *paramArr = [NSMutableArray arrayWithCapacity:params.count];
    for (NSString *key in params) {

        NSString *value = [params objectForKey:key];
        NSString *param = [NSString stringWithFormat:@"%@=%@", key, value];

        [paramArr addObject:param];
    }
    NSString *wrapperUrlString = [paramArr componentsJoinedByString:@"&"];
    NSRange range = [urlStr rangeOfString:@"?"];
    NSString *preStr = nil;

    if (range.length > 0) {
        preStr = @"&";
    } else {
        preStr = @"?";
    }
    wrapperUrlString = [NSString stringWithFormat:@"%@%@%@", urlStr, preStr, wrapperUrlString];
    wrapperUrlString = [wrapperUrlString urlEncoded];
    return [NSURL URLWithString:wrapperUrlString];
}

- (void)wrapperPostRequest:(NSDictionary *)params request:(TBASIFormDataRequest *)request {
    if (params == nil || params.count < 1) {
        return;
    }

    for (NSString *key in params) {
        NSString *value = [params objectForKey:key];
        [request setPostValue:value forKey:key];
    }
}

- (NSDictionary*) getResponseJsonResult:(ASIFormDataRequest *)request {
    NSDictionary *resultDict = nil;

    BOOL isError = [self isResponseDidNetworkError:request];
    if (isError) {
        ASIDownloadCache *sharedCache = [ASIDownloadCache sharedCache];
        [sharedCache removeCachedDataForURL:request.url];
        return resultDict;
    }

    NSString *dataStr = [request responseString];

    dataStr = [dataStr trim];

    @try {
        resultDict = [dataStr JSONValue];
    }
    @catch (NSException *exception) {
        resultDict = [NSDictionary dictionary];
        ASIDownloadCache *sharedCache = [ASIDownloadCache sharedCache];
        [sharedCache removeCachedDataForURL:request.url];
    }
    if (resultDict == nil) {
//        NSDictionary *rHeaders = request.responseHeaders;
//        NSString *str = [rHeaders objectForKey:@"Content-Type"];
//        if ([str rangeOfString:@"html"].length>0) {
//            HHPRINT(@"");
//        }
//        
        resultDict = [NSDictionary dictionary];
    }
    
    return resultDict;
}

@end