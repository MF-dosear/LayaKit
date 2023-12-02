//
//  KKManager.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <KKSDK/KKInfos.h>
#import <KKSDK/KKDelegate.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXGAMEShareMode) {
    YXGAMEShareModeWX,
    YXGAMEShareModeQQ
};

typedef NS_ENUM(NSUInteger, YXGAMELanguageMode) {
    /// 跟随系统
    YXGAMELanguageModeSystem = 0,
    /// 英文
    YXGAMELanguageModeEN,
    /// 简体中文
    YXGAMELanguageModeCN,
    /// 繁体中文
    YXGAMELanguageModeTC,
    /// 日文
    YXGAMELanguageModeJP,
    /// 韩语
    YXGAMELanguageModeKo,
};

typedef NS_ENUM(NSInteger, NetStatus) {
    /// 未知
    NetStatusUnknown          = -1,
    /// 无法访问
    NetStatusNotReachable     = 0,
    /// 蜂窝网
    NetStatusReachableViaWWAN = 1,
    /// WiFi
    NetStatusReachableViaWiFi = 2,
};

typedef void(^YXApiBlock)(BOOL isSuccess,NSString *api);

@interface KKManager : NSObject
singleton_interface(KKManager)

@property (nonatomic, assign ,readonly) id<KKDelegate> delegate;

/// 初始化
/// @param info 初始化参数
/// @param delegate 代理
+ (void)sdkInitWithInfo:(KKInfos *)info delegate:(id<KKDelegate>)delegate;

/// 登录
/// @param automatic 是否自动登录，true自动登录 flase弹框登录
+ (void)sdkLoginWithAutomatic:(BOOL)automatic;

/// 上传角色信息
/// @param info 角色信息
+ (void)sdkSubmitRole:(KKInfos *)info;

/// zhi付
/// @param info 订单信息
+ (void)sdkPsy:(KKInfos *)info;

/// 登出
/// @param flag 是否回调
+ (void)sdkLoginOutBackFlag:(BOOL)flag;

/// 崩溃预防
+ (void)avoidCrash;

/// 热修复
/// @param appleID 苹果ID
+ (void)hotfixWithAppleID:(NSString *)appleID;

+ (void)sdkApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+ (void)sdkApplicationDidBecomeActive:(UIApplication *)application;

+ (BOOL)sdkApplication:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options;

+ (BOOL)sdkApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation;

+ (BOOL)sdkApplication:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler;

+ (void)sdkApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

+ (void)sdkApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

/// 上报事件
/// @param action 事件名
+ (void)sdkUploadAction:(NSString *)action;

/// 三方统计玩家数据
/// @param type type
/// type = 1 , 首次购买月卡
/// type = 2 , 首充
/// type = 3 , 首次购买至尊卡
/// type = 4 , 完成新手指导
/// type = 5 , 完成新角色创建
/// type = 6 , 加载资源，初始资源loading完毕
/// type = 7 , 进入游戏，玩家成功进入游戏
/// type = 8 , 点击计费点，点击游戏内任意计费点
/// type = 9 , 游戏内-军团，申请加入或创建军团
/// type = 10 , af的购买事件
/// type = 11 , 开始新手流程
/// type = 12 , 开始新手流程
/// type = 13 , 创角首日累充达到29.99
/// type = 14 , 创建账号当日领取4.99月卡（首日月卡4.99）
+ (void)sdkPlayerDataWithType:(NSInteger)type price:(NSString *)price;

/// 三方统计玩家游戏VIP等级
/// @param vipLevel vip等级
+ (void)sdkAchievedVIPLevelEvent:(NSString *)vipLevel;

/// 三方统计玩家游戏等级
/// @param level 等级
+ (void)sdkAchievedLevelEvent:(NSString *)level;

/// 三方统计玩家支付数据
/// @param amount 金额
+ (void)sdkPaymentEvent:(NSString *)amount;

/// 资源开始下载
+ (void)sdkStartDownloadResource;

/// 资源下载完成
+ (void)sdkFinishDownloadResource;

/// 开始解压
+ (void)sdkStartUnzipResource;

/// 解压完成
+ (void)sdkFinishUnzipResource;

/// 浏览器打开页面
/// @param url 网页
+ (void)openUrl:(NSString *)url;

/// 打开协议
//+ (void)openAgreement;

/// 打开客服页面
+ (void)openServiceView;

/// 打开绑定
+ (void)openBindView;

/// 系统分享
/// - Parameters:
///   - image: 图片
///   - url: 链接
///   - title: 标题
+ (void)sdkShareImage:(UIImage *)image url:(NSString *)url title:(NSString *)title;

/// 分享链接
/// @param url 链接
/// @param quote 文本
+ (void)sdkShareUrl:(NSString *)url quote:(NSString *)quote;

/// 分享图片
/// @param image 图片
+ (void)sdkShareImage:(UIImage *)image;

/// 分享视频
/// @param videoData videoData 视频资源
+ (void)sdkShareVideoData:(id)videoData;

/// 谷歌翻译 text:文本 language:语言 默认 en isSucces true成功 false失败
/// @param text 文本
/// @param lan 目标语种 默认 en 支持 中文：zh-CN 英文：en 西班牙语：es 葡萄牙语：pt
/// @param result 结果
+ (void)sdkTrans:(NSString *)text lan:(NSString *)lan result:(void(^)(BOOL isSucccess, NSString *text))result;

/// 设置SDK语言 zh、zh_ft、en、jp、kr
/// @param language 语言
+ (void)sdkSetLanguage:(NSString *)language;

/// 获取存储语言语言
+ (NSString *)sdkGetCacheLanguage;

/// 获取当前系统语言
+ (NSString *)sdkGetSystemLanguage;

/// 检查网络状态
/// @param block 回调
+ (void)checkNet:(void (^)(NetStatus status))block;

/// 事件上报
/// @param event_name 事件名
/// @param jsonStr 一个Json字符串对应jsonStr字段
+ (void)wdEventToEs:(NSString *)event_name jsonStr:(NSString *)jsonStr;

/// 评论
+ (void)sdkRequestReview;

/// 播放广告
+ (void)sdkShowRewardedAd;

/// 播放广告
+ (void)sdkShowRewardedAd:(NSString *)adUnitId;

/// 广告测试
+ (void)sdkAdvTest;

+ (void)apiWithAppleID:(NSString *)appleID result:(YXApiBlock)result;

@end

NS_ASSUME_NONNULL_END
