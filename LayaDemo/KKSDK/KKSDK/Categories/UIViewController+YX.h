//
//  UIViewController+YX.h
//  WSTDK
//
//  Created by Hello on 2020/8/14.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YX)

/// 展示当前视图
- (void)present;

- (void)push:(UIViewController *)vc;

- (void)pop;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
