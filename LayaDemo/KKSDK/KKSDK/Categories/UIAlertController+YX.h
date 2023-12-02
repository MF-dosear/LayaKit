//
//  UIAlertController+YX.h
//  WSTDK
//
//  Created by Hello on 2020/8/19.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (YX)

+ (void)alertTitle:(NSString *)title msg:(NSString *)msg handler:(void (^)(UIAlertAction *action))handler;

@end

NS_ASSUME_NONNULL_END
