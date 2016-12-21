//
//  UserViewController.m
//  zhifu
//
//  Created by Unchastity on 12/5/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "UserViewController.h"
#import "UserCustomButton.h"

@interface UserViewController ()

/**
 头像
 */
@property (weak, nonatomic) IBOutlet UIButton *headPortraitBtn;

/**
 用户信息
 */
@property (weak, nonatomic) IBOutlet UIView *userInforView;

/**
 用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/**
 手机或电脑客户端
 */
@property (weak, nonatomic) IBOutlet UIImageView *pcOrMobileType;

/**
 是否实名认证
 */
@property (weak, nonatomic) IBOutlet UIImageView *authenticationType;

/**
 是否绑定银行卡
 */
@property (weak, nonatomic) IBOutlet UIImageView *cardType;

/**
 是否绑定邮箱
 */
@property (weak, nonatomic) IBOutlet UIImageView *mailType;

/**
 上次登录时间
 */
@property (weak, nonatomic) IBOutlet UILabel *lastLoginTimeLabel;

/**
 可用余额
 */
@property (weak, nonatomic) IBOutlet UILabel *usableMoneyLabel;

/**
 累计收益
 */
@property (weak, nonatomic) IBOutlet UILabel *totalincomeLabel;

/**
 待收利息
 */
@property (weak, nonatomic) IBOutlet UILabel *interestLabel;

/**
 待收本金
 */
@property (weak, nonatomic) IBOutlet UILabel *principalLabel;


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

- (IBAction)clickAccoutManageBtn:(UIButton *)sender {
    
}

/**
 查看账户投资信息
 tag
 100    认证中心
 101    账户充值
 102    账户提现
 103    资金记录
 104    我的投资
 105    自动投标
 106    我的红包
 107    债权转让
 108    兑换中心
 @param sender 信息项
 */
- (IBAction)clickFunctionBtn:(UserCustomButton *)sender {
    
    
}


@end
