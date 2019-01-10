//
//  AppDelegate.h
//  CSTimeLine
//
//  Created by iOS_Chris on 16/8/2.
//  Copyright © 2016年 shu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

