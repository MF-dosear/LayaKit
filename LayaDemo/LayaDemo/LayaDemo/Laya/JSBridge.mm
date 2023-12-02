#import "JSBridge.h"
//#import "AppDelegate.h"
#import "conchRuntime.h"
#import "JSBridge+platform.h"

@implementation JSBridge

static id _instance;
+ (instancetype)shareInitialization
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

+(void)hideSplash
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate.launchView hide];
//    });
}
+(void)setTips:(NSArray*)tips
{
 
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        appDelegate.launchView.tips = tips;
//    });
}
+(void)setFontColor:(NSString*)color
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate.launchView setFontColor:color];
//    });
}
+(void)bgColor:(NSString*)color
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate.launchView setBackgroundColor:color];
//    });
}
+(void)loading:(NSNumber*)percent
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate.launchView setPercent:percent.integerValue];
//    });
}
+(void)showTextInfo:(NSNumber*)show
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//        [appDelegate.launchView showTextInfo:show.intValue > 0];
//    });
}




@end

