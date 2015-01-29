//
//  CTEngine.m
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTEngine.h"

@implementation CTEngine

+ (instancetype)sharedEngine
{
    static dispatch_once_t pred;
    static CTEngine *shared = nil;
    dispatch_once(&pred, ^{
        shared = [[CTEngine alloc] init];
    });
    return shared;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSArray *employeesList = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"employeesDB" ofType:@"plist"]];
        
        self.employees = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in employeesList) {
            CTEmployee *employee = [[CTEmployee alloc] initWithDictionary:dict];
            [self.employees addObject:employee];
        }
    }
    
    return self;
}

- (CTEmployee *)employeeWithTipCode:(NSString *)tipCode
{
    CTEmployee *matchingEmployee = nil;
    for (CTEmployee *employee in self.employees) {
        if ([[employee.tipCode lowercaseString] isEqualToString:[tipCode lowercaseString]]) {
            matchingEmployee = employee;
            break;
        }
    }
    return matchingEmployee;
}

@end
