//
//  MGCityCell.h
//  MGPICC
//
//  Created by Unchastity on 12/2/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CityFrameModel;
@protocol MGCityCellDelegate <NSObject>

@optional
-(void)selectCity:(NSString *)cityName;

@end

@interface MGCityCell : UITableViewCell

@property(nonatomic, weak) id<MGCityCellDelegate> delegate;
//@property(nonatomic, strong) CityFrameModel *cityFrameModel;

//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(instancetype)cellWithTableView:(UITableView *)tableView withCityFrameModel:(CityFrameModel *)cityFrameModel;

@end
