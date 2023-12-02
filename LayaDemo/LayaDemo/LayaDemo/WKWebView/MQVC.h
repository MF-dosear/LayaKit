//
//  ViewController.h
//  MaQu
//
//  Created by Paul on 2023/8/22.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Config.h"

@interface MQVC : UIViewController<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
// WKNavigationDelegatePrivate
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *api;

@property (nonatomic, copy) NSArray *functions;

@property (nonatomic, assign) BOOL isDidFinish;

@property (nonatomic, assign) BOOL isSDKInit;

/// 请求链接
- (void)requestUrl;

/// oc调用js回调
- (void)javaScriptWtihValue:(NSString *)value;

@end

