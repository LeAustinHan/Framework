//
// Created by enfeng on 13-5-19.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

#import "Network/TBASIFormDataRequest.h"

extern NSString *const TBRequestMethodGet;
extern NSString *const TBRequestMethodPost;
extern NSString *const TBRequestMethodPut;
extern NSString *const TBRequestMethodDelete;
extern NSString *const TBRequestMethodHEAD;
extern NSString *const TBServiceMethod;

@protocol TBBaseNetworkDelegate <NSObject>
@optional

/**
 *
 * @params
 *   key: error(Error*) optional
 *   key: methodFlag(NSNumber*)
 */
- (void)didNetworkError:(NSDictionary *)params;
@end

@interface TBNetworkWrapper : NSObject <ASIHTTPRequestDelegate> {
    NSString *requestKey;
    BOOL syn;
    __weak id <TBBaseNetworkDelegate> delegate;
    NSMutableArray *requestArray;
}

@property(nonatomic, copy) NSString *requestKey;
@property(nonatomic, assign) BOOL syn;
@property(nonatomic, strong) NSMutableArray *requestArray;
@property(nonatomic, weak) id <TBBaseNetworkDelegate> delegate;

- (NSString *)appendRequestKeyWithUrl:(NSString *)urlStr;

- (void)send:(TBASIFormDataRequest *)request;

- (void)sendWithoutRequestKey:(TBASIFormDataRequest *)request;

- (void)requestFinished:(TBASIFormDataRequest *)pRequest;

- (void)requestFailed:(TBASIFormDataRequest *)pRequest;

- (void)removeAllRequestFromArray;

- (BOOL)isHttpStatusOk:(ASIFormDataRequest *)pRequest;


/**
* 判断http请求是否正常，如果不正常则抛出异常
* 此时子类不用再进行解析
*/
- (BOOL)isResponseDidNetworkError:(ASIFormDataRequest *)request;

/**
* 通过url返回本地缓存数据
*/
- (NSString *)cachedResponseJSonStringForURL:(NSURL *)url;

- (void)setObjectPropertyValue:(NSObject *)obj value:(id)value forKey:(NSString *)key;

/**
* 发送GET请求
* 参数描述：
* @params urlStr
* @params params 页面方法中传入的参数
* @params methodFlag
* @params needAppendParams 是否需要追加参数
* @params requestMethod
* @params setRequestProperty 缓存策略等
*
*/
- (void)sendRequest:(NSString *)urlStr
             params:(NSDictionary *)params
         methodFlag:(int)flag
   needAppendParams:(BOOL)needAppendParams
      requestMethod:(NSString *)requestMethod
 setRequestProperty:(void (^)(TBASIFormDataRequest *request))setRequestProperty;

/**
* 封装url， 将params中的参数追加到url上
* 参数写法，如：key=[paras objectForKey:key]
*/
- (NSURL *)wrapperUrlForRequestMethodGet:(NSString *)urlStr params:(NSDictionary *)params;

- (void)wrapperPostRequest:(NSDictionary *)params request:(TBASIFormDataRequest *)request;

- (NSDictionary*) getResponseJsonResult:(ASIFormDataRequest *)request;
@end