//  VideoPokerHand.m
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.


#define DescendingIntValueSortDescriptor [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: NO]
#define kHandSizeLimit 5

#import "NSCountedSet+SuperCountedSet.h"
#import "PokerHand.h"
#import "Card.h"
#import "Deck.h"

@interface PokerHand ()
@property (readonly) BOOL isHighStraight;
@property (readonly) BOOL isLowStraight;
@end




@implementation PokerHand


- (id)init
{
    self = [super init];
    if (self) {
        self.result = PokerHandResultHighCard;
    }
    return self;
}


+(PokerHand*)pokerHandWithCards:(NSArray*)cards
{
    if (cards.count > kHandSizeLimit) {
        return nil;
    }
    
    PokerHand *newVph = [[PokerHand alloc] init];
    newVph.cards = [NSMutableArray arrayWithArray: cards];
    [newVph analyzeHandToSetResultStatus];
    return newVph;
}


// try making this
+(PokerHand*)pokerHandFromDeck:(Deck*)aDeck
{
    PokerHand *newHand = [[PokerHand alloc] init];

    NSArray *fiveCards = [aDeck drawNumberOfCards: kHandSizeLimit];

    [newHand.cards addObjectsFromArray: fiveCards];
    [newHand analyzeHandToSetResultStatus];

    return newHand;
}


-(void)replaceCardsAtIndexes:(NSIndexSet*)indexes withCards:(NSArray*)cards
{
    [self.cards replaceObjectsAtIndexes: indexes withObjects: cards];
    [self analyzeHandToSetResultStatus];
}


-(void)replaceCard:(Card*)discard WithCard:(Card*)newCard
{
    [super replaceCard: discard WithCard: newCard];
    [self analyzeHandToSetResultStatus];
}


-(void)addCard:(Card *)aCard
{
    if (self.cards.count > kHandSizeLimit)
        return;
    
    [super addCard: aCard];
    [self analyzeHandToSetResultStatus];
}


-(void)removeCard:(Card *)aCard
{
    [super removeCard: aCard];
    [self analyzeHandToSetResultStatus];
}


-(NSCountedSet*)countedSetOfHardValues
{
    NSCountedSet *analyzer = [NSCountedSet set];
    for (Card *aCard in self.cards) {
        [analyzer addObject: aCard.hardValue];
    }
    return analyzer;
}




-(void)analyzeHandToSetResultStatus
{
    if (self.isRoyalStraightFlush)
        self.result = PokerHandResultRoyalStraightFlush;
    
    else if (self.isStraightFlush)
        self.result = PokerHandResultStraightFlush;
    
    else if (self.isFourOfAKind)
        self.result = PokerHandResultFourOfAKind;
    
    else if (self.isFullHouse)
        self.result = PokerHandResultFullHouse;
    
    else if (self.isFlush)
        self.result = PokerHandResultFlush;
    
    else if (self.isStraight)
        self.result = PokerHandResultStraight;
    
    else if (self.isThreeOfAKind)
        self.result = PokerHandResultThreeOfAKind;

    else if (self.isTwoPairs)
        self.result = PokerHandResultTwoPairs;

    else if (self.isOnePair)
        self.result = PokerHandResultOnePair;
    
    else
        self.result = PokerHandResultHighCard;
}





#pragma mark - Sorted Arrays



-(NSArray*)cardValueNumbersSortedByAppearanceCountNumbers
{
    
    // lots of this number, less of this number, and even less of this number ...
    // ex: 3 2s, 1 4, and 1 10
    
    NSCountedSet *cs = [self countedSetOfHardValues];
    return cs.objectsInOrderOfCountDescending;    
}


-(NSArray*)distinctCardValuesInDescendingOrder
{
    NSCountedSet *cs = [self countedSetOfHardValues];
    NSMutableArray *values = [NSMutableArray arrayWithArray: cs.allObjects];
    NSSortDescriptor *descIntValSD = [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: NO];
    return [values sortedArrayUsingDescriptors: @[ descIntValSD ] ];
}

#pragma mark - Hand BOOLs


-(BOOL)isHighCard
{
    return self.result == PokerHandResultHighCard;
}

-(BOOL)isOnePair
{
    NSCountedSet *cs = [self countedSetOfHardValues];
    NSArray *onePairPattern = @[ @2, @1, @1, @1 ];
    return [onePairPattern isEqualToArray: cs.arrayOfCountsDescending];
}

-(BOOL)isTwoPairs
{
    NSCountedSet* cs = [self countedSetOfHardValues];
    NSArray* twoPairPattern = @[ @2, @2, @1 ];
    return [twoPairPattern isEqualToArray: cs.arrayOfCountsDescending];
}

