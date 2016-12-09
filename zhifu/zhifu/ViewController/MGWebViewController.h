//
//  MGWebViewController.h
//  zhifu
//
//  Created by Unchastity on 12/7/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGBaseViewController.h"

@class MGBannersModel;
@interface MGWebViewController :MGBaseViewController

//banner
@property (nonatomic, strong) MGBannersModel *bannersModel;

//others
@property (nonatomic, strong) NSString *urlStr;

@end
