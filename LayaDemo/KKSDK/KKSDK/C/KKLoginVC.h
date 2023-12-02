//
//  KKLoginVC.h
//  WSTDK
//
//  Created by Hello on 2020/8/7.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, OVLoginMode) {
    OVLoginModeApple,
    OVLoginModeFacebook,
    OVLoginModeEmail,
};

@interface KKLoginVC : KKBaseVC

- (void)loginWithPlatform:(NSInteger)platform nickname:(NSString *)nickname openId:(NSString *)openId email:(NSString *)email token_for_business:(NSString *)token_for_business code:(NSString *)code mode:(OVLoginMode)mode;

@end

NS_ASSUME_NONNULL_END