-(BOOL)isThreeOfAKind
{
    NSCountedSet* cs = [self countedSetOfHardValues];
    NSArray* threeOfAKindPattern = @[ @3, @1, @1 ];
    return [threeOfAKindPattern isEqualToArray: cs.arrayOfCountsDescending];
}

-(BOOL)isHighStraight
{
    NSArray *ascendingValues = [self arrayOfCardsSortedByValueAscending: YES];
    
    Card *aceCard = ascendingValues[0];
    Card *tenCard = ascendingValues[1];
    Card *jackCard = ascendingValues[2];
    Card *queenCard = ascendingValues[3];
    Card *kingCard = ascendingValues[4];
    
    if (aceCard.value != CardValueAce)
        return NO;
    
    if (tenCard.value != CardValueTen)
        return NO;
    
    if (jackCard.value != CardValueJack)
        return NO;
    
    if (queenCard.value != CardValueQueen)
        return NO;
    
    if (kingCard.value != CardValueKing)
        return NO;
    
    return YES;
}

-(BOOL)isLowStraight
{
    NSArray *ascendingValues = [self arrayOfCardsSortedByValueAscending: YES];
    
    Card *aceCard = ascendingValues[0];
    Card *twoCard = ascendingValues[1];
    Card *threeCard = ascendingValues[2];
    Card *fourCard = ascendingValues[3];
    Card *fiveCard = ascendingValues[4];
    
    if (aceCard.value != CardValueAce)
        return NO;
    
    if (twoCard.value != CardValueTwo)
        return NO;
    
    if (threeCard.value != CardValueThree)
        return NO;
    
    if (fourCard.value != CardValueFour)
        return NO;
    
    if (fiveCard.value != CardValueFive)
        return NO;
    
    return YES;
}

-(BOOL)isStraight
{
    if (self.isHighStraight || self.isLowStraight)
        return YES;
    
    // have to have five cards to have a straight
    NSCountedSet *cs = [self countedSetOfHardValues];
    if (cs.count < 5)
        return NO;
    
    
    // need to check the value of the hands
    // n, n+1, n+2, n+3, n+4
    
    NSSortDescriptor *descendingCardValuesDescriptor = [NSSortDescriptor sortDescriptorWithKey: @"value" ascending: NO];
    NSArray *cardsInDescendingValue = [self.cards sortedArrayUsingDescriptors: @[ descendingCardValuesDescriptor ]];
    
    Card* highestCard       = cardsInDescendingValue[0];
    Card* secondHighestCard = cardsInDescendingValue[1];
    Card* thirdHighestCard  = cardsInDescendingValue[2];
    Card* fourthHighestCard = cardsInDescendingValue[3];
    Card* fifthHighestCard  = cardsInDescendingValue[4];
    
    int highestCardValue       = highestCard.hardValue.intValue;
    int secondHighestCardValue = secondHighestCard.hardValue.intValue;
    int thirdHighestCardValue  = thirdHighestCard.hardValue.intValue;
    int fourthHighestCardValue = fourthHighestCard.hardValue.intValue;
    int fifthHighestCardValue  = fifthHighestCard.hardValue.intValue;
    
    if (highestCardValue == secondHighestCardValue + 1)
        if (highestCardValue == thirdHighestCardValue + 2)
            if (highestCardValue == fourthHighestCardValue + 3)
                if (highestCardValue == fifthHighestCardValue + 4)
                    return YES;
    
    return NO;
    
    
    

    
    
    
//    cs.arrayOfCountsDescending
    
    return self.result == PokerHandResultStraight;
}

-(BOOL)isFlush
{
    NSCountedSet *flushChecker = [NSCountedSet set];

    for (Card *aCard in self.cards)
         [flushChecker addObject: aCard.suitString];
    
    return flushChecker.count == 1;
}

-(BOOL)isFullHouse
{
    NSCountedSet* cs = [self countedSetOfHardValues];
    NSArray* fullHousePattern = @[ @3, @2 ];
    return [fullHousePattern isEqualToArray: cs.arrayOfCountsDescending];
}

-(BOOL)isFourOfAKind
{
    NSCountedSet *cs = [self countedSetOfHardValues];
    NSArray *fourOfAKindPattern = @[ @4, @1 ];
    return [fourOfAKindPattern isEqualToArray: cs.arrayOfCountsDescending];
}

-(BOOL)isStraightFlush
{
    return (self.isStraight && self.isFlush && !self.isHighStraight);
}

-(BOOL)isRoyalStraightFlush
{
    return (self.isFlush && self.isHighStraight);
}




#pragma mark - Compare Hands


-(NSComparisonResult)compare:(PokerHand *)otherHand
{
    if (self.result > otherHand.result)
        return NSOrderedAscending;

    
    else if (self.result < otherHand.result)
        return NSOrderedDescending;
    
    else
        return [self compareCanonicalArrayToThatOfAnotherHand: otherHand];
}


