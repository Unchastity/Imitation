//
//  MGLoginViewController.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGLoginViewController.h"
#import "CreateBarBtnItem.h"

@interface MGLoginViewController ()

@end

@implementation MGLoginViewController

+(instancetype)getViewController
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier: @"MGLoginViewController"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationBar];
}

-(void)initNavigationBar
{
    [self.navigationItem setTitle: @"登录"];
    
    UIBarButtonItem *leftBtn = [CreateBarBtnItem createBarBtnItemWithTitle: @"取消"
                                                                     image:@""
                                                                     frame:CGRectMake(0, 0, 50, 25)
                                                           titleEdgeInsets:UIEdgeInsetsZero
                                                           imageEdgeInsets:UIEdgeInsetsZero
                                                                    Target:self
                                                                    select:@selector(cancelLogin)];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

-(void)cancelLogin
{
    [self dismissViewControllerAnimated: YES completion:^{
    }];
}

@end
