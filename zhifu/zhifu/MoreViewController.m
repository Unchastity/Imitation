//
//  MoreViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarItem setTitle: @"更多"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_morehover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self.navigationItem setTitle: @"更多内容"];
}


@end
