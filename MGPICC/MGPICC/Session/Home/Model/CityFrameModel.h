//
//  CityFrameModel.h
//  MGPICC
//
//  Created by Unchastity on 12/1/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CityFrameModel : NSObject

@property(nonatomic, strong) NSArray *citiesArr;

@property(nonatomic, assign) CGFloat   cellsHeight;

-(instancetype)initWithArray:(NSArray *)arr;

+(instancetype)cityFrameModelWithArray:(NSArray *)arr;

@end
