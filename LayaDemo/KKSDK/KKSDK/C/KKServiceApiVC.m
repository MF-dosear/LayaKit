//
//  KKServiceApiVC.m
//  WSTDK
//
//  Created by dosear on 2021/8/17.
//  Copyright © 2021 YXQ. All rights reserved.
//

#import "KKServiceApiVC.h"
#import "KKManager+Apple.h"
#import "YXNetApi.h"

@interface KKServiceApiVC ()

@property (nonatomic, strong) UIButton *btn1; // Messenger

@property (nonatomic, strong) UIButton *btn2; // service

@end

@implementation KKServiceApiVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if (self.isDismiss) {
        [self updateBackBtn];
    }

    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setTitle:@"Messenger" forState:0];
    [self.btn1 setImage:IMAGE(@"ic_messengercolor") forState:0];
//    [self.btn1 setBackgroundImage:IMAGE(@"sdk_button") forState:0];
    [self.btn1 setBackgroundColor:TEXT_COLOR];
    [self.btn1 setTitleColor:BtnTitleColor forState:0];
    self.btn1.layer.cornerRadius = 5;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.btn1 addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn1];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2 setTitle:@"service" forState:0];
    [self.btn2 setImage:IMAGE(@"ic_service") forState:0];
//    [self.btn2 setBackgroundImage:IMAGE(@"sdk_button") forState:0];
    [self.btn2 setBackgroundColor:TEXT_COLOR];
    [self.btn2 setTitleColor:BtnTitleColor forState:0];
    self.btn2.layer.cornerRadius = 5;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    [self.btn2 addTarget:self action:@selector(serviceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn2];
    
    CGFloat bottom = 25;
    CGFloat h = 45;
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-bottom);
        make.height.mas_equalTo(h);
        make.left.mas_equalTo(MAINBTNLEFTSPACE);
        make.width.mas_equalTo(self.btn2.mas_width);
    }];
    
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-bottom);
        make.height.mas_equalTo(h);
        make.right.mas_equalTo(-MAINBTNLEFTSPACE);
        make.left.mas_equalTo(self.btn1.mas_right).mas_equalTo(20);
    }];
    
    YYLabel *label = [[YYLabel alloc] init];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MAINBTNLEFTSPACE);
        make.right.mas_equalTo(-MAINBTNLEFTSPACE);
        make.top.mas_equalTo(self.titleImage.mas_bottom);
        make.bottom.mas_equalTo(self.btn1.mas_top);
    }];
    
    // 如果您有任何問題或者疑問，歡迎通過下麵的鏈接或者郵箱與我們聯繫。
    NSString *text = [NSString stringWithFormat:@"★ %@\n★ Facebook：%@\n★ Email：%@",LocalizedString(@"If you have any questions or questions, please contact us through the following link or email"),Service_API,Service_Email];
    
    NSMutableAttributedString *att  = [[NSMutableAttributedString alloc] initWithString:text];
    att.yy_lineSpacing = 5;
    att.yy_font = FONTNAME(15);
    att.yy_color = TEXT_COLOR_C;
    
    UIColor *color = ProColor;
    
    NSRange rang1 = [text rangeOfString:Service_API];
    [att yy_setTextHighlightRange:rang1 color:color backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        // facebook
        [KKManager openUrl:Service_API];
    }];
    
    NSRange rang2 = [text rangeOfString:Service_Email];
    [att yy_setTextHighlightRange:rang2 color:color backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        // email
        [KKManager copyWithText:Service_Email msg:LocalizedString(@"Email")];
    }];
    
    YYTextDecoration *decoration = [YYTextDecoration decorationWithStyle:YYTextLineStyleSingle width:@(2) color:ProColor];
    [att yy_setTextUnderline:decoration range:rang1];
    [att yy_setTextUnderline:decoration range:rang2];
    
    label.attributedText = att;
}

- (void)back{
    if (self.isDismiss) {
        [self dismiss];
    } else {
        [self pop];
    }
}

- (void)messageAction{
    
    NSString *url = [KKConfig sharedKKConfig].fbmsg;
    if (url.length == 0) {
        url = Service_message;
    }
    [KKManager openUrl:url];
}

- (void)serviceAction{

    NSString *url = [KKConfig sharedKKConfig].work_url;
    if (url.length == 0) {
        url = Service_work_url;
    }
    [KKManager openUrl:url];
}


@end
