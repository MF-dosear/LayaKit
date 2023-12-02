//
//  KKUsersCell.h
//  WSTDK
//
//  Created by Hello on 2020/8/15.
//  Copyright © 2020 dosear. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const YXUsersCellID = @"KKUsersCell";

typedef void(^YXUsersCellBlock)(NSInteger tag);

@interface KKUsersCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) YXUsersCellBlock block;

@end

NS_ASSUME_NONNULL_END
