//
//  ViewController.m
//  导航栏定制
//
//  Created by LG on 2017/11/21.
//  Copyright © 2017年 my. All rights reserved.
//

#import "ViewController.h"
#import "PushedVC.h"
#import "UIViewController+UINavigation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNaviTitle:@"导航栏" withDefaultBack:YES handler:^(NSDictionary *info){
        NSLog(@"hahhhhhhh");
    }];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIView *view = [UIView new];
    view.frame = CGRectMake(100, 0, 300, 40);
    view.backgroundColor = [UIColor redColor];
    MPFNavigationCenterItem *item = [MPFNavigationCenterItem navigationCenterItemView:view size:CGSizeMake(300, 40)];
    [self setCustomNavigationTitle:item];
    
    PushedVC *pushVC = [[PushedVC alloc]init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
////    self.title = @"导航栏";
////    self.navigationItem.title = @"navigationItem.title";
////    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
////    self.navigationController.navigationBar.tintColor = [UIColor greenColor];
////    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
////    self.navigationController.toolbarHidden = NO;
////    self.navigationController.navigationBar.translucent = NO;
////    self.view.backgroundColor = [UIColor lightGrayColor];
//
//    PushedVC *pushVC = [[PushedVC alloc]init];
//    [self.navigationController pushViewController:pushVC animated:YES];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}


@end
