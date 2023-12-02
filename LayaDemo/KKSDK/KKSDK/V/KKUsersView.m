//
//  KKUsersView.m
//  WSTDK
//
//  Created by Hello on 2020/8/15.
//  Copyright © 2020 dosear. All rights reserved.
//

#import "KKUsersView.h"
#import "KKUsersCell.h"

@interface KKUsersView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *list;

@end

@implementation KKUsersView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self done];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = true;
}

- (void)done{
    
    self.separatorColor = LINE_COLOR_C;
    
    self.delegate = self;
    self.dataSource = self;
    
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.9];
    
    [self registerClass:[KKUsersCell class] forCellReuseIdentifier:YXUsersCellID];
    
    KKConfig *config = [KKConfig sharedKKConfig];
    self.list = [config users];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KKUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:YXUsersCellID forIndexPath:indexPath];

    NSDictionary *user = self.list[indexPath.row];
    cell.label.text = user[TableLeak_username];
    cell.btn.tag = indexPath.row + 100;
    WEAKSELF;
    cell.block = ^(NSInteger tag) {
        NSInteger index = tag - 100;
        if (index < weakSelf.list.count) {
            NSDictionary *user = self.list[index];
            KKConfig *config = [KKConfig sharedKKConfig];
            [config removeWithName:user[TableLeak_username]];
            weakSelf.list = [config users];
            [weakSelf reloadData];
        }
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return TEXTHEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.block) {
        self.block(self.list[indexPath.row]);
    }
}

@end
