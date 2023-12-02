//
//  YXHUD.m
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "YXHUD.h"

@implementation YXHUD

+ (void)show{
    [SVProgressHUD show];
}

+ (void)dismiss{
    [SVProgressHUD dismiss];
}

+ (void)showInfoWithText:(NSString*)text{
    [YXHUD showInfoWithText:text completion:^{
        
    }];
}

+ (void)showWarnWithText:(NSString*)text{
    [YXHUD showWarnWithText:text completion:^{
        
    }];
}

+ (void)showSuccessWithText:(NSString*)text{
    [YXHUD showSuccessWithText:text completion:^{
        
    }];
}

+ (void)showErrorWithText:(NSString*)text{
    [YXHUD showErrorWithText:text completion:^{
        
    }];
}

+ (void)showInfoWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD showInfoWithStatus:text];
    [YXHUD dismissDelayWithCompletion:completion];
}

+ (void)showWarnWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD showImage:[IMAGE(@"icon_warn_hud") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] status:text];
    [YXHUD dismissDelayWithCompletion:completion];
}

+ (void)showSuccessWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD showImage:IMAGE(@"icon_success_hud") status:text];
    [YXHUD dismissDelayWithCompletion:completion];
}

+ (void)showErrorWithText:(NSString*)text completion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD showImage:IMAGE(@"icon_fail_hud") status:text];
    [YXHUD dismissDelayWithCompletion:completion];
}

+ (void)dismissDelayWithCompletion:(SVProgressHUDDismissCompletion)completion{
    
    [SVProgressHUD dismissWithDelay:1.6 completion:completion];
}

+ (void)checkError:(YXError *)error{
    [YXHUD showErrorWithText:error.describe];
}

+ (void)checkError:(YXError *)error completion:(SVProgressHUDDismissCompletion)completion{
    [YXHUD showErrorWithText:error.describe completion:completion];
}

@end
