//
//  JKPersonalCenterVC.m
//  EShow
//
//  Created by 周家康 on 2018/5/7.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKPersonalCenterVC.h"
#import "JKPersonCenterView.h"
#import "JKModifyNickNameVC.h"
#import "JKUpdateUserInfoVM.h"
#import "JKIntroVC.h"
#import "JKQiNiuVM.h"

@interface JKPersonalCenterVC () <JKPersonCenterViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) JKPersonCenterView *pcView;
@end

@implementation JKPersonalCenterVC

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc]init];
        _imagePicker.delegate = self;
        _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        _imagePicker.allowsEditing = YES;
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return _imagePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    self.pcView = [[JKPersonCenterView alloc] init];
    self.pcView.delegate = self;
    [self.view addSubview:self.pcView];
    [self.pcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safeAreaTopView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark -- 选择头像
- (void)chooseHeadImgV {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取裁剪后的图像
    UIImage *image = info[UIImagePickerControllerEditedImage];
    //将照片存到媒体库
    //    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    [self uploadImageToQiNiu:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- 上传七牛
- (void)uploadImageToQiNiu:(UIImage *)image{
    [YJProgressHUD showProgressCircleNoValue:@"上传图片中..." inView:self.view];
    JKQiNiuVM *qnVC = [[JKQiNiuVM alloc] init];
    qnVC.image = image;
    [qnVC QiNiuRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if (![returnValue isEqualToString:@"fail"]) {
            [self savePhoto:returnValue];
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self.view];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- 保存图片
- (void)savePhoto:(NSString *)photoStr {
    [YJProgressHUD showProgressCircleNoValue:@"保存中..." inView:self.view];
    JKUpdateUserInfoVM *uuiVM = [[JKUpdateUserInfoVM alloc] init];
    uuiVM.photoStr = photoStr;
    [uuiVM userInfoGenderRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self.view afterDelayTime:1];
            self.pcView.photoStr = photoStr;
            [JKUserDefaults setObject:photoStr forKey:kPhoto];
            [JKUserDefaults synchronize];
            NSIndexPath *indexPathII = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.pcView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathII,nil] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self.view];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

#pragma mark -- 修改昵称
- (void)pushModifyNickNameVC {
    JKModifyNickNameVC *mnnVC = [[JKModifyNickNameVC alloc] init];
    mnnVC.nickNameStr = self.pcView.nicknameStr;
    mnnVC.block = ^(NSString *name) {
        self.pcView.nicknameStr = name;
        [JKUserDefaults setObject:name forKey:kNickName];
        [JKUserDefaults synchronize];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
        [self.pcView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:mnnVC animated:YES];
}

#pragma mark -- 个性签名
- (void)pushIntroVC {
    JKIntroVC *iVC = [[JKIntroVC alloc] init];
    iVC.introStr = self.pcView.introStr;
    iVC.block = ^(NSString *introStr) {
        self.pcView.introStr = introStr;
        [JKUserDefaults setObject:introStr forKey:kIntro];
        [JKUserDefaults synchronize];
        NSIndexPath *indexPathI = [NSIndexPath indexPathForRow:0 inSection:1];
        [self.pcView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathI,nil] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:iVC animated:YES];
}


#pragma mark -- 选择性别
- (void)chooseGender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"性别" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pcView.genderStr = @"男";
        NSIndexPath *indexPathIII = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.pcView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathIII,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self saveGender];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pcView.genderStr = @"女";
        NSIndexPath *indexPathIII = [NSIndexPath indexPathForRow:3 inSection:0];
        [self.pcView.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathIII,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self saveGender];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 保存性别
- (void)saveGender {
    [YJProgressHUD showProgressCircleNoValue:@"更新中..." inView:self.view];
    JKUpdateUserInfoVM *uuiVM = [[JKUpdateUserInfoVM alloc] init];
    uuiVM.genderStr = self.pcView.genderStr;
    [uuiVM userInfoGenderRequestWithSuccessBlock:^(id returnValue) {
        [YJProgressHUD hide];
        if ([returnValue[kStatus] integerValue] == 1) {
            [YJProgressHUD showMessage:returnValue[kMsg] inView:self.view afterDelayTime:1];
            if ([self.pcView.genderStr isEqualToString:@"男"]) {
                [JKUserDefaults setObject:@"1" forKey:kMale];
            } else if ([self.pcView.genderStr isEqualToString:@"女"]) {
                [JKUserDefaults setObject:@"0" forKey:kMale];
            }
            [JKUserDefaults synchronize];
        } else {
            [YJProgressHUD showMsgWithImage:returnValue[kMsg] imageName:iFailPath inview:self.view];
        }
    } withFailureBlock:^(id errorCode) {
        [YJProgressHUD hide];
    }];
}

@end
