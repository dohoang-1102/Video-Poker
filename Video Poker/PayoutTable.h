//  PayoutTable.h
//  Video Poker
//  Created by Martin Nash on 9/30/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>

@class PokerHand;
@interface PayoutTable : NSObject

+(NSNumber*)payoutForHand:(PokerHand*)hand withBetAmount:(NSNumber*)amount;

@end
