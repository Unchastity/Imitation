//
//  MGTabBarViewController.m
//  MGPICC
//
//  Created by Unchastity on 11/29/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGTabBarViewController.h"
#import "ViewController.h"
#import "ProductCenterViewController.h"
#import "ServiceViewController.h"
#import "MineViewController.h"

@interface MGTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation MGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //add viewcontroller
    [self addCustomChildViewController];
    
    //set default selected view controller
    self.selectedViewController = self.viewControllers[0];
    
    self.hidesBottomBarWhenPushed = YES;
}

-(void)addCustomChildViewController
{
    //添加主页
    ViewController *homeViewController = [[ViewController alloc] init];
    //homeViewController.view.backgroundColor = [UIColor redColor];
    UINavigationController *homeNavigationVC = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    homeNavigationVC.tabBarItem = [self createTabBarItemWithTitle:@"首页"
                                                            image:@"gb_bottom_home"
                                                      selectImage:@"gb_bottom_home1"];
    
    //添加product center
    ProductCenterViewController *productionCenterVC = [[ProductCenterViewController alloc] init];
    UINavigationController *productionNaviVC = [[UINavigationController alloc] initWithRootViewController:productionCenterVC];
    productionNaviVC.tabBarItem = [self createTabBarItemWithTitle:@"投保"
                                                            image:@"gb_bottom_toubao"
                                                      selectImage:@"gb_bottom_toubao1"];
    
    //添加服务
    ServiceViewController *serviceVC = [[ServiceViewController alloc] init];
    UINavigationController *serviceNaviVC = [[UINavigationController alloc] initWithRootViewController:serviceVC];
    serviceNaviVC.tabBarItem = [self createTabBarItemWithTitle:@"服务"
                                                         image:@"gb_bottom_service"
                                                   selectImage:@"gb_bottom_service1"];
    
    //添加mine
    MineViewController *mineVC = [[MineViewController alloc] init];
    UINavigationController *mineNaviVC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    mineNaviVC.tabBarItem = [self createTabBarItemWithTitle:@"我的"
                                                      image:@"gb_bottom_personal_center"
                                                selectImage:@"gb_bottom_personal_center1"];
    
    self.viewControllers = @[homeNavigationVC, productionNaviVC, serviceNaviVC, mineNaviVC];
    
}

-(UITabBarItem *)createTabBarItemWithTitle:(NSString *)title
                                     image:(NSString *)imageName
                               selectImage:(NSString *)selectImageName {
    
    //NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    UIImage *image = [[UIImage imageNamed: imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //NSString *selectImagePath = [[NSBundle mainBundle] pathForResource:selectImageName ofType:nil];
    UIImage *selectImage = [[UIImage imageNamed: selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image: image selectedImage:selectImage];
    
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName: [UIFont systemFontOfSize: 15]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor redColor], NSFontAttributeName: [UIFont systemFontOfSize: 15]} forState:UIControlStateSelected];
    
    //tabBarItem.badgeValue = @"3";
    
    return tabBarItem;
}

@end
