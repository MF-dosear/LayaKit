//
//  KKCommon.m
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKCommon.h"

#import <AdSupport/AdSupport.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "KKManager.h"

NSString * const kUUIDKey = @"dosear.KKSDK.uuid";

@implementation KKCommon

+ (UIViewController *)currentVC{
    UIViewController *rootvc = [[UIApplication sharedApplication] delegate].window.rootViewController;
    UIViewController *vc = [KKCommon vcWithRootVC:rootvc];
    return vc;
}

+ (UIViewController *)vcWithRootVC:(UIViewController *)vc{
    UIViewController *currentVC = nil;
    UIViewController *rootVC = vc.presentedViewController;
    if (rootVC == nil) {
        return vc;
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tvc = (UITabBarController *)rootVC;
        currentVC = [KKCommon vcWithRootVC:tvc.selectedViewController];
    }else if ([rootVC isKindOfClass:[UINavigationController class]]){
        
        UINavigationController *nvc = (UINavigationController *)rootVC;
        currentVC = [KKCommon vcWithRootVC:nvc.visibleViewController];
    }else{
        
        currentVC = [KKCommon vcWithRootVC:rootVC];
    }
    
    return currentVC;
}

+(NSString *)pregReplaceEmojiWithString:(NSString *)string{
    
    NSString *pattern = @"[\\ud83c\\udc00-\\ud83c\\udfff]|[\\ud83d\\udc00-\\ud83d\\udfff]|[\\u2600-\\u27ff]";
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, string.length) withTemplate:@""];
}

+ (NSString *)uuidWithKeychain{
    
    if (IS_iOS11){
        
        //删除存储在钥匙串中的值，用于调试
        
        // 1.直接从keychain中获取UUID
        NSString *uuidKeychain = [KKCommon load:kUUIDKey];
        YXLog(@"从keychain中获取UUID%@", uuidKeychain);
        
        // 2.如果获取不到，需要生成UUID并存入系统中的keychain
        if ([uuidKeychain isKindOfClass:[NSNull class]] || uuidKeychain.length == 0) {
            //获取idfa
            NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
            //如果可以获取广告标识符，则获取标识符
            if (uuid && ![uuid isEqualToString:@"00000000-0000-0000-0000-000000000000"]){
                
                [KKCommon save:kUUIDKey data:uuid];
            } else {
                
                // 2.1 生成UUID
                CFUUIDRef puuid = CFUUIDCreate(nil);
                CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
                NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
                CFRelease(puuid);
                CFRelease(uuidString);
                YXLog(@"生成UUID：%@",result);
                // 2.2 将生成的UUID保存到keychain中
                [KKCommon save:kUUIDKey data:result];
            }
            // 2.3 从keychain中获取UUID
            uuidKeychain = [KKCommon load:kUUIDKey];
        }
        
        return uuidKeychain;
    } else {
        NSString *uuid = [[UIDevice currentDevice] identifierForVendor].UUIDString;
        return uuid;
    }
    
}


#pragma mark - 删除存储在keychain中的UUID

+ (void)deleteKeyChain {
    [self delete:kUUIDKey];
}


#pragma mark - 私有方法

+ (NSMutableDictionary *)getKeyChainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:(id)kSecClassGenericPassword,(id)kSecClass,service,(id)kSecAttrService,service,(id)kSecAttrAccount,(id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil];
}

// 从keychain中获取UUID
+ (NSString *)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            if (IS_iOS11){
                ret = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSString class] fromData:(__bridge NSData *)keyData error:nil];
            }
        }
        @catch (NSException *exception) {
            YXLog(@"Unarchive of %@ failed: %@", service, exception);
        }
        @finally {
            YXLog(@"finally");
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    YXLog(@"ret = %@", ret);
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

// 将生成的UUID保存到keychain中
+ (void)save:(NSString *)service data:(id)data {
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeyChainQuery:service];
    // Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    // Add new object to search dictionary(Attention:the data format)
    
    if (IS_iOS11) {
        NSData *archiver = [NSKeyedArchiver archivedDataWithRootObject:data requiringSecureCoding:true error:nil];
        
        [keychainQuery setObject:archiver forKey:(id)kSecValueData];
        // Add item to keychain with the search dictionary
        SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    }
}

+ (NSString *)idfa{
    
    if (@available(iOS 14, *)) {
        
        __block NSString *idfa = [KKCommon uuidWithKeychain];
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
            } else {
                idfa = [NSString stringWithFormat:@"V:%@",idfa];
            }
        }];
        
        return idfa;
    } else {
        if ([ASIdentifierManager.sharedManager isAdvertisingTrackingEnabled]) {
            
            return [ASIdentifierManager.sharedManager advertisingIdentifier].UUIDString;
        } else {
            return [NSString stringWithFormat:@"V:%@",[KKCommon uuidWithKeychain]];
        }
    }
}

+ (NSString *)language{
    
    YXGAMELanguageMode mode = [[NSUserDefaults objectForKey:YXGAMELanguageCache] integerValue];
    
    NSString *language;
    if (mode == YXGAMELanguageModeSystem) {
        
        NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        NSString *preferredLanguage = [languages firstObject];
        
        if ([preferredLanguage containsString:@"zh-Hans"]){
            language = @"zh";
        } else if ([preferredLanguage containsString:@"zh-Hant"]){
            language = @"zh_ft";
        } else if ([preferredLanguage containsString:@"ja"]){
            language = @"ja";
        } else if ([preferredLanguage containsString:@"ko"]){
            language = @"ko";
        } else {
            language = @"en";
        }
    } else {
        switch (mode) {
            case YXGAMELanguageModeEN: language = @"en";
                break;
            case YXGAMELanguageModeCN: language = @"zh";
                break;
            case YXGAMELanguageModeTC: language = @"zh_ft";
                break;
            case YXGAMELanguageModeJP: language = @"ja";
                break;
            case YXGAMELanguageModeKo: language = @"ko";
                break;
            default: language = @"en";
                break;
        }
    }
    
    return language;
}

@end
