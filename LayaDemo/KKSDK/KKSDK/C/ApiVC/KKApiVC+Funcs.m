//
//  KKApiVC+Funcs.m
//  WSTDK
//
//  Created by Hello on 2020/8/17.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKApiVC+Funcs.h"
#import "YXStatis.h"
#import "KKBaseVC.h"

@implementation KKApiVC (Funcs)

- (void)resetPassWord:(NSString *)newPwd name:(NSString*)name state:(NSString *)state msg:(NSString *)msg{
    
    if ([state isEqualToString:@"1"]) {
        
        if (name.length == 0 || newPwd.length == 0) {
            [YXHUD showErrorWithText:LocalizedString(@"Change pwd failed")];
            return;
        }

        // 存用户
        KKConfig *config = [KKConfig sharedKKConfig];
        config.pwd = newPwd;
        [config saveUser];
    }
    
    if(msg.length > 0){
        
        NSString *text = [msg stringByRemovingPercentEncoding];
        [YXHUD showInfoWithText:text];
    }
}

- (void)fbLoginWithText:(NSString *)text{
    
    NSDictionary *dict = [text jk_dictionaryValue];
    
    NSInteger isnew = [dict[@"isnew"] integerValue];
    
    if(isnew == 0){
        // 注册
        [YXStatis userRegistration:@"Facebook"];
    }
    
    NSInteger login_days = [dict[@"login_days"] integerValue];
    
    if (login_days == 1) {
        [YXStatis userLogin:YXStatisModeSecond];
    }else if (login_days == 3) {
        [YXStatis userLogin:YXStatisModeThree];
    }else if (login_days == 7) {
        [YXStatis userLogin:YXStatisModeSeven];
    }else if (login_days == 14) {
        [YXStatis userLogin:YXStatisModeFourteen];
    }else if (login_days == 30) {
        [YXStatis userLogin:YXStatisModeMonth];
    }
    
    [self loginWithName:dict[@"username"] pwd:dict[@"userpass"]];
}


@end
