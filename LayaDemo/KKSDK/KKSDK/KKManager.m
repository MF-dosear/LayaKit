//
//  KKManager.m
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKManager.h"

#import "KKManager+BK.h"

#import "KKNavVC.h"

#import <KKSDK/KKInfos.h>
#import "KKConfig.h"
#import "YXAuxView.h"
#import "AvoidCrash.h"
#import "YXNet+YX.h"
#import "LYFix.h"
#import "KKServiceVC.h"
#import "KKBindAccountVC.h"

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AppsFlyerLib/AppsFlyerLib.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBAudienceNetwork/FBAudienceNetwork.h>
#import <FirebaseCore/FirebaseCore.h>
#import <FirebaseMessaging/FirebaseMessaging.h>
#import "YXStatis.h"
#import <UserNotifications/UserNotifications.h>

#import "KKServiceApiVC.h"

#import "KKManager+Ad.h"
#import <AppLovinSDK/AppLovinSDK.h>

@interface KKManager ()<UNUserNotificationCenterDelegate,AppsFlyerLibDelegate,UNUserNotificationCenterDelegate,FIRMessagingDelegate>

@property (nonatomic, assign ,readwrite) id<KKDelegate> delegate;

@end

static NSString *const YXBUGCache  = @"YXBUGCache";

NSString *const kGCMMessageIDKey = @"gcm.message_id";

@implementation KKManager
singleton_implementation(KKManager)

/// 初始化
/// @param info 初始化参数
/// @param delegate 代理
+ (void)sdkInitWithInfo:(KKInfos *)info delegate:(id<KKDelegate>)delegate{
    
    if (info == nil) {
        YXLog(@"参数info为nil，初始化失败");
        return;
    }
    
    if (delegate == nil) {
        YXLog(@"参数delegate为nil，初始化失败");
        return;
    }
    
    // 禁用键盘调整
    [[IQKeyboardManager sharedManager] setEnable:false];
    
    // 设置代理
    KKManager *manager = [KKManager sharedKKManager];
    manager.delegate = delegate;
    
    // hud风格设置
    [KKManager hudStyle];
    
    // 激活开始
    [YXStatis uploadAction:statis_active_start];
    
    // 检测更新->初始化
    if (@available(iOS 14, *)) {
        
        // Set the flag as true.
        [FBAdSettings setAdvertiserTrackingEnabled:true];
        
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [YXNet checkVersion];
            })
            ;
        }];
        
    } else {
        // ios 14以下
        [YXNet checkVersion];
    }
    
    // 悬浮框实例化
    [YXAuxView sharedAux];
}

/// 提示框风格
+ (void)hudStyle{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
}

/// 登录
+ (void)sdkLoginWithAutomatic:(BOOL)automatic{
    
    KKConfig *config = [KKConfig sharedKKConfig];
    if (config.isInit == false) {

        // 初始化SDK
        [YXNet sdkInit];
        return;
    }
    
    [YXStatis uploadAction:statis_game_start_login];
    
    if (config.isLogin) {
        // 登录结果回调
        KKManager *manager = [KKManager sharedKKManager];
        if ([manager.delegate respondsToSelector:@selector(sdkLoginResult:userID:userName:session:isBind:)]) {
            
            BOOL isBind = config.isbindemail || config.isBindApple || config.isBindFb;
            [manager.delegate sdkLoginResult:true userID:config.uid userName:config.user_name session:config.sid isBind:isBind];
        } else {
            YXLog(@"sdkLoginResult回调未实现");
        }
        return;
    }
    
    // 第一次 自动登录
    BOOL first_login = [[NSUserDefaults objectForKey:@"first_login"] boolValue];
    if (first_login == false) {
        
        [YXNet autoLogin];
        [NSUserDefaults addValue:@(true) key:@"first_login"];
        return;
    }
    
    BOOL isAuto = [[NSUserDefaults objectForKey:YXAutoLoginCache] boolValue];
    if (automatic && isAuto){
        // 自动登录
        [YXNet autoLogin];
    } else {
        // 弹出登录框
        [YXNet showLoginView];
    }
}

