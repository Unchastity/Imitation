//
//  CalculatorViewController.m
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()

@end

@implementation CalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(instancetype)viewControllerFromMainBoard
{
    return [[UIStoryboard storyboardWithName: @"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"CalculatorViewController"];
}

@end
