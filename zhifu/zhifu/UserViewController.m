//
//  UserViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.tabBarItem setTitle: @"账户"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_my"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_myhover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self.navigationItem setTitle: @"账户"];
}


@end