/// 上传角色信息
/// @param info info
+ (void)sdkSubmitRole:(KKInfos *)info{
    
    if (info == nil) {
        YXLog(@"参数info为nil，初始化失败");
        return;
    }
    
    KKConfig *config = [KKConfig sharedKKConfig];
    if (config.isInit == false) {
        [YXHUD showErrorWithText:LocalizedString(@"Init Repeat")];
        return;
    }
    
    if (config.isLogin == false) {
        [YXHUD showInfoWithText:LocalizedString(@"UnLogin")];
        return;
    }
    
    [YXNet submitReloWithResult:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        
        [KKManager sdkSubmitRoleBack:isSuccess];
    }];
}

/// zhi付
/// @param info 订单信息
+ (void)sdkPsy:(KKInfos *)info{
    
    [YXNet psyState];
}

/// 退出登录
+ (void)sdkLoginOutBackFlag:(BOOL)flag{
    [KKManager sdkLoginOutBack:flag];
}

+ (void)sdkApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{

    //初始化AppsFlyer
    KKInfos *infos = [KKInfos sharedKKInfos];
    [AppsFlyerLib shared].appsFlyerDevKey = infos.appsFlyerKey;
    [AppsFlyerLib shared].appleAppID = infos.appsFlyerID;
    [AppsFlyerLib shared].delegate = instance;
    [AppsFlyerLib shared].isDebug = YXDebug;
    
    // facebook初始化
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:nil];
    
    // firebase初始化
    [FIRApp configure];
    
    // firebase推送
    [FIRMessaging messaging].delegate = instance;
    
    // iOS 10 or later
    // For iOS 10 display notification (sent via APNS)
    [UNUserNotificationCenter currentNotificationCenter].delegate = instance;
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
        UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter]
        requestAuthorizationWithOptions:authOptions
        completionHandler:^(BOOL granted, NSError * _Nullable error) {
          // ...
        }];

    [application registerForRemoteNotifications];
    
//    // 激励广告日志
//    [IronSource setAdaptersDebug:true];
    
    // IronSource广告初始化
//    [IronSource initWithAppKey:infos.ironSource_appkey adUnits:@[IS_REWARDED_VIDEO]];
    
    // 设置代理
//    [KKManager setIronSourceDelegate];
    
//    NSString *sdkVersion = [[GADMobileAds sharedInstance] sdkVersion];
//    NSLog(@"sdk_version = %@",sdkVersion);
    
//    [[GADMobileAds sharedInstance] startWithCompletionHandler:^(GADInitializationStatus * _Nonnull status) {
//
//        NSLog(@"广告：%@",status.adapterStatusesByClassName);
        
//        [instance loadRewardedAd];
//    }];
    
    NSString *fb_version = [[FBSDKSettings sharedSettings] sdkVersion];
    NSLog(@"fb_version = %@",fb_version);
    
//    NSString *lovin_version = [[AppLovin sharedSettings] sdkVersion];
//    NSLog(@"fb_version = %@",fb_version);

//    // 添加测试设备
//    [GADMobileAds sharedInstance].requestConfiguration.testDeviceIdentifiers = infos.testDeviceIdentifiers;
    
    if (@available(iOS 14, *)) {

        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {

            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {

                [FBSDKSettings sharedSettings].isAdvertiserTrackingEnabled = true;
            }else{
                [FBSDKSettings sharedSettings].isAdvertiserTrackingEnabled = false;
            }
        }];
    } else {
        [FBSDKSettings sharedSettings].isAdvertiserTrackingEnabled = true;
    }
    
    // AppLovin广告初始化
    // 请确保将中介提供程序值设置为@“max”，以确保功能正常。
    ALSdk *sdk = [ALSdk shared];
    sdk.mediationProvider = @"max";
    [sdk initializeSdkWithCompletionHandler:^(ALSdkConfiguration *configuration) {
        // AppLovin SDK已初始化，开始加载广告
        if (@available(iOS 14.5, *)){
            // 请注意，可以通过`sdkConfiguration.appTrackingTransparencyStatus检查应用程序透明度跟踪授权`
            // 1.在此处设置Meta ATE标志，然后
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [[KKManager sharedKKManager] loadRewardedAd];
        });
    }];
    
    // 要在代码中禁用广告素材调试器，请设置creativeDebuggerEnabled至NO或者false：
    [ALSdk shared].settings.creativeDebuggerEnabled = true;
    
    // 如果您不想启用受限数据使用 (LDU) 模式，请通过SetDataProcessingOptions()一个空数组：
    [FBAdSettings setDataProcessingOptions: @[]];
}

+ (void)sdkApplicationDidBecomeActive:(UIApplication *)application{
    // app启动
    [[AppsFlyerLib shared] start];
    [[FBSDKAppEvents shared] activateApp];
}

