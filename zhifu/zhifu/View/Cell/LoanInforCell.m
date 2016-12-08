//
//  LoanInforCell.m
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"

#import "MGLoanModel.h"
#import "MGUserLoanModel.h"

@interface LoanInforCell ()

/**
 产品名称
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/**
 是否 加息1%
 默认隐藏
 */
@property (weak, nonatomic) IBOutlet UIImageView *addInvestImageView;

/**
 投资类型
 默认隐藏
 */
@property (weak, nonatomic) IBOutlet UIImageView *bondImageView;

/**
 已完成
 默认隐藏
 */
@property (weak, nonatomic) IBOutlet UIImageView *completeImageView;

/**
 借款金额 value
 */
@property (weak, nonatomic) IBOutlet UILabel *loadModnyLabel;

/**
 借款金额 key
 */
@property (weak, nonatomic) IBOutlet UILabel *loadMoneyKeyLabel;

/**
 借款期限 value
 */
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

/**
 借款期限 key
 */
@property (weak, nonatomic) IBOutlet UILabel *limitDateLoanKeyLabel;


/**
 回款方式
 1. 等额本息
 2. 付息还本
 */
@property (weak, nonatomic) IBOutlet UILabel *repaymentLabel;

@property (weak, nonatomic) IBOutlet UILabel *repaymentKeyLabel;

/**
 预期年化利率
 yearrate  年化率
 extrarate 新手加息
 */
@property (weak, nonatomic) IBOutlet UILabel *yearRateLabel;

@property (weak, nonatomic) IBOutlet UILabel *yearRateKeyLabel;

/**
 借款进度
 */
@property (weak, nonatomic) IBOutlet UIProgressView *statusProgress;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end

@implementation LoanInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier
{
    LoanInforCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed: @"LoanInforCell" owner:nil options:nil] lastObject];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return cell;
}

-(void)setLoanModel:(MGLoanModel *)loanModel
{
    _loanModel = loanModel;
    
    //投资
    [self.loadMoneyKeyLabel     setText: @"借款金额"];
    [self.limitDateLoanKeyLabel setText: @"借款期限"];
    [self.repaymentKeyLabel     setText: @"回款方式"];
    [self.yearRateKeyLabel      setText: @"预期年化利率"];
    
    [self.titleLabel setText: loanModel.title];
    //是否是新手或加息1%
    if (loanModel.extrarate.floatValue > 0) {
        self.bondImageView.hidden = NO;
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
        
        self.completeImageView.hidden = NO;
        [self.completeImageView setImage: [UIImage imageNamed: @"icon_t_complete"]];
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%0.1f%%", ratioProgress*100.0];
        [self.statusLabel setText: str];
    }
}

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel
{
    _userLoanModel = userLoanModel;
    
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
