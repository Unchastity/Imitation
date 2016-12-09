//
//  MGMacro.h
//  zhifu
//
//  Created by Unchastity on 12/6/16.
//  Copyright © 2016 Unchastity. All rights reserved.
//

#ifndef MGMacro_h
#define MGMacro_h

#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT  [[UIScreen mainScreen] bounds].size.height

#define NavigationBarY CGRectGetMaxY(self.navigationController.navigationBar.frame)

#define  deviceHeight   [NSString stringWithFormat:@"device_height=%0.1f", SCREEN_HEIGHT]
#define  deviceUUID     [NSString stringWithFormat:@"_deviceid_=%@", [[UIDevice currentDevice] identifierForVendor].UUIDString]
#define  deviceSysVer   [NSString stringWithFormat:@"20%@", [[UIDevice currentDevice] systemVersion]]
#define  deviceType     [NSString stringWithFormat:@"device_os=%@%%", [[UIDevice currentDevice] systemName]]
#define  deviceWidth    [NSString stringWithFormat:@"device_width=%0.1f", SCREEN_WIDTH]
#define  deviceOS       [deviceType stringByAppendingString: deviceSysVer]


#endif /* MGMacro_h */
