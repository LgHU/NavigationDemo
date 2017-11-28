//
//  PushedVC.m
//  导航栏定制
//
//  Created by LG on 2017/11/22.
//  Copyright © 2017年 my. All rights reserved.
//

#import "PushedVC.h"
#import "UIViewController+UINavigation.h"

@interface PushedVC ()

@end

@implementation PushedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof (self)wSelf = self;
    [self setNaviTitle:@"第二个导航控制器" withDefaultBack:YES handler:^(NSDictionary *info) {
        [wSelf.navigationController popViewControllerAnimated:YES];
    }];
    
//    self.navigationItem.title = @"PushednavigationItem.title";
//    self.navigationController.navigationBar.barTintColor = [UIColor yellowColor];
//    //    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
//    //    self.navigationController.toolbarHidden = NO;
    self.view.backgroundColor = [UIColor lightGrayColor];
//
//    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
//
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    [navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    //此处使底部线条颜色为红色
//    [navigationBar setShadowImage:[[self class] imageWithColor:[UIColor clearColor]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
