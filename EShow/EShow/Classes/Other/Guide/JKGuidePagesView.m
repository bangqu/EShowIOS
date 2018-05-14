//
//  JKGuidePagesView.m
//  EShow
//
//  Created by 周家康 on 2018/5/8.
//  Copyright © 2018年 周家康. All rights reserved.
//

#import "JKGuidePagesView.h"
#import "JKGuidePagesCell.h"

@interface JKGuidePagesView() <UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSString *leftBtnTitle;
@property (nonatomic, strong) UIColor *leftBtnTitleColor;
@property (nonatomic, strong) UIColor *leftBtnBgColor;
@property (nonatomic, strong) NSString *rightBtnTitle;
@property (nonatomic, strong) UIColor *rightBtnTitleColor;
@property (nonatomic, strong) UIColor *rightBtnBgColor;
@property (nonatomic, strong) UIColor *rightBtnBorderColor;
@end

@implementation JKGuidePagesView

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = SCREEN_BOUNDS.size;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:layout];
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.bounces = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[JKGuidePagesCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = kLightGrayColor;
        _pageControl.currentPageIndicatorTintColor = kTextBaseColor;
        _pageControl.transform=CGAffineTransformScale(CGAffineTransformIdentity, 1.5, 1.5);
    }
    return _pageControl;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kRedColor;
    }
    return self;
}

- (void)showGuideViewWithImages:(NSArray *)images
                andLeftBtnTitle:(NSString *)leftBtnTitle
           andLeftBtnTitleColor:(UIColor *)leftBtnTitleColor
              andLeftBtnBgColor:(UIColor *)leftBtnBgColor
               andRightBtnTitle:(NSString *)rightBtnTitle
          andRightBtnTitleColor:(UIColor *)rightBtnTitleColor
             andRightBtnBgColor:(UIColor *)rightBtnBgColor
         andRightBtnBorderColor:(UIColor *)rightBtnBorderColor {
    
    self.images = images;
    self.leftBtnTitle = leftBtnTitle;
    self.leftBtnTitleColor = leftBtnTitleColor;
    self.leftBtnBgColor = leftBtnBgColor;
    self.rightBtnTitle = rightBtnTitle;
    self.rightBtnTitleColor = rightBtnTitleColor;
    self.rightBtnBgColor = rightBtnBgColor;
    self.rightBtnBorderColor = rightBtnBorderColor;
    self.pageControl.numberOfPages = images.count;
    
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-SafeAreaBottomHeight - 60);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JKGuidePagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    UIImage *img = [self.images objectAtIndex:indexPath.row];
    CGSize imgSize = [self adaptImageSize:img.size compareScreenSize:SCREEN_BOUNDS.size];
    cell.imageView.frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
    cell.imageView.center = CGPointMake(SCREEN_BOUNDS.size.width / 2, SCREEN_BOUNDS.size.height / 2);
    cell.imageView.image = img;
    
    if (indexPath.row == self.images.count - 1) {
        cell.leftBtn.hidden = NO;
        cell.leftBtn.tag = 1;
        [cell.leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.leftBtn setTitle:self.leftBtnTitle forState:UIControlStateNormal];
        [cell.leftBtn setTitleColor:self.leftBtnTitleColor forState:UIControlStateNormal];
        cell.leftBtn.backgroundColor = self.leftBtnBgColor;
        
        cell.rightBtn.hidden = NO;
        cell.rightBtn.tag = 2;
        [cell.rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
        [cell.rightBtn setTitleColor:self.rightBtnTitleColor forState:UIControlStateNormal];
        cell.rightBtn.backgroundColor = self.rightBtnBgColor;
        cell.rightBtn.layer.borderColor = self.rightBtnBorderColor.CGColor;
        cell.rightBtn.layer.borderWidth = 1;
        
        cell.skipBtn.hidden = NO;
        cell.skipBtn.tag = 3;
        [cell.skipBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [cell.skipBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        cell.skipBtn.backgroundColor = kGrayColor;
    } else {
        cell.leftBtn.hidden = YES;
        cell.rightBtn.hidden = YES;
        cell.skipBtn.hidden = YES;
    }
    
    return cell;
}

#pragma mark -- 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    [self removeAll];
    if ([_delegate respondsToSelector:@selector(clickButtonEvents:)]) {
        [_delegate clickButtonEvents:btn];
    }
}

#pragma mark -- 销毁控件
- (void)removeAll {
    [self.collectionView removeFromSuperview];
    [self.pageControl removeFromSuperview];
    [self removeFromSuperview];
}


#pragma mark -- 适配图片尺寸
- (CGSize)adaptImageSize:(CGSize)imgSize compareScreenSize:(CGSize)screenSize {
    CGFloat width = screenSize.width;
    CGFloat height = screenSize.width / imgSize.width * imgSize.height;
    
    if (height < screenSize.height) {
        width = screenSize.height / height * width;
        height = screenSize.height;
    }
    return CGSizeMake(width, height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageControl.currentPage = scrollView.contentOffset.x / SCREEN_BOUNDS.size.width;
}

@end
