//
//  LoanInforCell+InviteCell.h
//  zhifu
//
//  Created by Unchastity on 12/16/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"

@class MGInviteLoanModel, MGInviteUserLoanModel;

@interface LoanInforCell (InviteCell)

@property (nonatomic, strong) MGInviteLoanModel     *loanModel;
@property (nonatomic, strong) MGInviteUserLoanModel *userLoanModel;

-(void)setLoanModel:(MGInviteLoanModel *)loanModel;

-(void)setUserLoanModel:(MGInviteUserLoanModel *)userLoanModel;

@end
