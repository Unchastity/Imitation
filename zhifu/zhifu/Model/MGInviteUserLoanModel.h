//
//  MGInviteUserLoanModel.h
//  zhifu
//
//  Created by Unchastity on 12/16/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGInviteUserLoanModel : NSObject

@property(nonatomic, copy)   NSString     *ID;  //"id": "1540",

@property(nonatomic, copy)   NSString     *memberid;    //"memberid": "56430",

@property(nonatomic, copy)   NSString     *password;    //"password": "",

@property(nonatomic, copy)   NSString     *user_loansn; //"user_loansn": "11467024226325",

@property(nonatomic, copy)   NSString     *loansn;  //"loansn": "11456465630758",

@property(nonatomic, copy)   NSString     *title;   //"title": "\u6c7d\u8f66\u91d1\u878d\u3010\u7b2c5495\u671f\u3011\u4e1c\u98ce\u96ea\u8f76\u9f99    \u62b5\u62bc\u501f\u6b3e\u3010\u957f\u6c99\u7ad9\u3011",
@property(nonatomic, copy)   NSString     *type;    //"type": "2",

@property(nonatomic, copy)   NSString     *loanmonth;   //"loanmonth": "12",

@property(nonatomic, copy)   NSString     *loanmoney;   //"loanmoney": "3390.00",

@property(nonatomic, copy)   NSString     *ratemoney;   //"ratemoney": "406.80",

@property(nonatomic, copy)   NSString     *mintendermoney;  //"mintendermoney": "0.00",

@property(nonatomic, copy)   NSString     *tendermoney; //"tendermoney": "3390.00",

@property(nonatomic, copy)   NSString     *yearrate;    //"yearrate": "12.00",

@property(nonatomic, copy)   NSString     *tendersn;    //"tendersn": "314565378847193102",

@property(nonatomic, copy)   NSString     *issuesn; //"issuesn": "21456467424162515",

@property(nonatomic, copy)   NSString     *allotsn; //"allotsn": "41456537884719915",

@property(nonatomic, copy)   NSString     *plat_money;  //"plat_money": "67.80",

@property(nonatomic, copy)   NSString     *overflow_money;  //"overflow_money": "0.00",

@property(nonatomic, copy)   NSString     *loanstatus;  //"loanstatus": "3",

@property(nonatomic, copy)   NSString     *starttime;   //"starttime": "2016-06-27 18:43:46",

@property(nonatomic, copy)   NSString     *endtime; //"endtime": "2016-06-27 18:49:47",

@property(nonatomic, copy)   NSString     *lasttime;    //"lasttime": "2016-06-27 18:49:47",

@property(nonatomic, copy)   NSString     *status;  //"status": "2",

@property(nonatomic, copy)   NSString     *timeadd; //"timeadd": "2016-06-27 18:43:46",

@property(nonatomic, copy)   NSString     *edittime;    //"edittime": "2016-06-27 18:43:46",

@property(nonatomic, copy)   NSString     *finish_time; //"finish_time": "2016-06-27 23:50:00",

@property(nonatomic, copy)   NSString     *already_ratemoney;   //"already_ratemoney": "135.60",

@property(nonatomic, copy)   NSString     *not_ratemoney;   //"not_ratemoney": "271.20",

@property(nonatomic, copy)   NSString     *periode;    //"periode": "5",

@property(nonatomic, copy)   NSString     *pay_ment_date;   //"pay_ment_date": "2016-07-26",

@property(nonatomic, copy)   NSString     *redpacket;   //"redpacket": "0",

@property(nonatomic, copy)   NSString     *repayment;   //"repayment": "2",

@property(nonatomic, copy)   NSString     *overflow_money_back; //"overflow_money_back": "0.00",

@property(nonatomic, copy)   NSString     *cateid;  //"cateid": "1",

@property(nonatomic, assign) long          ratio;   //"ratio": 100,

@property(nonatomic, assign) long          rest_days;    //"rest_days": 239

-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
