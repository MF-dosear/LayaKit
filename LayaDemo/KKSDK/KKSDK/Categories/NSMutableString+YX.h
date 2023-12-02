//
//  NSMutableString+YX.h
//  WSTDK
//
//  Created by Hello on 2020/8/12.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (YX)

/// 特殊字符处理
- (NSString *)encodeUrl;

@end

NS_ASSUME_NONNULL_END
