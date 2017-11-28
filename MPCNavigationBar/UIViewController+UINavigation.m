//
//  UIViewController+UINavigation.m
//  导航栏定制
//
//  Created by LG on 2017/11/23.
//  Copyright © 2017年 my. All rights reserved.
//

#import "UIViewController+UINavigation.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "MPFNavigationBarView.h"

static void *NavigationBarKey = @"NavigationBarKey";
static void *ISNavigationBarShowingKey = @"ISNavigationBarShowingKey";
static void *DefaultNavigationCenterItemKey = @"DefaultNavigationCenterItemKey";
static void *NavigationBarTypeKey = @"NavigationBarTypeKey";

@interface UIViewController ()

@property (nonatomic, strong) MPFNavigationBarView *navigationBar;
@property (nonatomic, assign) MPFNavigationBarViewType navigationBarType;
@property (nonatomic, strong) MPFNavigationCenterItem *defaultNavigationCenterItem;

@property (nonatomic, assign) BOOL isNavigationBarShowing;

@end

@implementation UIViewController (UINavigation)

#pragma mark - Inherit

#pragma mark - Public

- (CGFloat)navigationBarHeight {
    if (self.isNavigationBarShowing) {
        return isIphoneX ? 88. : 64;
    }
    
    return isIphoneX ? 44. : 20.;
}

- (void)hiddenNavigationBar:(BOOL)hidden {
    self.isNavigationBarShowing = !hidden;
}

- (void)setCustomNavigationTitle:(MPFNavigationCenterItem*)titleItem {
    if (![titleItem isKindOfClass:[MPFNavigationCenterItem class]]) {
        return;
    }
    
    self.isNavigationBarShowing = YES;
    self.navigationBarType = MPFNavigationBarViewTypeCustom;
    [self.navigationBar updateCenterNavigationItem:titleItem];
}

- (void)setNavigationTitle:(NSString*)title  {
    [self setNaviTitle:title withDefaultBack:NO handler:nil];
}

- (void)setNaviTitle:(NSString*)title withDefaultBack:(BOOL)defaultBack handler:(MPFNavigationAction)handler {
    self.isNavigationBarShowing = YES;
    
    UILabel *label = (UILabel *)self.defaultNavigationCenterItem.centerView;
    label.text = title;
    if (self.navigationBarType == MPFNavigationBarViewTypeCustom){
        [self initDefaultNavigationCenterItem];
    }
    
    if (defaultBack) {
        MPFNavigationItem *item = [MPFNavigationItem actionWithContent:KMPFNavigationBarDefaultBackImageName
                                                                  info:nil
                                                                 style:MPFNavigationItemStyleImage
                                                               handler:^(NSDictionary *info) {
                                                                   if (handler){
                                                                       handler(info);
                                                                   }
                                                               }];
        [self addNavigationBarViewWithLeftButton:@[item]];
    }
    
    self.navigationBarType = MPFNavigationBarViewTypeDefault;
}

- (void)addNavigationBarViewWithLeftButton:(NSArray*)leftItems {
    self.isNavigationBarShowing = YES;
    
    self.navigationBar.leftItems = leftItems;
}

- (void)addNavigationBarViewWithRightButton:(NSArray*)rightItems {
    self.isNavigationBarShowing = YES;
    
    self.navigationBar.rightItems = rightItems;
}

#pragma mark - Private Methods

- (void)initNavigationBar:(BOOL)needNavigationBar {
    if (needNavigationBar) {
        if (!self.navigationBar) {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor blackColor];
            MPFNavigationCenterItem *item = [MPFNavigationCenterItem navigationCenterItemView:view size:CGSizeMake(100, 30)];
            self.navigationBar = [[MPFNavigationBarView alloc]initWithCenterNavigationItem:item];
            [self.view addSubview:self.navigationBar];
            [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.view);
                make.height.mas_equalTo(isIphoneX ? 88.:64.);
            }];
            
            //设置默认的导航栏标题视图
            [self initDefaultNavigationCenterItem];
        }
        self.navigationBar.hidden = NO;
    } else {
        self.navigationBar.hidden = YES;
    }
}


/**
 设置默认的导航栏标题视图
 */
- (void)initDefaultNavigationCenterItem {
    if (!self.defaultNavigationCenterItem) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = KMPFNavigationBarDefaultTitleFont;
        label.textColor = KMPFNavigationBarDefaultTitleColor;
        [label sizeToFit];
        [label setBackgroundColor:[UIColor clearColor]];
        self.defaultNavigationCenterItem = [MPFNavigationCenterItem navigationCenterItemView:label size:CGSizeZero];
    }
    
    [self.navigationBar updateCenterNavigationItem:self.defaultNavigationCenterItem];
    self.navigationBarType = MPFNavigationBarViewTypeDefault;
}


#pragma mark - Actions

#pragma mark - Delegate

#pragma mark - Data

#pragma mark - Notification

#pragma mark - Getter/Setter

- (void)setNavigationBar:(MPFNavigationBarView *)navigationBar {
    objc_setAssociatedObject(self, NavigationBarKey, navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsNavigationBarShowing:(BOOL)isNavigationBarShowing {
    objc_setAssociatedObject(self, ISNavigationBarShowingKey, @(isNavigationBarShowing), OBJC_ASSOCIATION_ASSIGN);
    [self initNavigationBar:isNavigationBarShowing];
}

- (void)setDefaultNavigationCenterItem:(MPFNavigationCenterItem *)defaultNavigationCenterItem {
    objc_setAssociatedObject(self, DefaultNavigationCenterItemKey, defaultNavigationCenterItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setNavigationBarType:(MPFNavigationBarViewType)navigationBarType {
    objc_setAssociatedObject(self, NavigationBarTypeKey, @(navigationBarType), OBJC_ASSOCIATION_ASSIGN);
}

- (MPFNavigationBarView *)navigationBar {
    return objc_getAssociatedObject(self, NavigationBarKey);
}

- (BOOL)isNavigationBarShowing {
     return [objc_getAssociatedObject(self, ISNavigationBarShowingKey) boolValue];
}

- (MPFNavigationCenterItem *)defaultNavigationCenterItem {
    return objc_getAssociatedObject(self, DefaultNavigationCenterItemKey);
}

- (MPFNavigationBarViewType)navigationBarType {
    return [objc_getAssociatedObject(self, NavigationBarTypeKey)integerValue];
}

@end
