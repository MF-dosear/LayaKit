//
//  JSBridge+platform.h
//  LayaKit
//
//  Created by Mini2 on 2021/7/3.
//  Copyright © 2021 LayaKit. All rights reserved.
//

#import "JSBridge.h"
#import "Config.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSBridge (platform)<KKDelegate>

//初始化
+(void)sdkInit;
//登录
+(void)sdkLogin;
//登出
+(void)sdkLoginOut:(NSString *)showLoginUI;
//上传角色信息
+(void)sdkSubmitRole:(NSString * )par;
//购买
+(void)sdkPsy:(NSString *)par;
// 激励广告
+ (void)showRewardedAd;
+ (void)sdkShowRewardedAd;
+ (void)sdkShowRewardedAd:(NSString *)adUnitId;
// 评论
+ (void)sdkShowReview;
//统计事件
+(void)sdkEvent:(NSString *)eventName;
//统计事件
+(void)sdkEvent:(NSString *)eventName method2:(NSString *)jsonStr;
//分享
+(void)share:(NSString *)par;
//绑定账号
+(void)sdkBind;
//获取系统语言
+(void)sdkGetSysLang;
//游戏存储语言
+(void)sdkSetGameLang:(NSString *)lang;
//游戏获取储存语言
+(void)sdkGetGameLang;
//跳转浏览器 比如 社区、用户协议等
+(void)sdkToBrowser:(NSString *)str;
//弹出SDK联系客服页面
+(void)sdkShowCusService;
//分配加载广告id
+(void)sdksetupAD:(NSString *)str;
// 重启
+(void)sdkExitGameAndRestart;
// 翻译
+ (void)sdkTranslateForGoogle:(NSString *)jsonStr;

@end

NS_ASSUME_NONNULL_END
