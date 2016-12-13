//
//  MGInviteLoanModel.h
//  zhifu
//
//  Created by Unchastity on 12/13/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGInviteLoanModel : NSObject

@property(nonatomic, copy)   NSString     *id;          //"id": "11788",

@property(nonatomic, copy)   NSString     *loansn;      //"loansn": "11480664718116",

@property(nonatomic, copy)   NSString     *title;       //"title": "\u6c7d\u8f66\u91d1\u878d\u3010\u7b2c11494\u671f\u3011\u9a6c\u81ea\u8fbe \u62b5\u62bc\u501f\u6b3e\u3010\u5f20\u5bb6\u6e2f\u7ad9\u3011",
@property(nonatomic, copy)   NSString     *cateid;      //"cateid": "1",

@property(nonatomic, copy)   NSString     *loanmonth;   //"loanmonth": "3",

@property(nonatomic, copy)   NSString     *repayment;   //"repayment": "2",

@property(nonatomic, copy)   NSString     *loanmoney;   //"loanmoney": "80,000",

@property(nonatomic, copy)   NSString     *tendermoney; //"tendermoney": "80,000",

@property(nonatomic, copy)   NSString     *yearrate;    //"yearrate": "7.00",

@property(nonatomic, copy)   NSString     *extrarate;   //"extrarate": "0.00",

@property(nonatomic, copy)   NSString     *loanstatus;  //"loanstatus": "4",

@property(nonatomic, copy)   NSString     *type;        //"type": "1",

@property(nonatomic, copy)   NSString     *starttime;   //"starttime": "2016-12-03 16:21:13",

@property(nonatomic, copy)   NSString     *lasttendertime;  //"lasttendertime": "2016-12-02 16:21:13",

@property(nonatomic, copy)   NSString     *is_sharemater;   //"is_sharemater": "0",

@property(nonatomic, copy)   NSString     *share_loansn;    //"share_loansn": null,

@property(nonatomic, copy)   NSString     *is_day;          //"is_day": "1",

@property(nonatomic, copy)   NSString     *loan_type;       //"loan_type": "normal",

@property(nonatomic, assign) NSInteger    *flag;            //"flag": 1,

@property(nonatomic, assign) NSInteger    *ratio;           //"ratio": 100,

@property(nonatomic, copy)   NSString     *path;            //"path": null,

@property(nonatomic, copy)   NSString     *cate_logo;       //"cate_logo": "http:\/\/static.zhifu360.com",

@property(nonatomic, copy)   NSString     *msg;             //"msg": "90\u5929"


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
