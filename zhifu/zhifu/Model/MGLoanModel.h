//
//  MGLoanModel.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGLoanModel : NSObject

@property(nonatomic, copy)   NSString     *ID;

@property(nonatomic, copy)   NSString     *loansn;

@property(nonatomic, copy)   NSString     *cateid;

@property(nonatomic, copy)   NSString     *type;

@property(nonatomic, copy)   NSString     *title;

@property(nonatomic, copy)   NSString     *shortsn;

@property(nonatomic, copy)   NSString     *loanmoney;

@property(nonatomic, copy)   NSString     *tendermoney;

@property(nonatomic, copy)   NSString     *loanmonth;

@property(nonatomic, copy)   NSString     *repayment;

@property(nonatomic, copy)   NSString     *isloanday;

@property(nonatomic, copy)   NSString     *loanday;

@property(nonatomic, copy)   NSString     *yearrate;

@property(nonatomic, copy)   NSString     *extrarate;

@property(nonatomic, copy)   NSString     *loanstatus;

@property(nonatomic, copy)   NSString     *lssuingtime;

@property(nonatomic, copy)   NSString     *status;

@property(nonatomic, copy)   NSString     *redpacket;

@property(nonatomic, copy)   NSString     *is_day;

@property(nonatomic, copy)   NSString     *lasttendertime;

@property(nonatomic, copy)   NSString     *pledge_userid;

@property(nonatomic, copy)   NSString     *a;

@property(nonatomic, copy)   NSString     *b;

@property(nonatomic, copy)   NSString     *slt_path;

@property(nonatomic, copy)   NSString     *loan_type;

@property(nonatomic, assign) NSInteger    flag;

@property(nonatomic, copy)   NSString     *cate_logo;

@property(nonatomic, assign) NSInteger     ratio;

@property(nonatomic, copy)   NSString     *msg;




-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
