//
//  CTAddTipViewController.h
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTEmployee.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface CTAddTipViewController : UIViewController <MBProgressHUDDelegate>

@property (nonatomic, strong) CTEmployee *employee;

@end
