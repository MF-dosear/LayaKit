//
//  KKCommon.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKCommon : NSObject

/// 获取当前显示的ViewController
+ (UIViewController *)currentVC;

/// 去掉emoji
+(NSString *)pregReplaceEmojiWithString:(NSString *)string;

/// 获取一个唯一uuid
+ (NSString *)uuidWithKeychain;

/// 获取uuid
+ (NSString *)idfa;

/// 语言
+ (NSString *)language;

@end

NS_ASSUME_NONNULL_END
