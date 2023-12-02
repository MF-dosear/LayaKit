//
//  KKFatherVC.m
//  WSTDK
//
//  Created by dosear on 2021/4/9.
//  Copyright © 2021 YXQ. All rights reserved.
//

#import "KKFatherVC.h"

#import "YXStatis.h"
#import "KKManager+BK.h"

@interface KKFatherVC ()

@end

@implementation KKFatherVC

- (void)loginWithName:(NSString *)name pwd:(NSString *)pwd{
    
    WEAKSELF;
    [YXNet loginWithName:name pwd:pwd result:^(BOOL isSuccess, id  _Nullable data, YXError * _Nullable error) {
        
        if (isSuccess == true) {
            // 界面退出
            [weakSelf dismissViewControllerAnimated:true completion:^{
                
                // 登录成功
                [KKManager sdkLoginBack:true];
                
                [YXStatis uploadAction:statis_login_ui_click_close];
            }];
        }
    }];
}

@end
