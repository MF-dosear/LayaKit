//
//  UIAlertController+YX.m
//  WSTDK
//
//  Created by Hello on 2020/8/19.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "UIAlertController+YX.h"

@implementation UIAlertController (YX)

+ (void)alertTitle:(NSString *)title msg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:LocalizedString(@"Done") style:UIAlertActionStyleDefault handler:handler];
    [alert addAction:action];
    [SELFVC presentViewController:alert animated:true completion:nil];
}

@end
