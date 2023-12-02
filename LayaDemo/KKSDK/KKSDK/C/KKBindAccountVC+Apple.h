//
//  KKBindAccountVC+Apple.h
//  WSTDK
//
//  Created by dosear on 2021/8/2.
//  Copyright © 2021 YXQ. All rights reserved.
//

#import "KKBindAccountVC.h"

#import <AuthenticationServices/AuthenticationServices.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKBindAccountVC (Apple)<ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

/// apple 绑定
- (void)bindApple;

@end

NS_ASSUME_NONNULL_END
