//
//  MQVC+function.m
//  MaQu
//
//  Created by Paul on 2023/8/22.
//

#import "MQVC+function.h"

@implementation MQVC (function)

// 交互
#pragma mark -- WKScriptMessageHandler 回调
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
//    NSLog(@"交互事件名称%@",message.name);
    if ([message.name isEqualToString:NSFuncNameSdkInit]) {
        // 初始化
        [self sdkInit];
    } else if ([message.name isEqualToString:NSFuncNameSdkLogin]) {
        // 登录
        [self sdkLogin];
    } else if ([message.name isEqualToString:NSFuncNameSdkSubmitRole]) {
        // 角色上报
        NSDictionary *info = [self infoWithBody:message.body];
        [self sdkSubmitRole:info];
    } else if ([message.name isEqualToString:NSFuncNameSdkPsy]) {
         // 支付
         NSDictionary *info = [self infoWithBody:message.body];
         [self sdkPsy:info];
    } else if ([message.name isEqualToString:NSFuncNameSdkLoginOut]) {
        // SDK登出
        [self sdkLoginOut:message.body];
    } else if ([message.name isEqualToString:NSFuncNameSdkShowRewardedAd]) {
        // 展示广告
        [self sdkShowRewardedAd];
    } else if ([message.name isEqualToString:NSFuncNameSdkShowReview]){
        //评论
        [self sdkShowReview];
    } else if ([message.name isEqualToString:NSFuncNameSdkEvent]){
        //统计事件
        NSDictionary *info = [self infoWithBody:message.body];
        [self sdkEvent:info[@"eventype"] method2:message.body];
    } else if ([message.name isEqualToString:NSFuncNameSdkShare]) {
        // 分享
        NSDictionary *info = [self infoWithBody:message.body];
        [self share:info];
    } else if ([message.name isEqualToString:NSFuncNameSdkBind]) {
        // 绑定
        [self sdkBind];
    } else if ([message.name isEqualToString:NSFuncNameSdkToBrowser]) {
        // 跳转浏览器 比如 社区、用户协议等
        [self sdkToBrowser:message.body];
    } else if ([message.name isEqualToString:NSFuncNameSdkExitGameAndRestart]) {
        // 重启
        [self sdkExitGameAndRestart];
    } else if ([message.name isEqualToString:NSFuncNameSdkGetSysLang]) {
        // 获取系统语言
        [self sdkGetSysLang];
    } else if ([message.name isEqualToString:NSFuncNameSdkSetGameLang]) {
        // 保存语言
        [self sdkSetGameLang:message.body];
    } else if ([message.name isEqualToString:NSFuncNameSdkGetGameLang]) {
        // 获取游戏语言
        [self sdkGetGameLang];
    } else if ([message.name isEqualToString:NSFuncNameSdkShowCusService]) {
        // 客服
        [self sdkShowCusService];
    } else if ([message.name isEqualToString:NSFuncNameSdkTranslateForGoogle]) {
        // 谷歌翻译
        [self sdkTranslateForGoogle:message.body];
    }
}

//初始化
- (void)sdkInit{
    // 初始化
    
    KKInfos *info = [KKInfos sharedKKInfos];
    info.AppID  = SuperID;
    info.AppKey = SuperKey;

    [KKManager sdkInitWithInfo:info delegate:self];
}