-(NSComparisonResult)compareCanonicalArrayToThatOfAnotherHand:(PokerHand*)otherHand
{
    NSArray *myCanonicalArray = [self canonicalHandValueArray];
    NSArray *otherCanonicalArray = [otherHand canonicalHandValueArray];
    
    __block NSComparisonResult myRestult = NSOrderedSame;
    
    [myCanonicalArray enumerateObjectsUsingBlock:^(NSNumber *myCurrentNumber, NSUInteger idx, BOOL *stop) {
        
        NSNumber *otherCurrentNumber = otherCanonicalArray[idx];
        
        if ([myCurrentNumber isGreaterThan: otherCurrentNumber]) {
            myRestult = NSOrderedAscending;
            *stop = YES;
        }
        
        
        if ([myCurrentNumber isLessThan: otherCurrentNumber]) {
            myRestult = NSOrderedDescending;
            *stop = YES;
        }
    }];
    
    return myRestult;
}


-(BOOL)isBetterThanHand:(PokerHand *)otherHand
{
    return [self compare: otherHand] == NSOrderedAscending;
}


-(BOOL)isEqualToHand:(PokerHand *)otherHand
{
    return [self compare: otherHand] == NSOrderedSame;
}


-(BOOL)isWorseThanHand:(PokerHand *)otherHand
{
    return [self compare: otherHand] == NSOrderedDescending;
}









#pragma mark - Canonical Arrays



-(NSArray*)canonicalHandValueArray
{
    switch (self.result) {
            
        case PokerHandResultHighCard:
            return [self highCardNumberValues];
            break;
            
        case PokerHandResultOnePair:
            return [self onePairCanonicalArray];
            break;
            
        case PokerHandResultTwoPairs:
            return [self twoPairsCanonicalArray];
            break;
            
        case PokerHandResultThreeOfAKind:
            return [self threeOfAKindCanonicalArray];
            break;
            
        case PokerHandResultStraight:
            return [self straightCanonicalArray];
            break;
            
        case PokerHandResultFlush:
            return [self flushCanonicalArray];
            break;
            
        case PokerHandResultFullHouse:
            return [self fullHouseCanonicalArray];
            break;
            
        case PokerHandResultFourOfAKind:
            return [self fourOfAKindCanonicalArray];
            break;
            
        case PokerHandResultStraightFlush:
            return [self straightFlushCanonicalArray];
            break;
            
        case PokerHandResultRoyalStraightFlush:
            return [self royalStraightFlushCanonicalArray];
            break;
            
        default:
            break;
    }
    
    return nil;
}



#pragma mark - Winning Cards High And Low Values


// ROYAL STRAIGHT FLUSH

-(NSArray*)royalStraightFlushCanonicalArray
{
    return [self straightFlushCanonicalArray];
}





// STRAIGHT FLUSH

-(NSArray *)straightFlushNumberValuesInDescendingOrder
{
    return [self straightNumberValuesInDescendingOrder];
}


-(NSArray*)straightFlushCanonicalArray
{
    return [self straightFlushNumberValuesInDescendingOrder];
}











// FOUR OF A KIND

-(NSNumber*)fourOfAKindSetOfFourValue
{
    // four of a kind pattern
    // 4 - 1
    
    if (self.result != PokerHandResultFourOfAKind) {
        return nil;
    }
    
    NSArray *cardValuesByNumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesByNumberOfAppearances[0];
}


-(NSNumber*)fourOfAKindKickerValue
{
    // four of a kind pattern
    // 4 - 1
    
    if (self.result != PokerHandResultFourOfAKind) {
        return nil;
    }
    
    NSArray *cardValuesByNumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesByNumberOfAppearances[1];
}


-(NSArray*)fourOfAKindCanonicalArray
{
    return @[
    [self fourOfAKindSetOfFourValue],
    [self fourOfAKindKickerValue]
    ];
}










// FULL HOUSE

-(NSNumber*)fullHouseThreeCardValue
{
    // full house count
    // 3 - 2
    
    if (self.result != PokerHandResultFullHouse) {
        return nil;
    }
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesBynumberOfAppearances[0];
}


-(NSNumber*)fullHouseTwoCardValue
{
    // full house count
    // 3 - 2
    
    if (self.result != PokerHandResultFullHouse) {
        return nil;
    }
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesBynumberOfAppearances[1];
}


-(NSArray*)fullHouseCanonicalArray
{
    return @[
    [self fullHouseThreeCardValue],
    [self fullHouseTwoCardValue]
    ];
}







// FLUSH

