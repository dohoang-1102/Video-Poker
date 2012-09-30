//  VideoPokerRound.m
//  Video Poker
//  Created by Martin Nash on 8/26/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "VideoPokerRound.h"
#import "PokerHand.h"
#import "Card.h"
#import "Deck.h"

@interface VideoPokerRound ()
@property (strong) Deck *theDeck;

@end



@implementation VideoPokerRound

- (id)init
{
    self = [super init];
    if (self) {
        [self startNewRound];
    }
    return self;
}


-(void)startNewRound
{
    _theDeck = [Deck shuffledDeck];
    _theHand = [PokerHand pokerHandFromDeck: _theDeck];
    
    _holdCardOne = NO;
    _holdCardTwo = NO;
    _holdCardThree = NO;
    _holdCardFour = NO;
    _holdCardFive = NO;
    
    _hasDiscarded = NO;
    _canShowHandResult = NO;
}


-(void)discardAndDrawReplacementCards
{
    NSMutableIndexSet *indexesToReplace = [NSMutableIndexSet indexSet];
    
    if (!_holdCardOne)
        [indexesToReplace addIndex: 0];
    
    if (!_holdCardTwo)
        [indexesToReplace addIndex: 1];

    if (!_holdCardThree)
        [indexesToReplace addIndex: 2];

    if (!_holdCardFour)
        [indexesToReplace addIndex: 3];

    if (!_holdCardFive)
        [indexesToReplace addIndex: 4];
    

    // get new cards
    NSArray *newCards = [_theDeck drawNumberOfCards: (int)indexesToReplace.count];
    
    // replace discarded cards with new cards
    [_theHand replaceCardsAtIndexes: indexesToReplace withCards: newCards];
    
    
    // set has discarded
    _hasDiscarded = YES;
    _canShowHandResult = YES;

}


-(void)moveToNextRoundPhase
{
    if (_hasDiscarded) {
        NSLog(@"Has discarded already");
        [self startNewRound];
    } else {
        NSLog(@"First Discard");
        [self discardAndDrawReplacementCards];
    }
}


@end
