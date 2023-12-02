//
//  KKBaseVC.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKFatherVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface KKBaseVC : KKFatherVC

//@property (nonatomic, strong) UIImageView *imgView; // 背景

@property (nonatomic, strong) UIImageView *titleImage; // 标题

@property (nonatomic, strong) UIButton *backBtn; // 返回

/// pop返回模式
- (void)back;

- (void)updateBackBtn;

- (void)openUrl:(NSString *)url text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
