//
//  CTEmployee.m
//  CashTip
//
//  Created by Vasu Narayan on 15/12/14.
//  Copyright (c) 2014 Synclovis. All rights reserved.
//

#import "CTEmployee.h"

@implementation CTEmployee

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = [dictionary objectForKey:@"name"];
        self.tipCode = [dictionary objectForKey:@"tipCode"];
        self.company = [dictionary objectForKey:@"company"];
        self.location = [dictionary objectForKey:@"Location"];
        self.profilePicName = [dictionary objectForKey:@"profilePicName"];
    }
    
    return self;
}

@end
