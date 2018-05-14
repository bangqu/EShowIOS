//
//  JKMainTableView.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKMainView.h"
#import "JKPersonalCenterVC.h"

@interface JKMainView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation JKMainView
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = RGBHex(0xf7f7f0);
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark -- 创建TableView
- (void)createUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_SIZE(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"个人中心";
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"设置";
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"TouchID&FaceID";
        cell.textLabel.font = [UIFont systemFontOfSize:18];
    }

    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if ([_delegate respondsToSelector:@selector(pushPersonCenterVC)]) {
            [_delegate pushPersonCenterVC];
        }
    } else if (indexPath.row == 1) {
        if ([_delegate respondsToSelector:@selector(pushSettingVC)]) {
            [_delegate pushSettingVC];
        }
    } else if (indexPath.row == 2) {
        if ([_delegate respondsToSelector:@selector(pushTouchIDAndFaceIDVC)]) {
            [_delegate pushTouchIDAndFaceIDVC];
        }
    }
}

#pragma mark -- cell的分割线顶头
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.separatorInset = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

@end
