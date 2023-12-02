//
//  MQVC+method.m
//  MaQu
//
//  Created by Paul on 2023/8/22.
//

#import "MQVC+method.h"

@implementation MQVC (method)

- (void)checkNet{
    
    [KKManager checkNet:^(NetStatus status) {
        if (status == 1 || status == 2) {
            // 有网，重新加载
            if (self.isDidFinish == false) {
                [self requestUrl];
                self.isDidFinish = true;
            }
            UIViewController *vc = [KKCommon currentVC];
            if ([vc isKindOfClass:[UIAlertController class]]) {
                UIAlertController *alert = (UIAlertController *)vc;
                if ([alert.title isEqualToString:@"网络异常"]) {
                    [alert dismissViewControllerAnimated:true completion:nil];
                }
            }
        } else {
            // 没网，展示拦截页
            [self alert];
        }
    }];
}

- (void)alert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络异常" message:@"您的当前网络存在异常，请去检查网络" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:true completion:nil];
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            
        }];
    }];
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [[KKCommon currentVC] presentViewController:alert animated:true completion:nil];
}

@end
