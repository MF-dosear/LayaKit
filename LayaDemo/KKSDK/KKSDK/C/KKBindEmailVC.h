//
//  OVBindVC.h
//  WSTDK
//
//  Created by Hello on 2020/8/10.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^OVBindEmailBlock)(void);

@interface KKBindEmailVC : KKBaseVC

@property (nonatomic, copy) OVBindEmailBlock block;

@end

NS_ASSUME_NONNULL_END
