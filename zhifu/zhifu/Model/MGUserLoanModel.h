//
//  MGUserLoanModel.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGUserLoanModel : NSObject

@property(nonatomic, copy)   NSString     *memberid;

@property(nonatomic, copy)   NSString     *tendersn;

@property(nonatomic, copy)   NSString     *user_loansn;

@property(nonatomic, copy)   NSString     *loansn;

@property(nonatomic, copy)   NSString     *title;

@property(nonatomic, copy)   NSString     *overflow_money;

@property(nonatomic, copy)   NSString     *cateid;

@property(nonatomic, copy)   NSString     *loanmonth;

@property(nonatomic, copy)   NSString     *repayment;

@property(nonatomic, copy)   NSString     *loanmoney;

@property(nonatomic, copy)   NSString     *tendermoney;

@property(nonatomic, copy)   NSString     *yearrate;

@property(nonatomic, copy)   NSString     *loanstatus;

@property(nonatomic, copy)   NSString     *starttime;

@property(nonatomic, copy)   NSString     *is_sharemater;

@property(nonatomic, assign) NSString     *share_loansn; //null

@property(nonatomic, copy)   NSString     *password;

@property(nonatomic, copy)   NSString     *slt_path;

@property(nonatomic, copy)   NSString     *loan_type;

@property(nonatomic, copy)   NSString     *cate_logo;

@property(nonatomic, assign) long          ratio;

@property(nonatomic, copy)   NSNumber     *rest_days;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;


@end
