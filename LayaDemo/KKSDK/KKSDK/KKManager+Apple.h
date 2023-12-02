//
//  KKManager+Apple.h
//  WSTDK
//
//  Created by Hello on 2020/8/18.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <KKSDK/KKSDK.h>

#import <StoreKit/StoreKit.h>
#import <StoreKit/SKPaymentTransaction.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKManager (Apple)<SKPaymentTransactionObserver,SKProductsRequestDelegate>

/// 创建苹果支付订单信息
+ (void)createApplePsyDatabase;

/// 添加苹果监听
+ (void)addTransactionObserver;

/// 发起内购请求
/// @param proId 商品id
+ (void)toPsyWithProductId:(NSString *)proId;

/// 复制到剪切板
/// @param text 复制内容
/// @param msg 提示
+ (void)copyWithText:(NSString *)text msg:(NSString *)msg;

/// 校验漏单
+ (void)checkReceipts;

@end

NS_ASSUME_NONNULL_END
