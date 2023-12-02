//
//  MQVC+function.h
//  MaQu
//
//  Created by Paul on 2023/8/22.
//

#import "MQVC.h"

NS_ASSUME_NONNULL_BEGIN

// 方法
static NSString *const NSFuncNameSdkInit                     = @"sdkInit";
static NSString *const NSFuncNameSdkLogin                    = @"sdkLogin";

static NSString *const NSFuncNameSdkLoginOut                 = @"sdkLoginOut";
static NSString *const NSFuncNameSdkSubmitRole               = @"sdkSubmitRole";

static NSString *const NSFuncNameSdkPsy                      = @"sdkPsy";
static NSString *const NSFuncNameSdkShowRewardedAd           = @"sdkShowRewardedAd";

static NSString *const NSFuncNameSdkShowReview               = @"sdkShowReview";
static NSString *const NSFuncNameSdkEvent                    = @"sdkEvent";

static NSString *const NSFuncNameSdkShare                    = @"share";
static NSString *const NSFuncNameSdkBind                     = @"sdkBind";

static NSString *const NSFuncNameSdkToBrowser                = @"sdkToBrowser";
static NSString *const NSFuncNameSdkExitGameAndRestart       = @"sdkExitGameAndRestart";

//static NSString *const NSFuncNameSdkSetXieyiState            = @"sdkSetXieyiState";
//static NSString *const NSFuncNameSdkGetXieyiState            = @"sdkGetXieyiState";

static NSString *const NSFuncNameSdkGetSysLang               = @"sdkGetSysLang";
static NSString *const NSFuncNameSdkSetGameLang              = @"sdkSetGameLang";
static NSString *const NSFuncNameSdkGetGameLang              = @"sdkGetGameLang";

static NSString *const NSFuncNameSdkShowCusService           = @"sdkShowCusService";
static NSString *const NSFuncNameSdkTranslateForGoogle       = @"sdkTranslateForGoogle";

@interface MQVC (function)<KKDelegate>

- (void)sdkShowRewardBack:(NSInteger)code;

@end

NS_ASSUME_NONNULL_END
