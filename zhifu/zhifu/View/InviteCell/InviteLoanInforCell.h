//
//  InviteLoanInforCell.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanInforCell.h"

@class MGInviteLoanModel;
@interface InviteLoanInforCell : LoanInforCell

@property (nonatomic, strong) MGInviteLoanModel *inviteLoanModel;

-(void)setInviteLoanModel:(MGInviteLoanModel *)inviteLoanModel;
@end
