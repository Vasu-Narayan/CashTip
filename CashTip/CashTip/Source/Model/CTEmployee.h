//
//  CTEmployee.h
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTEmployee : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *tipCode;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *profilePicName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
