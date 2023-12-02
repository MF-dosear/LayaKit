//
//  KKApiVC+KeyBoard.m
//  WSTDK
//
//  Created by Hello on 2020/8/17.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKApiVC+KeyBoard.h"

@implementation KKApiVC (KeyBoard)

- (void)addKeyBoardNoti{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardDidHide) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyBoardDidHide{
    self.webView.scrollView.contentOffset = CGPointMake(0, 0);
}

- (void)removeKeyBoardNoti{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

@end
