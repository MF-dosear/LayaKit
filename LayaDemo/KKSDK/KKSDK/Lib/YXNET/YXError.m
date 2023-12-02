//
//  YXError.m
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "YXError.h"

@implementation YXError

+ (instancetype)initWithCode:(NSString *)code{
    YXError *error = [[YXError alloc] init];
    error.code = code;
    return error;
}

@end
