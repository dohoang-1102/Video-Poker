//  UserMoney.m
//  Video Poker
//  Created by Martin Nash on 9/30/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "UserMoney.h"

static NSString *remainingMoneyKey = @"amountRemaining";

@implementation UserMoney

+(NSInteger)reminingMoney
{
    return [[NSUserDefaults standardUserDefaults] integerForKey: remainingMoneyKey];
}

+(void)setRemainingMoney:(NSInteger)amount
{
    [[NSUserDefaults standardUserDefaults] setInteger: amount forKey: remainingMoneyKey];
}

+(NSInteger)withdrawMoney:(NSInteger)amount
{
    NSInteger remainingMoney = [UserMoney reminingMoney];
    remainingMoney -= amount;
    [UserMoney setRemainingMoney: remainingMoney];
    return amount;
}

+(void)addMoney:(NSInteger)amount;
{
    NSInteger balance = [UserMoney reminingMoney];
    balance += amount;
    [UserMoney setRemainingMoney: balance];
}

@end
