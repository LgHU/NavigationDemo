//
//  MPFNavigationItem.m
//  导航栏定制
//
//  Created by LG on 2017/11/24.
//  Copyright © 2017年 my. All rights reserved.
//

#import "MPFNavigationItem.h"

@implementation MPFNavigationCenterItem

+ (instancetype)navigationCenterItemView:(UIView *)centerView size:(CGSize)size {
    MPFNavigationCenterItem *item = [self new];
    item.centerView = centerView;
    item.centerViewSize = size;
    
    return item;
}

@end

@implementation MPFNavigationItem

+ (instancetype)actionWithContent:(NSString*)content
                             info:(NSDictionary*)info
                            style:(MPFNavigationItemStyle)style
                          handler:(MPFNavigationAction)handler {
    MPFNavigationItem *item = [self new];
    item.content = content;
    item.info = info;
    item.style = style;
    item.handler = [handler copy];
    return item;
}

+ (instancetype)actionSpaceinfo:(NSDictionary*)info
                     spaceWidth:(CGFloat)spaceWidth {
    MPFNavigationItem *item = [self new];
    item.content = nil;
    item.info = info;
    item.style = MPFNavigationItemStyleSpace;
    item.handler = nil;
    return item;
}

@end
