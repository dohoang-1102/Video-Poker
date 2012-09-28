//  VideoPokerHand.m
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.


#define DescendingIntValueSortDescriptor [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: NO]
#define kHandSizeLimit 5

#import "PokerHand.h"
#import "Card.h"
#import "Deck.h"

@interface PokerHand ()
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
    [newVph updateValueAnalyzerDictionary];
    [newVph analyzeHandToSetResultStatus];
    return newVph;
}


// try making this
+(PokerHand*)pokerHandFromDeck:(Deck*)aDeck
{
    PokerHand *newHand = [[PokerHand alloc] init];

    NSArray *fiveCards = [aDeck drawNumberOfCards: kHandSizeLimit];

    [newHand.cards addObjectsFromArray: fiveCards];
    [newHand updateValueAnalyzerDictionary];
    [newHand analyzeHandToSetResultStatus];

    return newHand;
}


-(void)replaceCardsAtIndexes:(NSIndexSet*)indexes withCards:(NSArray*)cards
{
    [self.cards replaceObjectsAtIndexes: indexes withObjects: cards];
    [self updateValueAnalyzerDictionary];
    [self analyzeHandToSetResultStatus];
}


-(void)replaceCard:(Card*)discard WithCard:(Card*)newCard
{
    [super replaceCard: discard WithCard: newCard];
    [self updateValueAnalyzerDictionary];
    [self analyzeHandToSetResultStatus];
}


-(void)addCard:(Card *)aCard
{
    if (self.cards.count > kHandSizeLimit)
        return;
    
    [super addCard: aCard];
    [self updateValueAnalyzerDictionary];
    [self analyzeHandToSetResultStatus];
}


-(void)removeCard:(Card *)aCard
{
    [super removeCard: aCard];
    [self updateValueAnalyzerDictionary];
    [self analyzeHandToSetResultStatus];
}


-(void)updateValueAnalyzerDictionary
{
    _valueAnalyzerDictionary = [NSMutableDictionary dictionary];
    for (Card *aCard in self.cards) {


        if ( ![_valueAnalyzerDictionary.allKeys containsObject: aCard.hardValue] ) {

            // first one found, give it count of one
            _valueAnalyzerDictionary[aCard.hardValue] = @1;

        } else {

            // already in dictionary - increment the count
            NSNumber *oldCardValueCount = _valueAnalyzerDictionary[aCard.hardValue];
            NSNumber *newCardValueCount = @( oldCardValueCount.intValue + 1 );
            _valueAnalyzerDictionary[aCard.hardValue] = newCardValueCount;

        }
    }    
}


-(void)analyzeHandToSetResultStatus
{
    if ([self analyzerFoundRoyalFlush])
        self.result = PokerHandResultRoyalStraightFlush;
    
    else if ([self analyzerFoundStraightFlush])
        self.result = PokerHandResultStraightFlush;
    
    else if ([self analyzerFoundFourOfAKind])
        self.result = PokerHandResultFourOfAKind;
    
    else if ([self analyzerFoundFullHouse])
        self.result = PokerHandResultFullHouse;
    
    else if ([self analyzerFoundFlush])
        self.result = PokerHandResultFlush;
    
    else if ([self analyzerFoundStraight])
        self.result = PokerHandResultStraight;
    
    else if ([self analyzerFoundThreeOfAKind])
        self.result = PokerHandResultThreeOfAKind;

    else if ([self analyzerFoundTwoPairs])
        self.result = PokerHandResultTwoPairs;

    else if ([self analyzerFoundOnePair])
        self.result = PokerHandResultOnePair;
    
    else
        self.result = PokerHandResultHighCard;
}





#pragma mark - Sorted Arrays




-(NSArray*)distinctCardValueNumbersFromLowestToHighest
{
    // values and keyes are both numbers
    // key - card value number
    // value - appearance count
    
    NSSortDescriptor *ascendingIntValues = [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: YES];
    return [self.valueAnalyzerDictionary.allKeys sortedArrayUsingDescriptors: @[ ascendingIntValues ]];
}



-(NSArray*)cardAppearanceCountNumbersFromHighestToLowest
{
    NSSortDescriptor *descendingAppearanceCounts = [NSSortDescriptor sortDescriptorWithKey: @"intValue" ascending: NO];
    return [self.valueAnalyzerDictionary.allValues sortedArrayUsingDescriptors: @[ descendingAppearanceCounts ]];
}



-(NSArray*)cardValueNumbersSortedByAppearanceCountNumbers
{
    // you can reverse the normal order by comparing second object with first object
    // orthodox sort: 1 compare 2
    // backward sort: 2 compare 1
    
    NSArray *sortedValues = [self.valueAnalyzerDictionary keysSortedByValueUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare: obj1];
    }];
    
    return sortedValues;
}


