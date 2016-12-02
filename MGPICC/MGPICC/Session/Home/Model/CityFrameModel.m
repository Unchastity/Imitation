//
//  CityFrameModel.m
//  MGPICC
//
//  Created by Unchastity on 12/1/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "CityFrameModel.h"

@implementation CityFrameModel

-(instancetype)initWithArray:(NSArray *)arr
{
    self = [super init];
    if (self) {
        CGFloat spacing = 1;
        CGFloat cellHeight  = 30;
        
        NSUInteger total = arr.count;
        NSUInteger row = (total + 3) / 4;
        
        _citiesArr = arr;
        _cellsHeight = cellHeight * row + spacing * (row - 1);
    }
    return self;
}

+(instancetype)cityFrameModelWithArray:(NSArray *)arr
{
    return [[self alloc] initWithArray: arr];
}

@end
