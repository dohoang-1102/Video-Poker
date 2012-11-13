//  UserMoney.h
//  Video Poker
//  Created by Martin Nash on 9/30/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>

@interface UserMoney : NSObject

+(NSInteger)reminingMoney;
+(void)setRemainingMoney:(NSInteger)amount;

+(NSInteger)withdrawMoney:(NSInteger)amount;
+(void)addMoney:(NSInteger)amount;

@end
