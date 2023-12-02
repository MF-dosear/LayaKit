//
//  KKNavVC.h
//  WSTDK
//
//  Created by Hello on 2020/8/6.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YXNavMode) {
    YXNavModeNormal,
    YXNavModeInfo,
    YXNavModeService
};

@interface KKNavVC : UINavigationController

@property (nonatomic, assign) YXNavMode mode;

@end

NS_ASSUME_NONNULL_END
