//
//  HomeUserLoanInforCell.m
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "HomeUserLoanInforCell.h"
#import "MGUserLoanModel.h"

@implementation HomeUserLoanInforCell

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel
{
    //[super setUserLoanModel: userLoanModel];
    //债权
    [self.loadMoneyKeyLabel     setText: @"转让金额"];
    [self.limitDateLoanKeyLabel setText: @"剩余天数"];
    [self.repaymentKeyLabel     setText: @"受让收益"];
    [self.yearRateKeyLabel      setText: @"预期年化利率"];
    
    [self.titleLabel setText: userLoanModel.title];
    //转
    self.bondImageView.hidden = NO;
    [self.bondImageView setImage: [UIImage imageNamed: @"bond_attorn_item_icon"]];
    
    //    //是否完成
    //    if (userLoanModel.status) {
    //        self.completeImageView.hidden = NO;
    //        [self.completeImageView setImage: [UIImage imageNamed: @"icon_t_complete"]];
    //    }
    
    //转让金额
    NSString *money = [NSString stringWithFormat:@"%@元", userLoanModel.loanmoney];
    [self.loadModnyLabel setText: money];
    //剩余天数
    [self.msgLabel setText: userLoanModel.rest_days.stringValue];
    //受让收益
    NSString *overflowMoney = [NSString stringWithFormat:@"%@元", userLoanModel.overflow_money];
    [self.repaymentLabel setText: overflowMoney];
    //年化率
    [self.yearRateLabel setText: userLoanModel.yearrate];
    //进度
    float ratioProgress = userLoanModel.tendermoney.floatValue / userLoanModel.loanmoney.floatValue;
    [self.statusProgress setProgress: ratioProgress];
    
    //
    if (ratioProgress == 1.0) {
        [self.statusLabel setText: @"已完成"];
        
        self.completeImageView.hidden = NO;
        [self.completeImageView setImage: [UIImage imageNamed: @"icon_t_complete"]];
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%0.1f%%", ratioProgress*100.0];
        [self.statusLabel setText: str];
    }

}

@end
