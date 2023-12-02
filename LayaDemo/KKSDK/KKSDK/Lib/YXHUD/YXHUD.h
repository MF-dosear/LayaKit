//
//  YXHUD.h
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "SVProgressHUD.h"
#import "YXError.h"

NS_ASSUME_NONNULL_BEGIN

@interface YXHUD : NSObject

+ (void)show;

+ (void)dismiss;

+ (void)showInfoWithText:(NSString*)text;

+ (void)showWarnWithText:(NSString*)text;

+ (void)showSuccessWithText:(NSString*)text;

+ (void)showErrorWithText:(NSString*)text;

+ (void)showInfoWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showWarnWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showSuccessWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)showErrorWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion;

+ (void)dismissDelayWithCompletion:(SVProgressHUDDismissCompletion)completion;

+ (void)checkError:(YXError *)error;

+ (void)checkError:(YXError *)error completion:(SVProgressHUDDismissCompletion)completion;

@end

NS_ASSUME_NONNULL_END
