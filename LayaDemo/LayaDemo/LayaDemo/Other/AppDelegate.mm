#import "AppDelegate.h"
#import "ViewController.h"
#import "conchRuntime.h"
#import "Config.h"
#import "MQVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    ViewController* pViewController  = [[ViewController alloc] init];
    _window.rootViewController = pViewController;
    [_window makeKeyAndVisible];
    
     _launchView = [[LaunchView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window.rootViewController.view addSubview:_launchView.view];
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
//    
//    self.window.rootViewController = [[MQVC alloc] init];
//    
    // 奔溃预防
    [KKManager avoidCrash];
    
    // 热修复
    [KKManager hotfixWithAppleID:AppleID];
    
    // 设置语言
    [KKManager sdkSetLanguage:@"en"];
    
    // SDK初始化
    KKInfos *info = [KKInfos sharedKKInfos];
    
    info.appsFlyerID = AppleID;
    info.appsFlyerKey = AppsFlyerKey;
    info.AppleID = AppleID;
    
    // 广告appkey
    info.rewardedAdID = AdvID;
    
    [KKManager sdkApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
  
    [KKManager sdkApplicationDidBecomeActive:application];
}

#pragma mark --分享
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    return [KKManager sdkApplication:app openURL:url options:options];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    return [KKManager sdkApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
    
    return [KKManager sdkApplication:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [KKManager sdkApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    [KKManager sdkApplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}


//- (void)applicationDidBecomeActive:(UIApplication *)application
//{
//    [PrincePower PrinceApplicationDidBecomeActive:application];
//}
//
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
//{
//    return [PrincePower PrinceApplication:app openURL:url options:options];
//}
//
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    return [PrincePower PrinceApplication:application openURL:url sourceApplication:sourceApplication annotation:annotation];
//}
//
//- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
//{
//    return [PrincePower PrinceApplication:application continueUserActivity:userActivity restorationHandler:restorationHandler];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    [PrincePower PrinceApplication:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [PrincePower PrinceApplication:application didReceiveRemoteNotification:userInfo];
//}
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    [PrincePower PrinceApplication:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
//}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    m_kBackgroundTask = [application beginBackgroundTaskWithExpirationHandler:^{
        if(m_kBackgroundTask != UIBackgroundTaskInvalid )
        {
            NSLog(@">>>>>backgroundTask end");
            [application endBackgroundTask:m_kBackgroundTask];
            m_kBackgroundTask = UIBackgroundTaskInvalid;
        }
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
