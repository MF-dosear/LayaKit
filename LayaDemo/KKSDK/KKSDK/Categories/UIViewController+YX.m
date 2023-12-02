//
//  UIViewController+YX.m
//  WSTDK
//
//  Created by Hello on 2020/8/14.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "UIViewController+YX.h"
#import "KKNavVC.h"

@implementation UIViewController (YX)

- (void)present{

    KKNavVC *nvc = [[KKNavVC alloc] initWithRootViewController:self];
    nvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nvc.modalPresentationStyle = UIModalPresentationOverFullScreen;

    [SELFVC presentViewController:nvc animated:true completion:nil];
}

- (void)push:(UIViewController *)vc{
    [self.navigationController pushViewController:vc animated:false];
}

- (void)pop{
    [self.navigationController popViewControllerAnimated:false];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
