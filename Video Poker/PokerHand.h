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

@property (readonly) BOOL isHighCard;
@property (readonly) BOOL isOnePair;
@property (readonly) BOOL isTwoPairs;
@property (readonly) BOOL isThreeOfAKind;
@property (readonly) BOOL isStraight;
@property (readonly) BOOL isFlush;
@property (readonly) BOOL isFullHouse;
@property (readonly) BOOL isFourOfAKind;
@property (readonly) BOOL isStraightFlush;
@property (readonly) BOOL isRoyalStraightFlush;


// came from inside
@property (strong) NSMutableDictionary *valueAnalyzerDictionary;
@property (assign) PokerHandResult result;
@property (readonly) BOOL isHighStraight;
@property (readonly) BOOL isLowStraight;


+(PokerHand*)pokerHandWithCards:(NSArray*)cards;
+(PokerHand*)pokerHandFromDeck:(Deck*)aDeck;

-(void)replaceCardsAtIndexes:(NSIndexSet*)indexes withCards:(NSArray*)cards;

-(NSComparisonResult)compare:(PokerHand *)otherHand;
-(BOOL)isBetterThanHand:(PokerHand *)otherHand;
-(BOOL)isEqualToHand:(PokerHand*)otherHand;
-(BOOL)isWorseThanHand:(PokerHand*)otherHand;
-(NSArray*)canonicalHandValueArray;

@end
