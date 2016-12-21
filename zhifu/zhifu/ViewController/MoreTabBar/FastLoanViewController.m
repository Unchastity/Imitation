//
//  FastLoanViewController.m
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "FastLoanViewController.h"

@interface FastLoanViewController ()

@end

@implementation FastLoanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(instancetype)viewControllerFromMainBoard
{
    return [[UIStoryboard storyboardWithName: @"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"FastLoanViewController"];
}

@end