+ (BOOL)sdkApplication:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary *)options{
    
    [[AppsFlyerLib shared] handleOpenUrl:url options:options];
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
    return YES;
}

+ (BOOL)sdkApplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation{
    
    [[AppsFlyerLib shared] handleOpenURL:url sourceApplication:sourceApplication withAnnotation:annotation];
    [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
    return YES;
}

+ (BOOL)sdkApplication:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    
    [[AppsFlyerLib shared] continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
}

+ (void)sdkApplication:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    NSLog(@"APNs device token retrieved: %@", deviceToken);

    // With swizzling disabled you must set the APNs device token here.
    [[FIRMessaging messaging] setAPNSToken:deviceToken];
}

+ (void)sdkApplication:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [[AppsFlyerLib shared] handlePushNotification:userInfo];
}

#pragma mark -- FIRMessagingDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler __API_AVAILABLE(macos(10.14), ios(10.0), watchos(3.0), tvos(10.0)) {
    
  NSDictionary *userInfo = notification.request.content.userInfo;

  // With swizzling disabled you must let Messaging know about the message, for Analytics
   [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

  // [START_EXCLUDE]
  // Print message ID.
  if (userInfo[kGCMMessageIDKey]) {
    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
  }
  // [END_EXCLUDE]

  // Print full message.
  NSLog(@"%@", userInfo);

  // Change this to your preferred presentation option
  completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionAlert);
}

// Handle notification messages after display notification is tapped by the user.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
didReceiveNotificationResponse:(UNNotificationResponse *)response
         withCompletionHandler:(void(^)(void))completionHandler __API_AVAILABLE(macos(10.14), ios(10.0), watchos(3.0)) __API_UNAVAILABLE(tvos) {
  NSDictionary *userInfo = response.notification.request.content.userInfo;
  if (userInfo[kGCMMessageIDKey]) {
    NSLog(@"Message ID: %@", userInfo[kGCMMessageIDKey]);
  }

  // With swizzling disabled you must let Messaging know about the message, for Analytics
   [[FIRMessaging messaging] appDidReceiveMessage:userInfo];

  // Print full message.
  NSLog(@"%@", userInfo);

  completionHandler();
}

- (void)messaging:(FIRMessaging *)messaging
    didReceiveRegistrationToken:(NSString *)fcmToken{
    
    NSLog(@"FCM registration token: %@", fcmToken);
    // Notify about received token.
    NSDictionary *dataDict = [NSDictionary dictionaryWithObject:fcmToken forKey:@"token"];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     @"FCMToken" object:nil userInfo:dataDict];
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
    
    KKConfig *config = [KKConfig sharedKKConfig];
    config.FCMToken = fcmToken;
    
    [YXNet uploadFCMToken:fcmToken result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        YXLog(@"FCMToken : isSuccess = %d",isSuccess);
    }];
}

#pragma mark -- AppsFlyerLibDelegate
// AppsFlyerLib implementation
//Handle Conversion Data (Deferred Deep Link)
-(void)onConversionDataSuccess:(NSDictionary*) installData {
    
    id status = [installData objectForKey:@"af_status"];
    if([status isEqualToString:@"Non-organic"]) {
        id sourceID = [installData objectForKey:@"media_source"];
        id campaign = [installData objectForKey:@"campaign"];
        NSLog(@"This is a non-organic install. Media source: %@  Campaign: %@",sourceID,campaign);
    } else if([status isEqualToString:@"Organic"]) {
        NSLog(@"This is an organic install.");
    }
}
-(void)onConversionDataFail:(NSError *) error {
    NSLog(@"%@",error);
}
//Handle Direct Deep Link
- (void) onAppOpenAttribution:(NSDictionary*) attributionData {
    NSLog(@"%@",attributionData);
}
- (void) onAppOpenAttributionFailure:(NSError *)error {
    NSLog(@"%@",error);
}

/// 崩溃预防
+ (void)avoidCrash{
    
    // 防崩溃
    [AvoidCrash makeAllEffective];
    
    // 崩溃上报
    [[NSNotificationCenter defaultCenter] addObserver:[KKManager sharedKKManager] selector:@selector(dealwithCrashMessage:) name:AvoidCrashNotification object:nil];
    
    // 上报失败回查
    NSDictionary *info = [NSUserDefaults objectForKey:YXBUGCache];
    [instance uploadOldBug:info];
}

