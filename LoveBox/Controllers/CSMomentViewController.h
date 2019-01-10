//
//  CSMomentViewController.h
//  LoveBox
//
//  Created by litao on 2018/12/31.
//  Copyright © 2018年 shu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLSwipeableView.h"

@interface CSMomentViewController
: UIViewController <ZLSwipeableViewDataSource, ZLSwipeableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) ZLSwipeableView *swipeableView;

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView;
@end
