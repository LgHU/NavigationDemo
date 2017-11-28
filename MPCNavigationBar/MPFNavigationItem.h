//
//  MPFNavigationItem.h
//  导航栏定制
//
//  Created by LG on 2017/11/24.
//  Copyright © 2017年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

typedef NS_ENUM(NSInteger, MPFNavigationItemStyle) {
    MPFNavigationItemStyleText = 0,
    MPFNavigationItemStyleImage,
    MPFNavigationItemStyleSpace
};

typedef void(^MPFNavigationAction)(NSDictionary *info);


/**
 导航栏标题选项按钮
 */
@interface MPFNavigationCenterItem : NSObject

@property (nonatomic, strong) UIView *centerView;

/*
 标题视图的尺寸，CGSizeZero:自适应 或者 根据size计算
 */
@property (nonatomic, assign) CGSize centerViewSize;

+ (instancetype)navigationCenterItemView:(UIView *)centerView size:(CGSize)size;

@end


/**
 导航栏左右两侧按钮
 会根据style决定content的内容是文字还是图片名称
 */
@interface MPFNavigationItem : NSObject

/**展示的文字或者图片的名称*/
@property (nonatomic, copy) NSString *content;

/**
 该属性只对 style = MPFNavigationItemStyleSpace 时有效
 */
@property (nonatomic, assign) CGFloat spaceWidth;

/**额外信息，在回调内部会传递回来*/
@property (nonatomic, copy) NSDictionary *info;
@property (nonatomic, copy) MPFNavigationAction handler;
@property (nonatomic, assign) MPFNavigationItemStyle style;

+ (instancetype)actionWithContent:(NSString*)content
                             info:(NSDictionary*)info
                            style:(MPFNavigationItemStyle)style
                          handler:(MPFNavigationAction)handler;

+ (instancetype)actionSpaceinfo:(NSDictionary*)info
                     spaceWidth:(CGFloat)spaceWidth;

@end
