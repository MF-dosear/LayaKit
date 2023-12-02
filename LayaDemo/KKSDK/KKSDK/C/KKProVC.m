//
//  KKProVC.m
//  WSTDK
//
//  Created by dosear on 2020/11/27.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKProVC.h"

#import <WebKit/WebKit.h>

@interface KKProVC ()

@property (nonatomic,strong) WKWebView *webView;

@end

@implementation KKProVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.text;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:LocalizedString(@"Close") style:UIBarButtonItemStylePlain target:self action:@selector(backvc)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.webView = [[WKWebView alloc] init];
    self.webView.scrollView.showsVerticalScrollIndicator = false;
    self.webView.scrollView.showsHorizontalScrollIndicator = false;
    self.webView.layer.cornerRadius = 3;
    self.webView.layer.masksToBounds = true;
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)backvc{
    [self.navigationController dismissViewControllerAnimated:true completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)back{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    } else {
        [self pop];
    }
}

@end
