//  VideoPokerHand.h
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "Hand.h"

@class Deck;
@interface PokerHand : Hand

typedef enum : NSInteger {
    PokerHandResultHighCard = 0,
    PokerHandResultOnePair,
    PokerHandResultTwoPairs,
    PokerHandResultThreeOfAKind,
    PokerHandResultStraight,
    PokerHandResultFlush,
    PokerHandResultFullHouse,
    PokerHandResultFourOfAKind,
    PokerHandResultStraightFlush,
    PokerHandResultRoyalStraightFlush
} PokerHandResult;

@property (assign) PokerHandResult result;

// CREATE
+(PokerHand*)pokerHandWithCards:(NSArray*)cards;
+(PokerHand*)pokerHandFromDeck:(Deck*)aDeck;

// CHANGE
-(void)replaceCardsAtIndexes:(NSIndexSet*)indexes withCards:(NSArray*)cards;

// COMPARE
-(NSComparisonResult)compare:(PokerHand *)otherHand;
-(BOOL)isBetterThanHand:(PokerHand *)otherHand;
-(BOOL)isEqualToHand:(PokerHand*)otherHand;
-(BOOL)isWorseThanHand:(PokerHand*)otherHand;
-(NSArray*)canonicalHandValueArray;



@end
