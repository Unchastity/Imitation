//
//  MGSingleCellView.m
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "MGInitialCell.h"
#import "MGMacro.h"

@implementation MGInitialCell


+(instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath withArray:(NSArray *)arr
{
    static NSString *cellID = @"cellID";
    MGInitialCell *cell = [tableView cellForRowAtIndexPath: indexPath];
    if (!cell) {
        cell = [[MGInitialCell alloc] initWithArray: arr andID: cellID];
        cell.backgroundColor = viewControllerBackgroundColor;
    }
    return cell;
    
}

-(instancetype)initWithArray:(NSArray *)array andID:(NSString *)cellID
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    if (self) {
        
        int colum = 5;
        CGFloat spacing = 1.0;
        CGFloat btnWidth = (SCREEN_WIDTH - 2 * 10 - 3 * spacing) * 0.20;
        CGFloat btnHeight = 25;
        
        NSInteger totalRows = (array.count + colum - 1) / colum;
        //分行
        for (int i = 0; i < totalRows;  ++i)
        {
            int row = i;
            NSUInteger loc = i * colum;
            NSUInteger len = 0;
            if (loc + colum >= array.count)
            {
                len = array.count - loc;
            }else
            {
                len = colum;
            }
            NSArray *tmpArr = [array subarrayWithRange:NSMakeRange(loc, len)];
            //分列
            for (int j = 0; j < colum; ++j)
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

-(void)clickBtn:(UIButton *)sender
{
    NSString *title = sender.currentTitle;
    if (title.length > 0) {
        if ([self.delegate respondsToSelector:@selector(clickInitialBtn:)]) {
            [self.delegate clickInitialBtn: title];
        }
    }
}

@end
