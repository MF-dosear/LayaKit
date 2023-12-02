//
//  KKManager+Ad.m
//  Foxs
//
//  Created by Paul on 2023/6/25.
//  Copyright © 2023 YXQ. All rights reserved.
//

#import "KKManager+Ad.h"
#import "KKManager+BK.h"

@implementation KKManager (Ad)

- (MARewardedAd *)rewardedAd{

    id typeValue = objc_getAssociatedObject(self, CacheRewardedAdKey);
    return (MARewardedAd *)typeValue;
}


- (void)setRewardedAd:(MARewardedAd *)rewardedAd{

    objc_setAssociatedObject(self, CacheRewardedAdKey, rewardedAd, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)loadRewardedAd{

    KKInfos *infos = [KKInfos sharedKKInfos];
    
    if (self.rewardedAd == nil){
        // 实例化广告
        self.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:infos.rewardedAdID];
        self.rewardedAd.delegate = self;
    }

    // 加载广告
    [self.rewardedAd loadAd];
}

+ (void)sdkShowRewardedAd:(NSString *)adUnitId{
    KKInfos *infos = [KKInfos sharedKKInfos];
    if ([infos.rewardedAdID isEqualToString:adUnitId]){
        
        [KKManager sdkShowRewardedAd];
    } else {
        infos.rewardedAdID = adUnitId;
        
        KKManager *manager = [KKManager sharedKKManager];
        // 实例化广告
        manager.rewardedAd = [MARewardedAd sharedWithAdUnitIdentifier:infos.rewardedAdID];
        manager.rewardedAd.delegate = manager;
        // 加载广告
        [manager.rewardedAd loadAd];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [KKManager sdkShowRewardedAd];
        });
    }
}

+ (void)sdkShowRewardedAd{
    
    // 点击rewarded广告
    KKManager *manager = [KKManager sharedKKManager];

    if ([manager.rewardedAd isReady]){
        /// 广告加载成功
        [manager.rewardedAd showAd];
    } else {
        /// 广告加载失败
        [manager.rewardedAd loadAd];
        [KKManager sdkShowReward:1];
    }
}

- (void)didLoadAd:(nonnull MAAd *)ad {
    
}

- (void)didClickAd:(nonnull MAAd *)ad {
    
}

- (void)didDisplayAd:(nonnull MAAd *)ad {
    // 当显示全屏广告时候
    [KKManager sdkShowReward:2];
}

- (void)didFailToDisplayAd:(nonnull MAAd *)ad withError:(nonnull MAError *)error {
    // 播放失败
    [KKManager sdkShowReward:3];
    [self.rewardedAd loadAd];
}

- (void)didFailToLoadAdForAdUnitIdentifier:(nonnull NSString *)adUnitIdentifier withError:(nonnull MAError *)error {
    
    [self.rewardedAd loadAd];
}

- (void)didHideAd:(nonnull MAAd *)ad {
    // 关闭广告
    [KKManager sdkShowReward:5];
    [self.rewardedAd loadAd];
}

- (void)didCompleteRewardedVideoForAd:(nonnull MAAd *)ad {
    // 播放完成
    [KKManager sdkShowReward:4];
}

- (void)didRewardUserForAd:(nonnull MAAd *)ad withReward:(nonnull MAReward *)reward {
    // 发放奖励
    [KKManager sdkShowReward:6];
}

- (void)didStartRewardedVideoForAd:(nonnull MAAd *)ad {
    
}

+ (void)sdkAdvTest{
    [[ALSdk shared] showMediationDebugger];
}


@end
