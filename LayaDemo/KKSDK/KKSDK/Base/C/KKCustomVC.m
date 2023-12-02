//
//  KKCustomVC.m
//  WSTDK
//
//  Created by Hello on 2020/8/19.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKCustomVC.h"

@interface KKCustomVC ()

@end

@implementation KKCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    
    YXLog(@"%@对象已经被销毁",NSStringFromClass([self class]));
}

@end
