//
//  UIImage+Color.h
//  MGPICC
//
//  Created by Unchastity on 11/29/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)


/**
 纯色的image

 @param color UIColor
 @param size image size
 @return image with color
 */
+(UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

/**
 导航栏的背景色

 @param color UIColor
 @return 纯色image
 */
+(UIImage *)navigationBarBackgroundImageWithColor:(UIColor *)color;
@end
