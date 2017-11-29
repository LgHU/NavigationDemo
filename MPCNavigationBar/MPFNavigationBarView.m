//
//  MPFNavigationBarView.m
//  导航栏定制
//
//  Created by LG on 2017/11/23.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPFNavigationBarView.h"
#import "Masonry.h"

#define kLeftAndRightButtonsBaseTag 10

@interface MPFNavigationBarView ()

@property (nonatomic, strong) UIView *viewCenter;
@property (nonatomic, strong) UIView *viewLeft;
@property (nonatomic, strong) UIView *viewRight;

@property (nonatomic, strong) UIImageView *imgViewBackground;
@property (nonatomic, strong) NSMutableArray *leftButtons;
@property (nonatomic, strong) NSMutableArray *rightButtons;

@end

@implementation MPFNavigationBarView

#pragma mark - Inherit


#pragma mark - Public

- (instancetype)initWithCenterNavigationItem:(MPFNavigationCenterItem*)item {
    if (self = [super init]) {
        [self initUIWithCenetrNavigationItem:item];
        self.backgroundColor = KMPFNavigationBarDefaultBackColor;
    }
    
    return self;
}

#pragma mark - Public

- (void)updateCenterNavigationItem:(MPFNavigationCenterItem*)item {
    if (item && [item isKindOfClass:[MPFNavigationCenterItem class]]) {
        [self.viewCenter removeFromSuperview];
        [self initCenterView:item];
    }
}

- (void)updateLeftMargin:(CGFloat)leftMargin {
    [self.viewLeft mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(leftMargin);
    }];
}

- (void)updateRightMargin:(CGFloat)rightMargin {
    [self.viewRight mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-rightMargin);
    }];
}

#pragma mark - UI

/**
 布局整个导航视图

 @param item 对象
 */
- (void)initUIWithCenetrNavigationItem:(MPFNavigationCenterItem*)item {
    [self.viewRight removeFromSuperview];
    [self.viewLeft removeFromSuperview];
    [self.viewCenter removeFromSuperview];
    [self.imgViewBackground removeFromSuperview];
    
    self.imgViewBackground = ({
        UIImageView *imgView = [[UIImageView alloc]initWithImage:self.backgroundImage];
        [self addSubview:imgView];
        imgView;
    });
    
    //布局中间视图
    [self initCenterView:item];
    
    //布局左右两侧视图
    self.viewLeft = ({
        UIView *viewLeft = [UIView new];
        [self addSubview:viewLeft];
        viewLeft;
    });
    
    self.viewRight = ({
        UIView *viewRight = [UIView new];
        [self addSubview:viewRight];
        viewRight;
    });
    
    [self.imgViewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    [self.viewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(LeftMargin);
        make.top.equalTo(self).with.offset(marginTop);;
        make.bottom.equalTo(self);
    }];
    
    [self.viewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-RightMargin);
        make.top.equalTo(self).with.offset(marginTop);;
        make.bottom.equalTo(self);
    }];
    
    if (self.leftItems && [self.leftItems isKindOfClass:[NSArray class]] &&
        self.leftItems.count) {
        [self buildLeftItems:self.leftItems];
    }
    
    if (self.rightItems && [self.rightItems isKindOfClass:[NSArray class]] &&
        self.rightItems.count) {
        [self buildRightItems:self.rightItems];
    }
    
    MASAttachKeys(self.viewCenter,self.viewLeft,self.viewRight);
}

/**
 布局中间视图（标题视图）

 @param item 对象
 */
- (void)initCenterView:(MPFNavigationCenterItem*)item {
    if (item && [item isKindOfClass:[MPFNavigationCenterItem class]] &&
        [item.centerView isKindOfClass:[UIView class]]) {
        [self addSubview:item.centerView];
        self.viewCenter = item.centerView;
    } else {
        self.viewCenter = [UIView new];
        [self addSubview:self.viewCenter];
    }
    
    [self bringSubviewToFront:self.viewLeft];
    [self bringSubviewToFront:self.viewRight];
    
    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    [self.viewCenter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(marginTop/2.0);
        if (item && [item isKindOfClass:[MPFNavigationCenterItem class]] &&
            [item.centerView isKindOfClass:[UIView class]] &&
            !CGSizeEqualToSize(CGSizeZero, item.centerViewSize)) {
            make.size.mas_equalTo(item.centerViewSize);
        }
    }];
}

/**
 左侧按钮添加布局

 @param index 序号
 @param view 视图
 @param item 对象
 */
- (void)layoutLeftItems:(NSInteger)index andView:(UIView*)view item:(MPFNavigationItem*)item{
    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (index == 0) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewLeft);
            make.top.equalTo(self).with.offset(marginTop);;
            make.bottom.equalTo(self);
            if (item.style == MPFNavigationItemStyleSpace) {
                make.width.mas_equalTo(item.spaceWidth);
            } else {
                make.width.equalTo(view.mas_height);
            }
        }];
    } else {
        UIView *preView = self.leftButtons[index - 1];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(preView.mas_right).with.offset(5);
            make.top.equalTo(self).with.offset(marginTop);;
            make.bottom.equalTo(self);
            if (item.style == MPFNavigationItemStyleSpace) {
                make.width.mas_equalTo(item.spaceWidth);
            } else {
                make.width.equalTo(view.mas_height);
            }
        }];
    }
    
    if (index == self.leftItems.count - 1) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.viewLeft);
        }];
    }
}

