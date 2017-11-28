//
//  MPFNavigationBarView.h
//  导航栏定制
//
//  Created by LG on 2017/11/23.
//  Copyright © 2017年 my. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPFNavigationItem.h"

#define LeftMargin 5 //左侧按钮整体距离导航栏左侧的距离
#define RightMargin 5 //右侧按钮整体距离导航栏右侧的距离
#define isIphoneX 0

#define KMPFNavigationBarDefaultBackColor COLOR_WITH_HEX(0xEDEDED)

@interface MPFNavigationBarView : UIView

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, copy) NSArray<MPFNavigationItem*> *leftItems;
@property (nonatomic, copy) NSArray<MPFNavigationItem*> *rightItems;

- (instancetype)initWithCenterNavigationItem:(MPFNavigationCenterItem*)item;

- (void)updateCenterNavigationItem:(MPFNavigationCenterItem*)item;

/**
 更新左侧按钮距离边的整体距离

 @param leftMargin 距离
 */
- (void)updateLeftMargin:(CGFloat)leftMargin;
/**
 更新右侧按钮距离边的整体距离
 
 @param rightMargin 距离
 */
- (void)updateRightMargin:(CGFloat)rightMargin;


@end
