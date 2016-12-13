//
//  LoanInforCell+HomeLoanInforCell.m
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell+HomeLoanInforCell.h"
#import "MGLoanModel.h"
#import "MGUserLoanModel.h"

@implementation LoanInforCell (HomeLoanInforCell)


-(void)setLoanModel:(MGLoanModel *)loanModel
{
    //投资
    [self.loadMoneyKeyLabel     setText: @"借款金额"];
    [self.limitDateLoanKeyLabel setText: @"借款期限"];
    [self.repaymentKeyLabel     setText: @"回款方式"];
    [self.yearRateKeyLabel      setText: @"预期年化利率"];
    
    [self.titleLabel setText: loanModel.title];
    //是否是新手或加息1%
    if (loanModel.extrarate.floatValue > 0) {
        [self.bondImageView setHidden: NO];
        [self.bondImageView setImage: [UIImage imageNamed: @"bond_newrate_item_icon"]];
    }
    //    //是否完成
    //    if (loanModel.status) {
    //        self.completeImageView.hidden = NO;
    //        [self.completeImageView setImage: [UIImage imageNamed: @"icon_t_complete"]];
    //    }
    //借款金额
    NSString *money = [NSString stringWithFormat:@"%@元", loanModel.loanmoney];
    [self.loadModnyLabel setText: money];
    //借款期限
    [self.msgLabel setText: loanModel.msg];
    //回款方式
    if (loanModel.repayment.integerValue == 1) {
        [self.repaymentLabel setText: @"等额本息"];
    }else if(loanModel.repayment.integerValue == 2)
    {
        [self.repaymentLabel setText: @"付息还本"];
    }
    
    //年化率
    NSString *rate = nil;
    if (loanModel.extrarate.floatValue > 0) {
        rate = [NSString stringWithFormat:@"%@%%+%@%%", loanModel.yearrate, loanModel.extrarate];
    }else
    {
        rate = [NSString stringWithFormat:@"%@%%", loanModel.yearrate];
    }
    [self.yearRateLabel setText: rate];
    //进度
    float ratioProgress = loanModel.tendermoney.floatValue / loanModel.loanmoney.floatValue;
    [self.statusProgress setProgress: ratioProgress];
    
    //
    if (ratioProgress == 1.0) {
        [self.statusLabel setText: @"已完成"];
        
        [self.completeImageView setHidden: NO];
        [self.completeImageView setImage: [UIImage imageNamed: @"icon_t_complete"]];
    }else
    {
        [self.completeImageView setHidden: YES];
        NSString *str = [NSString stringWithFormat:@"%0.1f%%", ratioProgress*100.0];
        [self.statusLabel setText: str];
    }
}

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel
{
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
