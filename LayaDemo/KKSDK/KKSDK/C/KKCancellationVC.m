//
//  KKCancellationVC.m
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKCancellationVC.h"
#import "KKManager+BK.h"
#import "YXAuxView.h"

@interface KKCancellationVC ()

@end

@implementation KKCancellationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.backBtn removeFromSuperview];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = LocalizedString(@"Cancel account?");
    label.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    label.numberOfLines = 0;
    label.textColor = TEXT_COLOR_C;
    [self.view addSubview:label];
    
    KKButton *btn1 = [KKButton button:LocalizedString(@"Done") target:self action:@selector(doneAction)];
    [self.view addSubview:btn1];
    
    KKButton *btn2 = [KKButton button:LocalizedString(@"Cancel") target:self action:@selector(cancleAction)];
    [self.view addSubview:btn2];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(MAINBTNHEIGHT);
        make.bottom.mas_equalTo(-55);
    
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(btn2.mas_left).offset(-20);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(MAINBTNHEIGHT);
        make.bottom.mas_equalTo(-55);
        
        make.right.mas_equalTo(-50);
        make.width.mas_equalTo(btn1.mas_width);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(TEXTLEFTSPACE);
        make.right.mas_equalTo(-TEXTLEFTSPACE);
        make.top.mas_equalTo(self.titleImage.mas_bottom).offset(20);
        make.bottom.mas_equalTo(btn1.mas_top).offset(0);
    }];
}

// 取消
- (void)cancleAction{
    [self dismissViewControllerAnimated:false completion:^{
        [self.vc present];
    }];
}

// 确定
- (void)doneAction{
    
    [self dismissViewControllerAnimated:false completion:^{
        
        [KKManager sdkLoginOutBack:true];
        
        // 交互不禁用
        YXAuxView *aux = [YXAuxView sharedAux];
        aux.userInteractionEnabled = true;
    }];
}

@end