- (void)dealwithCrashMessage:(NSNotification *)note {
    
    NSString *errorName   = note.userInfo[@"errorName"];
    NSString *errorPlace  = note.userInfo[@"errorPlace"];
    NSString *errorReason = note.userInfo[@"errorReason"];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict addValue:errorName   key:@"errorName"];
    [dict addValue:errorPlace  key:@"errorPlace"];
    [dict addValue:errorReason key:@"errorReason"];
    
    [instance uploadOldBug:dict];
}

- (void)uploadOldBug:(NSDictionary *)info{
    
    if (info.allKeys.count == 0) {
        return;;
    }
    
    // 存bug数据
    [NSUserDefaults addValue:info key:YXBUGCache];
    
    NSString *info_text = [info jk_JSONString];
    [YXNet uploadBugInfo:info_text result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        
        if (isSuccess) {
            // 上报成功 移除
            [NSUserDefaults addValue:@{} key:YXBUGCache];
        }
    }];
}

/// 热修复
+ (void)hotfixWithAppleID:(NSString *)appleID{
    
    // 热修复
    [[KKManager sharedKKManager] hotfixMethodWithAppleID:appleID];
    
    // 热修复本地测试
//        [instance hotFixTest];
}

#pragma mark -- hotfix
- (void)hotfixMethodWithAppleID:(NSString *)appleID{

    [LYFix Fix];
    // 执行本地
    NSString *key = [NSString stringWithFormat:@"HotFix_%@",APPVERSION];
    
    NSArray *locaList = [NSUserDefaults objectForKey:key];
    if (locaList.count > 0) {

        [instance hotFixWithList:locaList];
    }

    [YXNet hotfixListWithAppleID:appleID result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        
        if (isSuccess) {
            if (locaList.count == 0) {
                // 本地没有，执行线上
                [instance hotFixWithList:data];
            }

            // 替换本地
            [NSUserDefaults addValue:data key:key];
        }
    }];
}

- (void)hotFixWithList:(NSArray *)list{

    if (list.count == 0) {
        return;
    }

    for (NSDictionary *info in list) {

        NSString *fixCode = info[@"code"];
        if ([fixCode isKindOfClass:[NSString class]] && fixCode.length > 0) {

            [LYFix evalString:fixCode];
        }
    }
}

/// 修复测试
- (void)hotFixTest{

    [LYFix Fix];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"LYHotFix" ofType:@"js"];
    NSString *js = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:js];
}

/// 上报事件
/// @param action 事件名
+ (void)sdkUploadAction:(NSString *)action{
    [YXStatis uploadAction:action];
}

/// 三方统计玩家数据
/// @param type type
/// @param price price 支付时候传参
+ (void)sdkPlayerDataWithType:(NSInteger)type price:(NSString *)price{
    [YXStatis playerDataWithType:type price:price];
}

/// 三方统计玩家游戏VIP等级
/// @param vipLevel vip等级
+ (void)sdkAchievedVIPLevelEvent:(NSString *)vipLevel{
    [YXStatis achievedVIPLevelEvent:vipLevel];
}

/// 三方openURL:options:completionHandler:玩家游戏等级
/// @param level 等级
+ (void)sdkAchievedLevelEvent:(NSString *)level{
    [YXStatis achievedLevelEvent:level];
}

/// 三方统计玩家支付数据
/// @param amount 金额
+ (void)sdkPaymentEvent:(NSString *)amount{
    [YXStatis paymentEvent:amount];
}

/// 资源开始下载
+ (void)sdkStartDownloadResource{
    [YXStatis startDownloadResource];
}

/// 资源下载完成
+ (void)sdkFinishDownloadResource{
    [YXStatis finishDownloadResource];
}

/// 开始解压
+ (void)sdkStartUnzipResource{
    [YXStatis startUnzipResource];
}

/// 解压完成
+ (void)sdkFinishUnzipResource{
    [YXStatis finishUnzipResource];
}

/// 浏览器打开页面
/// @param url 网页
+ (void)openUrl:(NSString *)url{
   
    if (url.length == 0) {
        return;
    }
    
    NSURL *URL = [NSURL URLWithString:url];
    
    [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
        
    }];
}

//+ (void)openAgreement{
//    // http://www.justinfinitelane.com/privacy.htm
//    // http://www.justinfinitelane.com/user.html
//    [KKManager openUrl:@"http://www.justinfinitelane.com/user.html"];
//}

