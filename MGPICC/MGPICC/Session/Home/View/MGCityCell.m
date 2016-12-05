//
//  MGCityCell.m
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGCityCell.h"
#import "CityFrameModel.h"
#import "MGMacro.h"

@interface MGCityCell ()

@end

@implementation MGCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//由于每个cell都不同,这里不重用
+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexpath withCityFrameModel:(CityFrameModel *)cityFrameModel
{
    static NSString *cityCellIdentifier = @"cityCellIdentifier";
    //MGCityCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCellIdentifier];
    MGCityCell *cell = [tableView cellForRowAtIndexPath: indexpath];
    if (!cell) {
        //这里的方法只调用有限次，初始化格式，会改变的内容不应该在这里
        cell = [[MGCityCell alloc] initReuseIdentifier:cityCellIdentifier withModel: cityFrameModel];
        cell.backgroundColor = viewControllerBackgroundColor;
    }
    return cell;
}

-(instancetype)initReuseIdentifier:(NSString *)identifier withModel:(CityFrameModel *)cityFrameModel
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        
        NSArray *citiesArr = cityFrameModel.citiesArr;
        int colum = 4;
        
        CGFloat spacing = 1;
        CGFloat btnWidth = (SCREEN_WIDTH - 2 * 10 - 3 * spacing) * 0.25;
        CGFloat btnHeight = 30;
        
        NSInteger totalRows = (citiesArr.count + 3) / colum;
        //分行
        for (int i = 0; i < totalRows;  ++i)
        {
            int row = i;
            NSUInteger loc = i * 4;
            NSUInteger len = 0;
            if (loc + 4 >= citiesArr.count)
            {
                len = citiesArr.count - loc;
            }else
            {
                len = 4;
            }
            NSArray *tmpArr = [citiesArr subarrayWithRange:NSMakeRange(loc, len)];
            //分列
            for (int j = 0; j < 4; ++j)
            {
                CGFloat btnX = (btnWidth + spacing) * j + 10;
                CGFloat btnY = (1 + btnHeight) * row;
                CGRect  frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = frame;
                if (j < tmpArr.count)
                {
                    [btn setTitle:tmpArr[j] forState:UIControlStateNormal];
                }
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.adjustsImageWhenHighlighted = NO;
                btn.backgroundColor = [UIColor whiteColor];
                [self.contentView addSubview: btn];
                
                [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    return self;
}

-(void)clickBtn:(UIButton *)button
{
    NSString *cityName = button.currentTitle;
    if (cityName) {
        if ([self.delegate respondsToSelector:@selector(selectCity:)]) {
            [self.delegate selectCity: cityName];
        }
    }
}

@end
