//
//  MGRegisterViewController.m
//  zhifu
//
//  Created by Unchastity on 12/8/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGRegisterViewController.h"

@interface MGRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *telText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property (weak, nonatomic) IBOutlet UITextField *rePasswordText;

@property (weak, nonatomic) IBOutlet UITextField *verifyText;

@property (weak, nonatomic) IBOutlet UITextField *inviteText;

@property (weak, nonatomic) IBOutlet UIButton *getVrifyBtn;

@property (weak, nonatomic) IBOutlet UIButton *agressProtocolBtn;
@end

@implementation MGRegisterViewController
//在interface中设置self.hidesBottomBarWhenPushed
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

- (IBAction)getVerifyCode:(UIButton *)sender {
}

- (IBAction)registerNow:(UIButton *)sender {
}

- (IBAction)agreeServeProtocol:(UIButton *)sender {
}

@end
