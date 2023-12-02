//
//  KKApiVC+Funcs.h
//  WSTDK
//
//  Created by Hello on 2020/8/17.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKApiVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKApiVC (Funcs)

// 修改密码
- (void)resetPassWord:(NSString *)newPwd name:(NSString*)name state:(NSString *)state msg:(NSString *)msg;

// fb登录
- (void)fbLoginWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
