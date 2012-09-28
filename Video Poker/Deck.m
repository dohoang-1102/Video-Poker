//  Deck.m
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "Deck.h"
#import "Card.h"

@interface Deck ()
@property (strong) NSMutableArray *allCards;
@end

@implementation Deck
+(Deck*)deck
{
    Deck *newDeck = [[Deck alloc] init];
    return newDeck;
}

+(Deck*)shuffledDeck
{
    Deck *shuffledNewDeck = [[Deck alloc] init];
    [shuffledNewDeck shuffle];
    return shuffledNewDeck;
}

- (id)init
{
    self = [super init];
    if (self) {
        _cards = [NSMutableArray array];
        _allCards = [NSMutableArray array];

        [self createArrayOfAllCards];
        [self fillNewDeck];
    }
    return self;
}

-(void)createArrayOfAllCards
{
    // create the cards
    for (int suit = 0; suit <= 3; suit++) {             // SUITS 0 - 4
        for (int value = 1; value <= 13; value++) {     // VALUES 1 - 13
            Card* aCard = [Card cardWithSuit: suit andValue: value];
            [_allCards addObject: aCard];
        }
    }
}

-(void)fillNewDeck
{
    [_cards removeAllObjects];
    [_cards addObjectsFromArray: _allCards];
}



#pragma mark - Description

-(NSString *)description
{
    NSMutableString *descString = [NSMutableString string];
    [descString appendString: @"DECK: {\n"];
    
    [self.cards enumerateObjectsUsingBlock:^(Card *obj, NSUInteger idx, BOOL *stop) {
        [descString appendFormat: @"\t%@,\n", obj];
    }];
    
    [descString appendString: @"}"];
    return descString;
}

#pragma mark - Organize

-(void)shuffle
{
    NSMutableArray *shuffledDeck = [NSMutableArray array];
    while (_cards.count > 0) {
        NSInteger indexToTake = arc4random() % _cards.count;
        id card = [_cards objectAtIndex: indexToTake];
        [shuffledDeck addObject: card];
        [_cards removeObject: card];
    }
    _cards = shuffledDeck;
}

#pragma mark - Draw Cards

-(Card*)drawACard
{
    if (_cards.count < 1) {
        return nil;
    }

    Card *topCard = _cards[0];
    [_cards removeObject: topCard];
    return topCard;
}

-(NSArray*)drawNumberOfCards:(int)number
{
    if (_cards.count < number) {
        return nil;
    }
    
    NSArray *cardsToDraw = [_cards subarrayWithRange: NSMakeRange(0, number)];
    [_cards removeObjectsInArray: cardsToDraw];
    return cardsToDraw;
}




@end
