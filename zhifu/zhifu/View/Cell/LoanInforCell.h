//
//  LoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGLoanModel, MGUserLoanModel;
@interface LoanInforCell : UITableViewCell

@property (nonatomic, assign, getter= hideTitleAndBondImage) BOOL isDetailCell;

@property (nonatomic, strong) MGLoanModel *loanModel;

@property (nonatomic, strong) MGUserLoanModel *userLoanModel;

-(void)setLoanModel:(MGLoanModel *)loanModel;

-(void)setUserLoanModel:(MGUserLoanModel *)userLoanModel;


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


+(instancetype)cellForTableView:(UITableView *)tableView reuseIdentifier:(NSString *)reuseIdentifier;

@end
