//
//  SecondViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "InvestViewController.h"

@interface InvestViewController ()

@end

@implementation InvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.tabBarItem setTitle: @"投资"];
    [self.tabBarItem setImage: [[UIImage imageNamed: @"tab_touzi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self.tabBarItem setSelectedImage: [[UIImage imageNamed: @"tab_touzihover"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal]];
    
    [self.navigationItem setTitle: @"投资"];
}


@end
