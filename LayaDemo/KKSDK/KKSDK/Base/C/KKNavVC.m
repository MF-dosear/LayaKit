//
//  KKNavVC.m
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKNavVC.h"

@interface KKNavVC ()

@end

@implementation KKNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    CGFloat space = 20;
    
    if (self.mode == YXNavModeNormal) {
        
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.centerY.mas_equalTo(0);
            make.left.mas_offset(space);
            make.right.mas_offset(-space);
            make.height.mas_equalTo(BKHEIGHT);
        }];
    } else if (self.mode == YXNavModeService) {
        
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {

            make.centerY.mas_equalTo(0);
            make.left.mas_offset(space);
            make.right.mas_offset(-space);
            make.height.mas_equalTo(BKHEIGHT);
        }];
    } else {
        [self.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.left.mas_offset(space);
            make.right.mas_offset(-space);
            make.height.mas_equalTo(BKHEIGHT);
        }];
    }
    
    self.view.layer.cornerRadius = 5;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:true];
}

@end
