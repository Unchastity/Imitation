//
//  MGWeatherView.m
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGWeatherView.h"

@implementation MGWeatherView

-(MGWeatherView *)initWeatherViewWithFrame:(CGRect)frame weather:(NSString *)weather
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIImage *xiaolabaImage = [UIImage imageNamed:@"xiaolaba"];
        //NSLog(@"xiaolaba image: %@", NSStringFromCGSize(xiaolabaImage.size));
        UIImageView *xiaolabaImageView = [[UIImageView alloc] init];
        xiaolabaImageView.frame = CGRectMake(5, 5, 30, 30);
        [xiaolabaImageView setImage: xiaolabaImage];
        [self addSubview: xiaolabaImageView];
        
        UIImage *image = [UIImage imageNamed:@"tianqitixing"];
        //NSLog(@"tianqi image frame: %@", NSStringFromCGSize(image.size));
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(CGRectGetMaxX(xiaolabaImageView.frame), 5, 138, 30);
        [imageView setImage: image];
        [self addSubview: imageView];
        
        UILabel *tianqiLabel = [[UILabel alloc] init];
        CGFloat labelX = CGRectGetMaxX(imageView.frame) + 5;
        CGFloat labelY = 1;
        CGFloat labelW = self.frame.size.width - labelX;
        CGFloat labelH = self.frame.size.height - labelY * 2;
        tianqiLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
        tianqiLabel.textAlignment = NSTextAlignmentLeft;
        tianqiLabel.font = [UIFont systemFontOfSize:18];
        if (weather.length == 0) {
            weather = @"获取城市天气信息失败";
        }
        [tianqiLabel setText:weather];
        [self addSubview: tianqiLabel];
    }
    
    return self;
}
@end
