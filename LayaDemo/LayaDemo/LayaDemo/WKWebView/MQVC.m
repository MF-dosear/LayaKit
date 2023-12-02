//
//  ViewController.m
//  MaQu
//
//  Created by Paul on 2023/8/22.
//

#import "MQVC.h"
#import "MQVC+method.h"
#import "MQVC+function.h"

@interface MQVC ()

@end

@implementation MQVC

/// Status状态栏不显示
- (BOOL)prefersStatusBarHidden{
    return true;
}

- (NSArray *)functions{
    if (_functions == nil){
        _functions = @[
            NSFuncNameSdkInit,
            NSFuncNameSdkLogin,

            NSFuncNameSdkLoginOut,
            NSFuncNameSdkSubmitRole,

            NSFuncNameSdkPsy,
            NSFuncNameSdkShowRewardedAd,

            NSFuncNameSdkShowReview,
            NSFuncNameSdkEvent,

            NSFuncNameSdkShare,
            NSFuncNameSdkBind,

            NSFuncNameSdkToBrowser,
            NSFuncNameSdkExitGameAndRestart,

            NSFuncNameSdkGetSysLang,
            NSFuncNameSdkSetGameLang,
            NSFuncNameSdkGetGameLang,

            NSFuncNameSdkShowCusService,
            NSFuncNameSdkTranslateForGoogle,
        ];
    }
    return _functions;
}

- (WKWebView *)webView{
    if (_webView == nil){
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController* userContentController = [[WKUserContentController alloc] init];
        // 注入js方法
        for (NSString *funName in self.functions) {
            [userContentController addScriptMessageHandler:self name:funName];
        }
        config.userContentController = userContentController;

        // 进行偏好设置
        WKPreferences *preferences = [[WKPreferences alloc] init];
        //preferences.minimumFontSize = 40.0; // 设置网页的最小字体大小。
        // 不通过用户交互，是否可以打开窗口
        preferences.javaScriptCanOpenWindowsAutomatically = true; // 设置JavaScript是否可以自动打开新窗口。
        // 是否支持JavaScript
        preferences.javaScriptEnabled = true; // 设置是否支持JavaScript
        [preferences setValue:@(true) forKey:@"allowFileAccessFromFileURLs"];
        config.preferences = preferences; // 网页加载时的偏好设置
        config.allowsInlineMediaPlayback = true; //设置HTML5视频是否允许网页播放 设置为NO则会使用本地播放器
        config.mediaTypesRequiringUserActionForPlayback = false;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = false;
        _webView.scrollView.showsHorizontalScrollIndicator = false;
        _webView.scrollView.scrollEnabled = false;
        _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 常亮
    [UIApplication sharedApplication].idleTimerDisabled = true;
    
    // 添加wk
    [self.view addSubview:self.webView];
    
    // 判断网络
    [self checkNet];
    
}

- (void)requestUrl{
//    NSString *url = @"https://dungeons-newhwtest.qk81.cn/indexkb.html";
//    [self loadWebView:url];
    
    __weak typeof(self) weakSelf = self;
    [KKManager apiWithAppleID:AppleID result:^(BOOL isSuccess, NSString * _Nonnull api) {
//        NSLog(@"api = %@",api);
        if (isSuccess){
            [weakSelf loadWebView:api];
        } else {
//            NSString *url = @"https://dungeons-newhwtest.qk81.cn/indexkb.html";
            NSString *url = [NSString stringWithFormat:@"https://dungeons-hwcdnnew.heropx.com/heropx/indexph1.html?num=%d",arc4random() % 10000];
            [weakSelf loadWebView:url];
        }
    }];
}

- (void)loadWebView:(NSString *)api{
    NSURL *url = [NSURL URLWithString:api];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

// 返回数据
- (void)javaScriptWtihValue:(NSString *)value{
    
    NSString *javaScript;
    if (value) {
        javaScript = [NSString stringWithFormat:@"sdkCallback('%@')",value];
    } else {
        javaScript = [NSString stringWithFormat:@"sdkCallback('')"];
    }
    
    [self.webView evaluateJavaScript:javaScript completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@调用js失败：error = %@",javaScript,error);
        } else {
            NSLog(@"%@调用js成功",javaScript);
        }
    }];
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    //可以通过navigationAction.navigationType 获取跳转类型，如新链接、后退等
    NSURL *URL = navigationAction.request.URL;
    //判断URL是否符合自定义的URL Scheme
    if (![URL.scheme isEqualToString:@"https"] && ![URL.scheme isEqualToString:@"http"]){
        
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];

    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    
    self.isDidFinish = true;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
}

@end