/// 打开客服页面
+ (void)openServiceView{
    
    KKServiceApiVC *vc = [[KKServiceApiVC alloc] init];
    vc.isDismiss = true;
    [vc present];
    
//    KKServiceVC *vc = [[KKServiceVC alloc] init];
//    [SELFVC presentViewController:vc animated:true completion:nil];
    
//    KKServiceApiVC *vc = [[KKServiceApiVC alloc] init];
//    vc.isClose = true;
//    
//    KKNavVC *nvc = [[KKNavVC alloc] initWithRootViewController:vc];
//    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    nvc.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    nvc.mode = YXNavModeService;
//
//    [SELFVC presentViewController:nvc animated:true completion:nil];
}

/// 打开绑定
+ (void)openBindView{
    
    [YXStatis uploadAction:statis_bind_touch];

    KKBindAccountVC *vc = [[KKBindAccountVC alloc] init];
    [SELFVC presentViewController:vc animated:true completion:nil];
}

+ (void)sdkTrans:(NSString *)text lan:(NSString *)lan result:(void(^)(BOOL isSucccess, NSString *text))result{
    
    [YXNet trans:text lan:lan result:result];
}

/// 设置SDK语言
/// @param language 语言
+ (void)sdkSetLanguage:(NSString *)language{
    
    YXGAMELanguageMode mode = YXGAMELanguageModeEN;
    if ([language isEqualToString:@"zh"]) {
        mode = YXGAMELanguageModeCN;
    } else if ([language isEqualToString:@"zh_ft"]){
        mode = YXGAMELanguageModeTC;
    } else if ([language isEqualToString:@"jp"]){
        mode = YXGAMELanguageModeJP;
    } else if ([language isEqualToString:@"kr"]){
        mode = YXGAMELanguageModeKo;
    }
    
    [NSUserDefaults addValue:@(mode) key:YXGAMELanguageCache];
}

/// 获取存储语言语言
+ (NSString *)sdkGetCacheLanguage{
    
    YXGAMELanguageMode mode = [[NSUserDefaults objectForKey:YXGAMELanguageCache] integerValue];
    
    NSString *language = @"en";
    
    switch (mode) {
        case YXGAMELanguageModeEN: language = @"en";
            break;
        case YXGAMELanguageModeCN: language = @"zh";
            break;
        case YXGAMELanguageModeTC: language = @"zh_ft";
            break;
        case YXGAMELanguageModeJP: language = @"jp";
            break;
        case YXGAMELanguageModeKo: language = @"kr";
            break;
        default: language = [KKManager sdkGetSystemLanguage];
            break;
    }
    
    return language;
}

/// 获取当前系统语言
+ (NSString *)sdkGetSystemLanguage{
    
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *language = [languages firstObject];

    if ([language containsString:@"zh-Hans"]) {
        language = @"zh";
    } else if ([language containsString:@"zh-Hant"]){
        language = @"zh_ft";
    } else if ([language containsString:@"ja"]){
        language = @"jp";
    } else if ([language containsString:@"ko"]){
        language = @"kr";
    } else if ([language containsString:@"en"]){
        language = @"en";
    }
    
    return language;
}

+ (void)advTest{

}

+ (void)checkNet:(void (^)(NetStatus status))block{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (block) {
            NetStatus net_state;
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    net_state = NetStatusUnknown;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    net_state = NetStatusNotReachable;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    net_state = NetStatusReachableViaWWAN;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    net_state = NetStatusReachableViaWiFi;
                    break;
                default:
                    break;
            }
            block(net_state);
        }
    }];
    [manager startMonitoring];
}

/// 事件上报
/// @param event_name 事件名
/// @param jsonStr 一个Json字符串对应jsonStr字段
+ (void)wdEventToEs:(NSString *)event_name jsonStr:(NSString *)jsonStr{
    
    [YXNet uploadEvent:event_name play_session:@"" properties:jsonStr];
    
    NSDictionary *dict = [jsonStr jk_dictionaryValue];
    [YXStatis uploadAction:event_name params:dict];
}

/// 评论
+ (void)sdkRequestReview{
    [SKStoreReviewController requestReview];
}

+ (void)apiWithAppleID:(NSString *)appleID result:(YXApiBlock)result{
    [YXNet apiWithAppleID:appleID result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        if (isSuccess) {
            result(true,data);
        } else {
            result(false,@"");
        }
    }];
}

@end
