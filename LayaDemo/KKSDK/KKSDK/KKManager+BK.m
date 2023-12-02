//
//  KKManager+BK.m
//  WSTDK
//
//  Created by Hello on 2020/8/14.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKManager+BK.h"
#import "YXAuxView.h"
#import <FirebaseMessaging/FirebaseMessaging.h>
#import "YXNet+YX.h"
#import "KKManager+Apple.h"

@implementation KKManager (YX)

+ (void)sdkInitBack:(BOOL)flag{
    if (flag) {
        [KKConfig sharedKKConfig].isInit = true; // 初始化成功
        
        // 苹果psy监听
        [KKManager addTransactionObserver];
        
        // 苹果订单记录
        [KKManager createApplePsyDatabase];
        
        // 校验历史订单
        [KKManager checkReceipts];
        
        [YXStatis uploadAction:statis_active_suc];
        
        // 初始化成功 心跳
        [NSTimer scheduledTimerWithTimeInterval:30 repeats:true block:^(NSTimer * _Nonnull timer) {
            [YXNet head];
        }];
    } else {
        [YXStatis uploadAction:statis_active_fail];
    }
    // 初始化结果回调
    KKManager *manager = [KKManager sharedKKManager];
    if ([manager.delegate respondsToSelector:@selector(sdkInitResult:)]) {
        [manager.delegate sdkInitResult:flag];
    } else {
        YXLog(@"sdkInitResult回调未实现");
    }
}

+ (void)sdkLoginBack:(BOOL)flag{
    
    KKManager *manager = [KKManager sharedKKManager];
    
    KKConfig *config = [KKConfig sharedKKConfig];
    if (flag) {
        config.isLogin = true; // 登录成功
        // 登录成功 存信息
        [config saveUser];
        // 展示悬浮框
        [YXAuxView showAux];
        
        // 推送
        KKInfos *info = [KKInfos sharedKKInfos];
        // 上报FCMToken
        [YXNet uploadFCMToken:config.FCMToken result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
            YXLog(@"FCMToken : isSuccess = %d",isSuccess);
        }];
        // 设置主题
        [[FIRMessaging messaging] subscribeToTopic:info.link_suffix
                                        completion:^(NSError * _Nullable error) {
          NSLog(@"Subscribed to weather topic");
        }];
        
        [YXStatis uploadAction:statis_login_suc_callback];
        
        [NSUserDefaults addValue:@(true) key:YXAutoLoginCache];
        
        // 登录成功统计
        [YXNet uploadEventMode:EventMode_login_success];
    }
    // 登录结果回调
    
    if ([manager.delegate respondsToSelector:@selector(sdkLoginResult:userID:userName:session:isBind:)]) {
        
        BOOL isBind = config.isbindemail || config.isBindApple || config.isBindFb;
        [manager.delegate sdkLoginResult:flag userID:config.uid userName:config.user_name session:config.sid isBind:isBind];
    } else {
        YXLog(@"sdkLoginResult回调未实现");
    }
}

+ (void)sdkSubmitRoleBack:(BOOL)flag{
    
    // 上传角色结果回调
    KKManager *manager = [KKManager sharedKKManager];
    if ([manager.delegate respondsToSelector:@selector(sdkSubmitRoleResult:)]) {
        [manager.delegate sdkSubmitRoleResult:flag];
    } else {
        YXLog(@"sdkSubmitRoleResult回调未实现");
    }
}

+ (void)sdkPsyBack:(BOOL)flag{
    // 支付结果回调
    KKManager *manager = [KKManager sharedKKManager];
    if ([manager.delegate respondsToSelector:@selector(sdkPsyResult:)]) {
        [manager.delegate sdkPsyResult:flag];
    } else {
        YXLog(@"sdkPsyResult回调未实现");
    }
}

+ (void)sdkLoginOutBack:(BOOL)flag{
    
    KKConfig *config = [KKConfig sharedKKConfig];
    // 移除所有缓存信息
    [config removeAllInfo];
    // 隐藏悬浮框
    [YXAuxView hiddenAux];
    
    if (flag) {
        
        [NSUserDefaults addValue:@(false) key:YXAutoLoginCache];
        
        // 退出登录结果回调
        KKManager *manager = [KKManager sharedKKManager];
        if ([manager.delegate respondsToSelector:@selector(sdkLoginOutResult:)]) {
            [manager.delegate sdkLoginOutResult:true];
        } else {
            YXLog(@"sdkLoginOutResult回调未实现");
        }
    }
}

+ (void)sdkBindBack:(BOOL)flag{
     
     // 绑定结果回调
     KKManager *manager = [KKManager sharedKKManager];
     if ([manager.delegate respondsToSelector:@selector(sdkBindResult:)]) {
         [manager.delegate sdkBindResult:flag];
     } else {
         YXLog(@"sdkBindResult回调未实现");
     }
}

+ (void)sdkShowReward:(NSInteger)code{
    KKManager *manager = [KKManager sharedKKManager];
    if ([manager.delegate respondsToSelector:@selector(sdkShowRewardBack:)]) {
        [manager.delegate sdkShowRewardBack:code];
    } else {
        YXLog(@"sdkRewardedAdLoadFail回调未实现");
    }
}

@end
