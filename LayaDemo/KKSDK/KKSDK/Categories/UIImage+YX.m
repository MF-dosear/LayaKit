//
//  UIImage+YX.m
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "UIImage+YX.h"

@implementation UIImage (YX)

+ (UIImage *)imageBundleNamed:(NSString *)bundleName {
    
    NSBundle *bundle = [NSBundle bundle];
    NSString *filePath = [[bundle resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", bundleName]];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if (data) {
        return [UIImage imageWithData:data];
    } else {
        return [UIImage imageNamed:bundleName inBundle:bundle compatibleWithTraitCollection:nil];
    }
}

@end
