//
//  CTEngine.h
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTEmployee.h"

@interface CTEngine : NSObject

@property (nonatomic, strong) NSMutableArray *employees;

+ (instancetype)sharedEngine;

- (CTEmployee *)employeeWithTipCode:(NSString *)tipCode;

@end
