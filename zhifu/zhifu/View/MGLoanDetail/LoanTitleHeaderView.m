//
//  LoanTitleHeaderView.m
//  zhifu
//
//  Created by Unchastity on 12/10/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import "LoanTitleHeaderView.h"
#import "MGMacro.h"
@interface LoanTitleHeaderView ()

@property (nonatomic, weak) UILabel *loansnLabel;
@property (nonatomic, weak) UILabel *loanTitleLabel;

@end

@implementation LoanTitleHeaderView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    [super drawRect: rect];
//}
//
//先调用，此时headerView 的size为0，再调用drawRect
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier: reuseIdentifier];
    if (self) {
        
//        CGRect headerViewFrame  = self.contentView.frame; // height = 70
//        CGRect headerViewFrame = self.frame;
        UILabel *loansnLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, SCREEN_WIDTH - 24, 19)];
        loansnLabel.font = [UIFont systemFontOfSize: 10.0];
        loansnLabel.textAlignment = NSTextAlignmentLeft;
        loansnLabel.textColor = [UIColor blackColor];
        self.loansnLabel = loansnLabel;
        [self.contentView addSubview: loansnLabel];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(8, 30, SCREEN_WIDTH - 24, 30)];
        titleLabel.font = [UIFont systemFontOfSize: 15.0];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        self.loanTitleLabel = titleLabel;
        [self.contentView addSubview: titleLabel];
    }
    return self;
}

////重写 superclass 的textLabel
//-(UILabel *)textLabel
//{
//    CGRect headerViewFrame  = self.contentView.frame; // height = 70
//    UILabel *loansnLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, headerViewFrame.size.width - 24, 19)];
//    loansnLabel.font = [UIFont systemFontOfSize: 10.0];
//    loansnLabel.textAlignment = NSTextAlignmentLeft;
//    loansnLabel.textColor = [UIColor blackColor];
//    
//    return loansnLabel;
//}
////重写superClass 的detailTextLabel
//-(UILabel *)detailTextLabel
//{
//    CGRect headerViewFrame  = self.contentView.frame; // height = 70
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(8, 30, headerViewFrame.size.width - 24, 30)];
//    titleLabel.font = [UIFont systemFontOfSize: 15.0];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.textColor = [UIColor blackColor];
//    return titleLabel;
//}

-(void)setTitle:(NSString *)title
{
    _title = title;
    [self.loanTitleLabel setText: title];
    //[self.textLabel setText: title];
}

-(void)setLoansn:(NSString *)loansn
{
    _loansn = loansn;
    [self.loansnLabel setText: loansn];
    //[self.detailTextLabel setText: loansn];
}

@end
