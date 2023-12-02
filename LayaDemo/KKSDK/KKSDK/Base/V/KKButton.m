//
//  KKButton.m
//  WSTDK
//
//  Created by Hello on 2020/8/7.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKButton.h"

@implementation KKButton

+ (instancetype)button:(NSString *)title target:(id)target action:(SEL)action{
    KKButton *btn = [KKButton buttonWithType:UIButtonTypeCustom];
//    [btn setBackgroundImage:IMAGE(@"sdk_button") forState:0];
    [btn setBackgroundColor:TEXT_COLOR];
    [btn setTitle:title forState:0];
    [btn setTitleColor:WhiteColor forState:0];
    btn.titleLabel.font = FONTNAME(18);
    btn.titleLabel.adjustsFontSizeToFitWidth = true;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = true;
    return btn;
}

+ (instancetype)smallButton:(NSString *)title target:(id)target action:(SEL)action{
    KKButton *btn = [KKButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    btn.titleLabel.font = FONTNAME(15);
    [btn setTitleColor:TEXT_COLOR forState:0];
    btn.titleLabel.adjustsFontSizeToFitWidth = true;
//    [btn setTitleColor:TEXT_COLOR_B forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end
