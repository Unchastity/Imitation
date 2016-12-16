//
//  MGBaseViewController.m
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGBaseViewController.h"

@interface MGBaseViewController ()

@end

@implementation MGBaseViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置tabBarItem 字体颜色
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} forState: UIControlStateSelected];
    //设置navigation 背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"NavBackImg"] forBarMetrics:UIBarMetricsDefault];
}


@end