#pragma mark - Hand BOOLs


-(BOOL)isHighCard
{
    return self.result == PokerHandResultHighCard;
}

-(BOOL)isOnePair
{
    return self.result == PokerHandResultOnePair;
}

-(BOOL)isTwoPairs
{
    return self.result == PokerHandResultTwoPairs;
}

-(BOOL)isThreeOfAKind
{
    return self.result == PokerHandResultThreeOfAKind;
}

-(BOOL)isStraight
{
    return self.result == PokerHandResultStraight;
}

-(BOOL)isFlush
{
    return self.result == PokerHandResultFlush;
}

-(BOOL)isFullHouse
{
    return self.result == PokerHandResultFullHouse;
}

-(BOOL)isFourOfAKind
{
    return self.result == PokerHandResultFourOfAKind;
}

-(BOOL)isStraightFlush
{
    return self.result == PokerHandResultStraightFlush;
}

-(BOOL)isRoyalStraightFlush
{
    return self.result == PokerHandResultRoyalStraightFlush;
}




#pragma mark - Straight and Flush Hands


-(BOOL)analyzerFoundFlush
{
    Card *firstCard = self.cards[0];
    __block BOOL flush = YES;
    
    [self.cards enumerateObjectsUsingBlock:^(Card *currentCard, NSUInteger idx, BOOL *stop) {
        if (currentCard.suit != firstCard.suit) {
            flush = NO;
            *stop = YES;
        }
    }];
    
    return flush;
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

-(BOOL)analyzerFoundStraight
{
    if (self.isHighStraight)
        return YES;
    
    if (self.isLowStraight)
        return YES;
    
    if (_valueAnalyzerDictionary.count != 5)
        return NO;
    
    NSArray *cardValues = [self distinctCardValueNumbersFromLowestToHighest];

    NSNumber *lowestNumber = cardValues[0];
    NSNumber *secondNumber = @( lowestNumber.intValue + 1 );
    NSNumber *thirdNumber  = @( lowestNumber.intValue + 2 );
    NSNumber *fourthNumber = @( lowestNumber.intValue + 3 );
    NSNumber *fifthNumber  = @( lowestNumber.intValue + 4 );
    
    NSArray *straightFromLowest = @[ lowestNumber, secondNumber, thirdNumber, fourthNumber, fifthNumber ];

    return [cardValues isEqualToArray: straightFromLowest];
}

-(BOOL)analyzerFoundStraightFlush
{
    return (self.isStraight && self.isFlush);
}

-(BOOL)analyzerFoundRoyalFlush
{
    return (self.isHighStraight && self.isFlush);
}

-(BOOL)analyzerFoundOnePair
{
    // has four kinds of cards
    // 2 - 1 - 1 - 1
    
    return ( _valueAnalyzerDictionary.count == 4 );
}

-(BOOL)analyzerFoundTwoPairs
{
    // there are three kinds of card values
    // not a three of a kind
    // counts: 2 - 2 - 1 (descending)
    
    NSArray *highToLowAppearance = [self cardAppearanceCountNumbersFromHighestToLowest];
    NSArray *twoTwoOne = @[ @2, @2, @1 ];
    return [highToLowAppearance isEqualToArray: twoTwoOne];    
}

-(BOOL)analyzerFoundFullHouse
{
    // 3 - 2

    // there are only two types of card values
    // the counts are 3 - 2
    
    NSArray *highToLowAppearance = [self cardAppearanceCountNumbersFromHighestToLowest];
    NSArray *threeTwo = @[ @3, @2 ];
    return [highToLowAppearance isEqualToArray: threeTwo];
}

-(BOOL)analyzerFoundThreeOfAKind
{
    // 3 - 1 - 1

    if (_valueAnalyzerDictionary.count != 3)
        return NO;
    
    NSArray *highToLowAppearance = [self cardAppearanceCountNumbersFromHighestToLowest];
    NSArray *threeOneOne = @[ @3, @1, @1 ];
    return [highToLowAppearance isEqualToArray: threeOneOne];
}

-(BOOL)analyzerFoundFourOfAKind
{
    // 4 - 1
    
    if (_valueAnalyzerDictionary.count != 2)
        return NO;

    NSArray *highToLowApperance = [self cardAppearanceCountNumbersFromHighestToLowest];
    NSArray *fourOne = @[ @4, @1 ];
    return [highToLowApperance isEqualToArray: fourOne];
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
    
    return [_valueAnalyzerDictionary.allKeys sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
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
    
    return [_valueAnalyzerDictionary.allKeys sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
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
    return [_valueAnalyzerDictionary.allKeys sortedArrayUsingDescriptors: @[ DescendingIntValueSortDescriptor ]];
}




@end