- (void)sdkInitResult:(BOOL)flag{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkInitBack";
    d[@"status"] = flag ? @"0" : @"1";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//登录
- (void)sdkLogin{
    [KKManager sdkLoginWithAutomatic:true];
//    [KKManager sdkAdvTest];
}

- (void)sdkLoginResult:(BOOL)flag userID:(NSString *)userID userName:(NSString *)userName session:(NSString *)session isBind:(BOOL)isBind{
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkLoginBack";
    d[@"channel"] = Channel;
    d[@"version"] = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    if (flag){
        d[@"username"] = userName;
        d[@"uid"] = userID;
        d[@"session"] = session;
        d[@"bind"] = @(isBind);
        d[@"status"] = @"0";
    }else{
        d[@"status"] = @"1";
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//登出
- (void)sdkLoginOut:(NSString *)showLoginUI{
    [KKManager sdkLoginOutBackFlag:true];
}

- (void)sdkLoginOutResult:(BOOL)flag{
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkLoginOutBack";
    d[@"status"] = flag ? @"0" : @"1";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//上传角色信息
- (void)sdkSubmitRole:(NSDictionary *)params{
    
    // 上传角色
    KKInfos *info = [KKInfos sharedKKInfos];
    
    info.roleName  = [NSString stringWithFormat:@"%@",params[@"roleName"]];
    info.roleID    = [NSString stringWithFormat:@"%@",params[@"roleID"]];

    info.roleLevel = [NSString stringWithFormat:@"%@",params[@"roleLevel"]];
    info.psyLevel  = [NSString stringWithFormat:@"%@",params[@"payLevel"]];
    
    info.serverName = [NSString stringWithFormat:@"%@",params[@"serverName"]];
    info.serverID   = [NSString stringWithFormat:@"%@",params[@"serverId"]];
    
    [KKManager sdkSubmitRole:info];
}

- (void)sdkSubmitRoleResult:(BOOL)flag{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkSubmitRoleBack";
    d[@"status"] = flag ? @"0" : @"1";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//购买
- (void)sdkPsy:(NSDictionary *)params{
    
    KKInfos *info = [KKInfos sharedKKInfos];
    
    // 角色信息
    info.roleName  = [NSString stringWithFormat:@"%@",params[@"roleName"]];
    info.roleID    = [NSString stringWithFormat:@"%@",params[@"roleID"]];

    info.roleLevel = [NSString stringWithFormat:@"%@",params[@"roleLevel"]];
    info.psyLevel  = [NSString stringWithFormat:@"%@",params[@"payLevel"]];
    
    info.serverName = [NSString stringWithFormat:@"%@",params[@"serverName"]];
    info.serverID   = [NSString stringWithFormat:@"%@",params[@"serverId"]];
    
    // 订单信息
    info.cpOrder = [NSString stringWithFormat:@"%@",params[@"cpOrder"]];
    info.price = [NSString stringWithFormat:@"%@",params[@"price"]];
    info.goodsID = [NSString stringWithFormat:@"%@",params[@"goodsId"]];
    info.goodsName = [NSString stringWithFormat:@"%@",params[@"goodsName"]];
    info.extends = [NSString stringWithFormat:@"%@",params[@"goodsName"]];
//    info.notify = @"http://47.241.72.50:20009/pay/xmwhy_i";
    
    [KKManager sdkPsy:info];
}

- (void)sdkPsyResult:(BOOL)flag{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"status"] = flag ? @"0" : @"1";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

// 激励广告
- (void)showRewardedAd{
    [KKManager sdkShowRewardedAd];
}

- (void)sdkShowRewardedAd{
    [KKManager sdkShowRewardedAd];
}

- (void)sdkShowRewardedAd:(NSString *)adUnitId{
    [KKManager sdkShowRewardedAd:adUnitId];
}

// 广告回调
- (void)sdkShowRewardBack:(NSInteger)code{
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkShowRewardBack";
    d[@"status"] = @"0";
    d[@"code"] = @(code);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

- (void)sdkShowReview{
    [KKManager sdkRequestReview];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkShowReviewBack";
    d[@"status"] = @"0";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//统计事件
- (void)sdkEvent:(NSString *)eventName{
    [KKManager wdEventToEs:eventName jsonStr:@""];
}

//统计事件
- (void)sdkEvent:(NSString *)eventName method2:(NSString *)jsonStr{
    [KKManager wdEventToEs:eventName jsonStr:jsonStr];
}

//分享
- (void)share:(NSDictionary *)params{
    
    //link 链接 photo
//    NSString *mode;
    NSString *type = params[@"type"];
    if([type isEqualToString:@"link"]){
//        mode = @"link";
        NSString *url = params[@"url"];
        NSString *title = params[@"title"];
        [KKManager sdkShareImage:nil url:url title:title];
    }else if([type isEqualToString:@"photo"]){
        NSString *base64 = params[@"base64Image"];
//        mode = @"photo";
        if (base64.length > 0) {
            NSURL *url = [NSURL URLWithString:base64];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            NSString *title = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
            [KKManager sdkShareImage:image url:@"" title:title];
        }
    }
}

//绑定账号
- (void)sdkBind{
    [KKManager openBindView];
}

//获取系统语言
- (void)sdkGetSysLang{
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkGetSysLangBack";
    d[@"status"] = @"0";
    d[@"language"] = [KKManager sdkGetSystemLanguage];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}
//游戏存储语言
- (void)sdkSetGameLang:(NSString *)lang{
    [KKManager sdkSetLanguage:lang];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkSetGameLangBack";
    d[@"status"] = @"0";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}
         
//游戏获取储存语言
- (void)sdkGetGameLang{
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkGetGameLangBack";
    d[@"status"] = @"0";
    d[@"language"] = [KKManager sdkGetCacheLanguage];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//跳转浏览器 比如 社区、用户协议等
- (void)sdkToBrowser:(NSString *)str{
    
    [KKManager openUrl:str];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkToBrowserBack";
    // 处理绑定结果 code 1成功 0 失败
    d[@"status"] = @"0";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//弹出SDK联系客服页面
- (void)sdkShowCusService{
    [KKManager openServiceView];
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"type"] = @"sdkShowCusServiceBack";
    // 处理绑定结果 code 1成功 0 失败
    d[@"status"] = @"0";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self javaScriptWtihValue:jsonString];
}

//分配加载广告id
- (void)sdksetupAD:(NSString *)str{
    
//    [[AdvertPlatform shareInitialization] setAdIdRes:str IsReady:true];

}

// 重启
- (void)sdkExitGameAndRestart{
//    exit(0);
    [self sdkLoginOut:@"1"];
}

// 翻译
- (void)sdkTranslateForGoogle:(NSString *)jsonStr{
    NSDictionary *params = [self infoWithBody:jsonStr];
    NSString *txt = params[@"txt"];
    NSString *lan = params[@"targetLanguage"];
    [KKManager sdkTrans:txt lan:lan result:^(BOOL isSucccess, NSString * _Nonnull text) {
       
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        d[@"type"] = @"sdkTranslateForGoogleBack";
        // 处理绑定结果 code 1成功 0 失败
        d[@"status"] = isSucccess ? @"0" : @"1";
        d[@"result"] = text;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:d options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [self javaScriptWtihValue:jsonString];
    }];
}

// 解析body
- (id)infoWithBody:(id)bodyData{

    if ([bodyData isKindOfClass:[NSDictionary class]]) {
        return bodyData;
    }

    if ([bodyData isKindOfClass:[NSString class]] == false) {
        return nil;
    }

    NSString *body = (NSString *)bodyData;
    if (body.length == 0) {
        return nil;
    }

    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    if (data == nil) {
        return nil;
    }

    NSError *error;
    id info = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];

    if (error) {
        NSLog(@"NSJSONSerialization error: %@",error);
        return nil;
    } else {
        return info;
    }
}

@end
