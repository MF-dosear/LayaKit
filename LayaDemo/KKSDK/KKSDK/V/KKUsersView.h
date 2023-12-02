//
//  KKUsersView.h
//  WSTDK
//
//  Created by Hello on 2020/8/15.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXUsersBlock)(NSDictionary *user);

@interface KKUsersView : UITableView

@property (nonatomic, copy) YXUsersBlock block;

@end

NS_ASSUME_NONNULL_END
