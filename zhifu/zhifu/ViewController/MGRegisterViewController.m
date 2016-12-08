//
//  MGRegisterViewController.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGRegisterViewController.h"

@interface MGRegisterViewController ()

@end

@implementation MGRegisterViewController
////隐藏tabbar
//-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        self.hidesBottomBarWhenPushed = YES;
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
}

+(instancetype)registerViewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MGRegisterViewController"];
}



@end
