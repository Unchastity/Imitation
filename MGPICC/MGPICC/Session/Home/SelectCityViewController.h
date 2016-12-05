//
//  SelectCityViewController.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectCityViewControllerDelegate <NSObject>

@optional
-(void)changeLocation:(NSString *)cityName;

@end

@interface SelectCityViewController : UIViewController

@property(nonatomic, weak) id<SelectCityViewControllerDelegate> delegate;

@end
