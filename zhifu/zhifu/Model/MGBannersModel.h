//
//  MGBannersModel.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGBannersModel : NSObject

@property(nonatomic, copy)   NSString     *image;

@property(nonatomic, copy)   NSString     *title;

@property(nonatomic, copy)   NSString     *href;

@property(nonatomic, assign) NSString     *is_share;

@property(nonatomic, copy)   NSString     *share_title;

@property(nonatomic, copy)   NSString     *share_desc;

@property(nonatomic, copy)   NSString     *share_url;

@property(nonatomic, copy)   NSString     *share_pic;


-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)modelWithDict:(NSDictionary *)dict;


@end
