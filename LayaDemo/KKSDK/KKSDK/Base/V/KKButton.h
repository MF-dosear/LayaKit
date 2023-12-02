//
//  KKButton.h
//  WSTDK
//
//  Created by Hello on 2020/8/7.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKButton : UIButton

+ (instancetype)button:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)smallButton:(NSString *)title target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
