//
//  HHBaseNetworkApi.h
//  ProjectAPI
//
//  Created by LeAustinHan on 14-4-23.
//  Copyright (c) 2014年 hanhan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Network/TBASIFormDataRequest.h"
#import "Network/TBNetworkWrapper.h"
#import "Network/ASIDownloadCache.h"

@class TBLogAnalysisBaseHeader;

extern NSString *const TBRequestMethodGet;
extern NSString *const TBServiceMethod;

enum {
    APIApnsSendDeviceToken = 10000,
    APIApnsSendUserDeviceInfo,
    
    APIAppUpdateGetUpdateVersion,
    
    APIFeedback,
    APIFeedbackV2,
    APIFeedbackReply, //获取对用户反馈信息进行回复的信息列表
    
    APIPassportLogin, //登陆
    APIPassportLogout, //注销
    APIPassportSignUp,  //注册
    APIPassportGetShortMessage, //获取短信验证码
    APIPassportVerifyShortMessage, //验证短信验证码
    APIPassportVerifyCode, //注册或修改密码收到的验证码
    APIPassportSendModifyPassword, //修改密码
    APIPassportBindPhone, //绑定手机
    APIPersonHistoryDealOrder,
    APIPassportSSORedirectToUrl,
    APIPassportUpdateUserCampus, // 更新用户校园信息
    
    APIPaymentCreateOrder,
    APIPaymentGetOrders,
    APIPaymentGetOrdersV6,
    APIPaymentGetOrderDetail,
    APIPaymentGetCouponCode,
    APIPaymentGetCouponIntro,
    APIPaymentGetPaymentAlixParams, //
    APIPaymentGetPaymentBankParams,
    APIPaymentGetPaymentAlixWapParams, //
    APIPaymentGetPaymentAlixWapSuccessParams,
    APIPaymentGetPaymentTenPayParams, //
    APIPaymentGetPaymentWeixinParams, //
    APIPaymentDeleteOrder,
    APIPaymentGetRefundOrder,
    APIPaymentGetResultCode,
    APIPaymentGetSuits,
    APIPaymentGetValidCoupons,
    APIPaymentSetOrderUsed,
    APIPaymentDeleteOrderV55,
    APIPaymentUploadPayResult,
    APIPaymentGetPayMethodByDealId,
    
    APILBSGetAddressByCoordinateGoogle,
    APILBSGetCoordinateByAddressGoogle,
    
    APIUserLogCommitBaseInfo,
    APIUserLogSendLog
};
@class TBErrorDescription;

@interface HHBaseNetworkApi : TBNetworkWrapper {
    
}

+ (void)setLLogAnalysisBaseHeader:(TBLogAnalysisBaseHeader *)header;

- (TBErrorDescription *)getErrorDescription:(ASIHTTPRequest *)request;

@end
