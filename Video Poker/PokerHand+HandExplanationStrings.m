//  PokerHand+HandExplanationStrings.m
//  CardTest
//  Created by Martin Nash on 8/14/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "PokerHand+HandExplanationStrings.h"
#import "Card.h"

@implementation PokerHand (HandExplanationStrings)

-(NSString *)handExplanationString
{
    
    if (self.result == PokerHandResultOnePair)
        return [self onePairExplanationString];
    
    if (self.result == PokerHandResultTwoPairs)
        return [self twoPairsExplanationString];
    
    if (self.result == PokerHandResultThreeOfAKind)
        return [self threeOfAKindExplanationString];

    if (self.result == PokerHandResultStraight)
        return [self straightExplanationString];
        
    if (self.result == PokerHandResultFlush)
        return [self flushExplanationString];
    
    if (self.result == PokerHandResultFullHouse)
        return [self fullHouseExplanationString];

    if (self.result == PokerHandResultFourOfAKind)
        return [self fourOfAKindExplanationString];

    if (self.result == PokerHandResultStraightFlush)
        return [self straightFlushExplanationString];
    
    if (self.result == PokerHandResultRoyalStraightFlush)
        return [self royalStraightFlushExplanationString];
    
    return [self highCardExplanationString];
}

-(NSString *)highCardExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *highCardNumber = canonicalArray[0];
    NSArray *kickers = [canonicalArray subarrayWithRange: NSMakeRange(1, 4)];
    
    return [NSString stringWithFormat: @"High card %@, with kickers %@", highCardNumber, [kickers componentsJoinedByString: @", "]];
}

-(NSString *)onePairExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *pairNumber = canonicalArray[0];
    NSArray *kickers = [canonicalArray subarrayWithRange: NSMakeRange(1, 3)];
    
    return [NSString stringWithFormat: @"Pair of %@s with kickers %@", pairNumber, [kickers componentsJoinedByString: @", "]];
}

-(NSString *)twoPairsExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *highPairNumber = canonicalArray[0];
    NSNumber *lowPairNumber = canonicalArray[1];
    NSNumber *kicker = canonicalArray[2];
    
    return [NSString stringWithFormat: @"Two Pairs %@s and %@s, with a %@ kicker", highPairNumber, lowPairNumber, kicker];
}

-(NSString *)threeOfAKindExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *threeOfAKindNubmer = canonicalArray[0];
    NSArray *kickers = [canonicalArray subarrayWithRange: NSMakeRange(1, 2)];
    
    return [NSString stringWithFormat: @"Three %@s with kickers %@", threeOfAKindNubmer, [kickers componentsJoinedByString: @", "]];
}

-(NSString*)straightExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *highCardNumber = canonicalArray[0];
    return [NSString stringWithFormat: @"Straight starting at %@", highCardNumber];
}

-(NSString*)flushExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSString *numbersAndCommas = [canonicalArray componentsJoinedByString: @", "];
    Card *firstCard = self.cards[0];
    return [NSString stringWithFormat: @"%@ flush with numbers %@", firstCard.suitString, numbersAndCommas];
}

-(NSString*)fullHouseExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *threeCardsValue = canonicalArray[0];
    NSNumber *twoCardsValue = canonicalArray[1];
    return [NSString stringWithFormat: @"Full house %@ over %@", threeCardsValue, twoCardsValue];
}

-(NSString*)fourOfAKindExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSNumber *fourOfAKindNumber = canonicalArray[0];
    NSNumber *kickerNumber = canonicalArray[1];
    return [NSString stringWithFormat: @"Four of a kind: four %@s with a %@ kicker", fourOfAKindNumber, kickerNumber];
}

-(NSString*)straightFlushExplanationString
{
    NSArray *canonicalArray = [self canonicalHandValueArray];
    NSString *numbersAndCommas = [canonicalArray componentsJoinedByString: @", "];
    Card *firstCard = self.cards[0];
    return [NSString stringWithFormat: @"%@ Straight Flush with numbers %@", firstCard.suitString, numbersAndCommas];
}


-(NSString*)royalStraightFlushExplanationString
{
    Card *firstCard = self.cards[0];
    return [NSString stringWithFormat: @"%@ Royal Straight Flush", firstCard.suitString];
}

@end