/**
 右侧按钮添加布局
 
 @param index 序号
 @param view 视图
 @param item 对象
 */
- (void)layoutRightItems:(NSInteger)index andView:(UIView*)view item:(MPFNavigationItem*)item{
    CGFloat marginTop = [UIApplication sharedApplication].statusBarFrame.size.height;
    if (index == 0) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.viewRight);
            make.top.equalTo(self).with.offset(marginTop);;
            make.bottom.equalTo(self);
            if (item.style == MPFNavigationItemStyleSpace) {
                make.width.mas_equalTo(item.spaceWidth);
            } else {
                make.width.equalTo(view.mas_height);
            }
        }];
    } else {
        UIView *preView = self.rightButtons[index - 1];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(preView.mas_left).with.offset(-5);
            make.top.equalTo(self).with.offset(marginTop);;
            make.bottom.equalTo(self);
            if (item.style == MPFNavigationItemStyleSpace) {
                make.width.mas_equalTo(item.spaceWidth);
            } else {
                make.width.equalTo(view.mas_height);
            }
        }];
    }
    
    if (index == self.rightItems.count - 1) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewRight);
        }];
    }
}

#pragma mark - Private Methods

/**
 为左侧添加视图

 @param items 对象
 */
- (void)buildLeftItems:(NSArray*)items {
    [self.leftButtons removeAllObjects];
    [self.viewLeft.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger i = 0 ; i < items.count; i++) {
        MPFNavigationItem *item = items[i];
        if ([item isKindOfClass:[MPFNavigationItem class]]){
            UIView *view = [UIView new];
            if (item.style == MPFNavigationItemStyleSpace) {

            } else {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(btnClickLeft:) forControlEvents:UIControlEventTouchUpInside];
                if (item.style == MPFNavigationItemStyleText) {
                    [btn setTitle:item.content forState:UIControlStateNormal];
                    [btn sizeToFit];
                } else if(item.style == MPFNavigationItemStyleImage) {
                    UIImage *img = [UIImage imageNamed:item.content];
                    [btn setImage:img forState:UIControlStateNormal];
                }
                view = btn;
            }
            view.tag = kLeftAndRightButtonsBaseTag + i;
            [self.leftButtons addObject:view];
            [self.viewLeft addSubview:view];
            [self layoutLeftItems:i andView:view item:item];
        }
    }
}

/**
 为右侧添加视图
 
 @param items 对象
 */
- (void)buildRightItems:(NSArray*)items {
    [self.rightButtons removeAllObjects];
    [self.viewRight.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger i = 0 ; i < items.count; i++) {
        MPFNavigationItem *item = items[i];
        if ([item isKindOfClass:[MPFNavigationItem class]]){
            UIView *view = [UIView new];
            if (item.style == MPFNavigationItemStyleSpace) {
                
            } else {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn addTarget:self action:@selector(btnClickRight:) forControlEvents:UIControlEventTouchUpInside];
                if (item.style == MPFNavigationItemStyleText) {
                    [btn setTitle:item.content forState:UIControlStateNormal];
                    [btn sizeToFit];
                } else if(item.style == MPFNavigationItemStyleImage) {
                    UIImage *img = [UIImage imageNamed:item.content];
                    [btn setImage:img forState:UIControlStateNormal];
                }
                view = btn;
            }
            view.tag = kLeftAndRightButtonsBaseTag + i;
            [self.rightButtons addObject:view];
            [self.viewRight addSubview:view];
            [self layoutRightItems:i andView:view item:item];
        }
    }
}

#pragma mark - Actions
- (void)btnClickLeft:(UIButton*)aSender {
    NSInteger index = aSender.tag - kLeftAndRightButtonsBaseTag;
    if (index >= 0 && index < self.leftItems.count) {
        MPFNavigationItem *item = self.leftItems[index];
        if ([item isKindOfClass:[MPFNavigationItem class]]) {
            NSDictionary *info = item.info;
            if (item.handler) {
                item.handler(info);
            }
        }
    }
}

- (void)btnClickRight:(UIButton*)aSender {
    NSInteger index = aSender.tag - kLeftAndRightButtonsBaseTag;
    if (index >= 0 && index < self.rightItems.count) {
        MPFNavigationItem *item = self.rightItems[index];
        if ([item isKindOfClass:[MPFNavigationItem class]]) {
            NSDictionary *info = item.info;
            if (item.handler) {
                item.handler(info);
            }
        }
    }
}

#pragma mark - Delegate

#pragma mark - Data

#pragma mark - Notification

#pragma mark - Getter/Setter

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    _backgroundImage = backgroundImage;
    self.imgViewBackground.image = backgroundImage;
}

- (void)setLeftItems:(NSArray<MPFNavigationItem *> *)leftItems {
    _leftItems = [leftItems copy];
    [self buildLeftItems:leftItems];
}

- (void)setRightItems:(NSArray<MPFNavigationItem *> *)rightItems {
    _rightItems = [rightItems copy];
    [self buildRightItems:rightItems];
}

@end
