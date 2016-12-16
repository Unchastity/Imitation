//
//  MGDetailUserLoanModel.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGUserLoanModel.h"

@interface MGDetailUserLoanModel : MGUserLoanModel

//detail
@property(nonatomic, copy)   NSString     *ID;
@property(nonatomic, copy)   NSString     *type;
@property(nonatomic, copy)   NSString     *ratemoney;
@property(nonatomic, copy)   NSString     *mintendermoney;
@property(nonatomic, copy)   NSString     *allotsn;
@property(nonatomic, copy)   NSString     *issuesn;
@property(nonatomic, copy)   NSString     *plat_money;
@property(nonatomic, copy)   NSString     *endtime;
@property(nonatomic, copy)   NSString     *lasttime;
@property(nonatomic, copy)   NSString     *timeadd;
@property(nonatomic, copy)   NSString     *edittime;
@property(nonatomic, copy)   NSString     *finish_time;
@property(nonatomic, copy)   NSString     *already_ratemoney;
@property(nonatomic, copy)   NSString     *not_ratemoney;
@property(nonatomic, copy)   NSString     *periode;
@property(nonatomic, copy)   NSString     *pay_ment_date;
@property(nonatomic, copy)   NSString     *redpacket;
@property(nonatomic, copy)   NSString     *overflow_money_back;
@property(nonatomic, assign) long          transmonth;
@property(nonatomic, copy)   NSString     *need_amount;
@property(nonatomic, copy)   NSNumber     *avil_amont;



@end
