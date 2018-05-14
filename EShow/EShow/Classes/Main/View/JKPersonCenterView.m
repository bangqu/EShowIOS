//
//  JKPersonCenterView.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKPersonCenterView.h"

@interface JKPersonCenterView() <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) UIImageView *headImgV;
@end

@implementation JKPersonCenterView
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
        self.titleArr = @[@[@"头像",@"手机号码",@"昵称",@"性别"],@[@"个性签名"]];
        NSString *male = [NSString stringWithFormat:@"%@",[JKUserDefaults objectForKey:kMale]];
        if ([male isEqualToString:@"1"]) {
            self.genderStr = @"男";
        } else if ([male isEqualToString:@"0"]) {
            self.genderStr = @"女";
        } else {
            self.genderStr = @"请选择";
        }
        [self createUI];
    }
    return self;
}

#pragma mark -- 创建TableView
- (void)createUI {
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCALE_SIZE(15));
        make.left.right.bottom.equalTo(self);
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerV = [[UIView alloc] init];
    footerV.backgroundColor = kClearColor;
    return footerV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SCALE_SIZE(15);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return SCALE_SIZE(80);
    } else {
        return SCALE_SIZE(48);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = self.titleArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.headImgV removeFromSuperview];
            UIImageView *headImgV = [[UIImageView alloc] init];
            self.photoStr = [JKUserDefaults objectForKey:kPhoto];
            headImgV.yy_imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@!small.jpg", self.photoStr]];
            headImgV.contentMode = UIViewContentModeScaleAspectFit;
            headImgV.layer.cornerRadius = 25 * SCREEN_SCALE;
            headImgV.layer.masksToBounds = YES;
            [cell.contentView addSubview:headImgV];
            [headImgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.contentView).offset(15 * SCREEN_SCALE);
                make.right.equalTo(cell.contentView.mas_right).offset(-10);
                make.size.mas_equalTo(CGSizeMake(50 * SCREEN_SCALE, 50 * SCREEN_SCALE));
            }];
            self.headImgV = headImgV;
        } else if (indexPath.row == 1) {
            cell.detailTextLabel.text = [JKUserDefaults objectForKey:kUserName];
            cell.accessoryType = UITableViewCellAccessoryNone;
        } else if (indexPath.row == 2) {
            self.nicknameStr = [JKUserDefaults objectForKey:kNickName];
            cell.detailTextLabel.text = self.nicknameStr;
        } else if (indexPath.row == 3) {
            cell.detailTextLabel.text = self.genderStr;
        }
    } else {
        self.introStr = [JKUserDefaults objectForKey:kIntro];
        cell.detailTextLabel.text = self.introStr;
    }
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if ([_delegate respondsToSelector:@selector(chooseHeadImgV)]) {
                [_delegate chooseHeadImgV];
            }
        } else if (indexPath.row == 2) {
            if ([_delegate respondsToSelector:@selector(pushModifyNickNameVC)]) {
                [_delegate pushModifyNickNameVC];
            }
        } else if (indexPath.row == 3) {
            if ([_delegate respondsToSelector:@selector(chooseGender)]) {
                [_delegate chooseGender];
            }
        }
    } else {
        if ([_delegate respondsToSelector:@selector(pushIntroVC)]) {
            [_delegate pushIntroVC];
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
