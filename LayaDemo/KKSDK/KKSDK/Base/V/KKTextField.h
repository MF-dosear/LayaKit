//
//  KKTextField.h
//  WSTDK
//
//  Created by Hello on 2020/8/7.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXTextFieldMode) {
    YXTextFieldModeUserName,
    YXTextFieldModeEmail,
    YXTextFieldModePwd,
    YXTextFieldModeCode
};

@interface KKTextField : UITextField

- (instancetype)initWithMode:(YXTextFieldMode)mode;

- (UIButton *)addSendCodeWithTarget:(id)target action:(SEL)action;

- (UIButton *)addMoreWithTarget:(id)target action:(SEL)action;

- (void)addEyes;

- (BOOL)check;

@end

NS_ASSUME_NONNULL_END
