//
//  NSMutableDictionary+YX.m
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "NSMutableDictionary+YX.h"

@implementation NSMutableDictionary (YX)

- (void)addValue:(id)value key:(id)key{
    if (value == nil || key == nil) {
        YXLog(@"NSMutableDictionary参数:key=%@,value=%@不存在，添加空字符串到NSMutableDictionary",key,value);
        [self setObject:@"" forKey:key];
        return;
    }
    
    [self setObject:value forKey:key];
}

@end
