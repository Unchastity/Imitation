//
//  MGMacro.h
//  MGPICC
//
//  Created by Unchastity on 11/30/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#ifndef MGMacro_h
#define MGMacro_h

#define RGBA(r, g, b, a)  [UIColor colorWithRed:r/255.0f green: g/255.0f blue: b/255.0f alpha: a]
#define RGB(r, g, b)      RGBA(r, g, b, 1.0f)

//navigationBar background color
#define navigationBarBackgroundColor   RGB(200, 25, 30)
#define viewControllerBackgroundColor  RGB(236, 236, 236);
//#define separaterCorlor                RGB(200, 199, 204)

#define SCREEN_WIDTH      [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT     [[UIScreen mainScreen] bounds].size.height

#define BaiDuAK    pxT5YtUVmtdFPItOVmRXR7rVQsgmS0f1

#define MGSelectedHistoryCityPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent: @"historyCityData"]

#endif /* MGMacro_h */
