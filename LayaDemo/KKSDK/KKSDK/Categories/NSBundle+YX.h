//
//  NSBundle+YX.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const kFBundleNamePath = @"Frameworks/KKSDK.framework/images";

@interface NSBundle (YX)

+ (instancetype)bundle;

/// 本地化语言
+ (NSString *)localizedString:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