-(NSArray *)flushNumberValuesInDescendingOrder
{
    // flush pattern
    // all cards same suit
    // all cards different value
    
    if (self.result != PokerHandResultFlush)
        return nil;
    
    return [self distinctCardValuesInDescendingOrder];
}


-(NSNumber *)flushHighNumberValue
{
    // flush pattern
    // all cards same suit
    // all cards different value
    
    if (self.result != PokerHandResultFlush)
        return nil;
    
    NSArray *descendingFlushValues = [self flushNumberValuesInDescendingOrder];
    return descendingFlushValues[0];
}


-(NSArray*)flushCanonicalArray
{
    return [self flushNumberValuesInDescendingOrder];
}











// STRAIGHT






-(NSArray *)straightNumberValuesInDescendingOrder
{
    // handle the ACE
    // need to have the 14 turn into a 1
    if (self.isLowStraight)
        return @[ @5, @4, @3, @2, @1 ];
    
    return [self distinctCardValuesInDescendingOrder];
}


-(NSArray*)straightCanonicalArray
{
    return [self straightNumberValuesInDescendingOrder];
}










// THREE OF A KIND


-(NSNumber *)threeOfAkindThreePairValue
{
    // three of a kind pattern
    // 3 - 1 - 1
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesBynumberOfAppearances[0];
}



-(NSArray *)threeOfAKindKickersInDescendingOrder
{
    // three of a kind pattern
    // 3 - 1 - 1
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    NSArray *kickers = [cardValuesBynumberOfAppearances subarrayWithRange: NSMakeRange(1, 2)];
    
    return [kickers sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
}



-(NSNumber *)threeOfAkindFirstKickerValue
{
    // three of a kind pattern
    // 3 - 1 - 1
    
    NSArray *threeOfAKindKickers = [self threeOfAKindKickersInDescendingOrder];
    return threeOfAKindKickers[0];
}



-(NSNumber *)threeOfAKindSecondKickerValue
{
    // three of a kind pattern
    // 3 - 1 - 1
    
    NSArray *threeOfAKindKickers = [self threeOfAKindKickersInDescendingOrder];
    return threeOfAKindKickers[1];
}



-(NSArray *)threeOfAKindCanonicalArray
{
    NSMutableArray* ma = [NSMutableArray array];
    [ma addObject: [self threeOfAkindThreePairValue]];
    [ma addObjectsFromArray: [self threeOfAKindKickersInDescendingOrder]];
    return [NSArray arrayWithArray: ma];
}










// TWO PAIRS

-(NSArray*)twoPairsPairValuesInDescendingOrder
{
    // Two Pairs Pattern
    // 2 - 2 - 1
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    NSArray *twoPairsValues = [cardValuesBynumberOfAppearances subarrayWithRange: NSMakeRange(0, 2)];
    
    return [twoPairsValues sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
}


-(NSNumber *)twoPairsHighPairValue
{
    // Two Pairs Pattern
    // 2 - 2 - 1
    
    NSArray *twoPairsValuesInDescendingOrder = [self twoPairsPairValuesInDescendingOrder];
    return twoPairsValuesInDescendingOrder[0];
}


-(NSNumber *)twoPairsLowPairValue
{
    // Two Pairs Pattern
    // 2 - 2 - 1
    
    NSArray *twoPairsValuesInDescendingOrder = [self twoPairsPairValuesInDescendingOrder];
    return twoPairsValuesInDescendingOrder[1];
}


-(NSNumber *)twoPairsKickerValue
{
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesBynumberOfAppearances[2];
}



-(NSArray*)twoPairsCanonicalArray
{
    return @[ self.twoPairsHighPairValue, self.twoPairsLowPairValue, self.twoPairsKickerValue ];
}









// ONE PAIR


-(NSNumber *)onePairPairValue
{
    // ONE PAIR PATTERN
    // 2 - 1 - 1 - 1
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    return cardValuesBynumberOfAppearances[0];
}


-(NSArray *)onePairKickersInDescendingOrder
{
    // ONE PAIR PATTERN
    // 2 - 1 - 1 - 1
    
    NSArray *cardValuesBynumberOfAppearances = [self cardValueNumbersSortedByAppearanceCountNumbers];
    NSArray *kickerValues = [cardValuesBynumberOfAppearances subarrayWithRange: NSMakeRange(1, 3)];
    
    return [kickerValues sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
}


-(NSArray *)onePairCanonicalArray
{
    NSMutableArray *ma = [NSMutableArray array];
    [ma addObject: [self onePairPairValue]];
    [ma addObjectsFromArray: [self onePairKickersInDescendingOrder]];
    return [NSArray arrayWithArray: ma];
}





// HIGH CARD

-(NSArray *)highCardNumberValues
{
    return [self distinctCardValuesInDescendingOrder];
}




@end
