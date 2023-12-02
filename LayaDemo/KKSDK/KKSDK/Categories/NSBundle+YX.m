//
//  NSBundle+YX.m
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "NSBundle+YX.h"
#import "KKManager.h"

@implementation NSBundle (YX)

+ (instancetype)bundle{
    
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:kFBundleNamePath withExtension:@"bundle"];
    return [NSBundle bundleWithURL:fileUrl];
}

+ (NSString *)localizedString:(NSString *)text{
    
    YXGAMELanguageMode mode = [[NSUserDefaults objectForKey:YXGAMELanguageCache] integerValue];
    
    NSString *language;
    if (mode == YXGAMELanguageModeSystem) {
        
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        language = [languages firstObject];
        
        if ([language containsString:@"zh-Hans"]) {
            language = @"zh-Hans";
        } else if ([language containsString:@"zh-Hant"]){
            language = @"zh-Hant";
        } else if ([language containsString:@"ja"]){
            language = @"ja";
        } else if ([language containsString:@"ko"]){
            language = @"ko";
        } else {
            language = @"en";
        }
    } else {
        switch (mode) {
            case YXGAMELanguageModeEN: language = @"en";
                break;
            case YXGAMELanguageModeCN: language = @"zh-Hans";
                break;
            case YXGAMELanguageModeTC: language = @"zh-Hant";
                break;
            case YXGAMELanguageModeJP: language = @"ja";
                break;
            case YXGAMELanguageModeKo: language = @"ko";
                break;
            default: language = @"en";
                break;
        }
    }
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.bundle/%@.lproj",kFBundleNamePath,language]];
    NSURL *url = [NSURL fileURLWithPath:bundlePath];
    NSBundle *bundle = [NSBundle bundleWithURL:url];
    NSString *loca = [bundle localizedStringForKey:text value:nil table:@"Localizable"];
    
    return loca;
}

@end
