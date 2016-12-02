//
//  menuModel.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuModel : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *iconName;


-(instancetype)initWithDict:(NSDictionary *)dict;

+(instancetype)menuModelWithDict:(NSDictionary *) dict;
@end
