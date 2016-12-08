//
//  MGDataResultModel.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGDataResultModel : NSObject

@property(nonatomic, copy)      NSString        * version_client;

@property(nonatomic, copy)      NSString        * version_currect;

@property(nonatomic, assign)    NSNumber        * update_force;

@property(nonatomic, copy)      NSString        * update_desc;

@property(nonatomic, copy)      NSString        * version_currect_ios;

@property(nonatomic, assign)    NSNumber        * update_force_ios;

@property(nonatomic, copy)      NSString        * update_desc_ios;

@property(nonatomic, copy)      NSString        * lookup_ios_url;

@property(nonatomic, strong)    NSDictionary    * lasted_version_url;

@property(nonatomic, copy)      NSString        * total_lend;

@property(nonatomic, copy)      NSString        * total_rate;

@property(nonatomic, copy)      NSString        * current_lend;

@property(nonatomic, assign)    NSNumber        * is_registration;

@property(nonatomic, strong)    NSDictionary    * newloan;  //

@property(nonatomic, copy)      NSArray         * going_loan;

@property(nonatomic, strong)    NSArray         * user_loan;

@property(nonatomic, copy)      NSString        * mobile;

@property(nonatomic, strong)    NSArray         * banners;



-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;

@end
