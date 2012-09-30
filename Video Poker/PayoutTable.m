//  PayoutTable.m
//  Video Poker
//  Created by Martin Nash on 9/30/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "PayoutTable.h"
#import "PokerHand.h"

@implementation PayoutTable

static const int onePairMultiplier = 1;
static const int twoPairsMultiplier = 2;
static const int threeOfAKindMultiplier = 3;

static const int straightMultiplier = 4;
static const int flushMultiplier = 5;

static const int fullHouseMultiplier = 10;
static const int fourOfAKindMultiplier = 20;

static const int straightFlushMultiplier = 100;
static const int royalFlushPairMultiplier = 500;


+(int)multiplierForResult:(PokerHandResult)result
{
    if (result == PokerHandResultHighCard)
        return 0;
    
    else if (result == PokerHandResultOnePair)
        return onePairMultiplier;
    
    else if (result == PokerHandResultTwoPairs)
        return twoPairsMultiplier;
        
    else if (result == PokerHandResultThreeOfAKind)
        return threeOfAKindMultiplier;

    else if (result == PokerHandResultStraight)
        return straightMultiplier;
    
    else if (result == PokerHandResultFlush)
        return flushMultiplier;
    
    else if (result == PokerHandResultFullHouse)
        return fullHouseMultiplier;
    
    else if (result == PokerHandResultFourOfAKind)
        return fourOfAKindMultiplier;
    
    else if (result == PokerHandResultStraightFlush)
        return straightFlushMultiplier;
    
    else
        return royalFlushPairMultiplier;
    
}

+(NSNumber *)payoutForHand:(PokerHand *)hand withBetAmount:(NSNumber *)amount
{
    // royal flush with five coins pays more than 500 * 5
    if (amount.intValue == 5 && hand.result == PokerHandResultRoyalStraightFlush) {
        return @(3000);
    }
    
    
    int regularMultiplier = [PayoutTable multiplierForResult: hand.result];
    return @(regularMultiplier * amount.intValue);
}

@end
