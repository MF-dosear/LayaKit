//
//  PQGAMEDelegate.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KKDelegate <NSObject>

@optional
/// 初始化回调
/// @param flag 结果 true：成功 flase：失败
- (void)sdkInitResult:(BOOL)flag;

/// 登录回调
/// @param flag 结果 true：成功 flase：失败
/// @param userID userID
/// @param userName userName
/// @param session session
- (void)sdkLoginResult:(BOOL)flag userID:(NSString *)userID userName:(NSString *)userName session:(NSString *)session isBind:(BOOL)isBind;

/// 上传角色回调
/// @param flag 结果 true：成功 flase：失败
- (void)sdkSubmitRoleResult:(BOOL)flag;

/// 支fu回调
/// @param flag 结果 true：成功 flase：失败
- (void)sdkPsyResult:(BOOL)flag;

/// 退出登录回调
/// @param flag 结果 true：成功 flase：失败
- (void)sdkLoginOutResult:(BOOL)flag;

/// 绑定回调
/// @param flag 结果 true：成功 flase：失败
- (void)sdkBindResult:(BOOL)flag;

/// 广告回调
- (void)sdkShowRewardBack:(NSInteger)code;

@end

NS_ASSUME_NONNULL_END
