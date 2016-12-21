//
//  NewsBulletinViewController.m
//  zhifu
//
//  Created by Unchastity on 12/21/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "NewsBulletinViewController.h"

@interface NewsBulletinViewController ()

@end

@implementation NewsBulletinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



+(instancetype)viewControllerFromMainStoryBoard
{
    return [[UIStoryboard storyboardWithName: @"Main" bundle: nil] instantiateViewControllerWithIdentifier: @"NewsBulletinViewController"];
}


@end
