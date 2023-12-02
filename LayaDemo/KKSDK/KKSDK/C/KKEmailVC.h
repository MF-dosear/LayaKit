//
//  KKEmailVC.h
//  WSTDK
//
//  Created by dosear on 2021/7/30.
//  Copyright © 2021 YXQ. All rights reserved.
//

#import "KKBindBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OVEmailBlock)(void);

@interface KKEmailVC : KKBindBaseVC

@property (nonatomic, copy) OVEmailBlock block;

@end

NS_ASSUME_NONNULL_END
