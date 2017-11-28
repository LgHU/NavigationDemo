//
//  UIViewController+UINavigation.h
//  导航栏定制
//
//  Created by LG on 2017/11/23.
//  Copyright © 2017年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFNavigationItem.h"

#define KMPFNavigationBarDefaultTitleColor COLOR_WITH_HEX(0x23232B)
#define KMPFNavigationBarDefaultTitleFont [UIFont systemFontOfSize:18]
#define KMPFNavigationBarDefaultBackImageName @"MPTCommonBackHL"

typedef NS_ENUM(NSInteger, MPFNavigationBarViewType) {
    MPFNavigationBarViewTypeDefault = 0,
    MPFNavigationBarViewTypeCustom
};

/*
 关于该分类的说明
  作用:用于在控制器中展示导航视图
  展示样式: 中间视图展示样式 - 1.展示标题 （返回按钮） 2.展示自定义视图
          左右两侧视图展示样式 -（支持多控件展示）

  使用说明:如果展示样式是 【 H| - 标题 - | 】直接调用 setNavigationTitle:方法
         如果展示样式是 【 H| 返回键 - 标题 -| 】直接调用 setNaviTitle:withDefaultBack:handler:
         如果展示样式是 【 H| - 自定义 - | 】调用 setCustomNavigationTitle:

 */

@interface UIViewController (UINavigation)

- (CGFloat)navigationBarHeight;

/*!
 隐藏导航拦

 @param hidden 隐藏
 */
- (void)hiddenNavigationBar:(BOOL)hidden;

/*!
 设置导航栏标题

 @param title 标题
 */
- (void)setNavigationTitle:(NSString*)title;
- (void)setNaviTitle:(NSString*)title withDefaultBack:(BOOL)defaultBack handler:(MPFNavigationAction)handler;

/*!
 设置导航栏中间自定义视图

 @param titleItem x
 */
- (void)setCustomNavigationTitle:(MPFNavigationCenterItem*)titleItem;


/*!
 添加导航视图左侧的按钮

 @param leftItems x
 */
- (void)addNavigationBarViewWithLeftButton:(NSArray<MPFNavigationItem*>*)leftItems;

/*!
 添加导航视图右侧的按钮
 
 @param rightItems x
 */
- (void)addNavigationBarViewWithRightButton:(NSArray<MPFNavigationItem*>*)rightItems;


@end

