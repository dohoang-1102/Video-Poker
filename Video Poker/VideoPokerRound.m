//  VideoPokerRound.m
//  Video Poker
//  Created by Martin Nash on 8/26/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "VideoPokerRound.h"
#import "PokerHand.h"
#import "Card.h"
#import "Deck.h"

#import "UserMoney.h"

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
    _betAmount = 0;
    
    _theDeck = [Deck shuffledDeck];
    _theHand = [PokerHand pokerHandFromDeck: _theDeck];
    
    _holdCardOne = NO;
    _holdCardTwo = NO;
    _holdCardThree = NO;
    _holdCardFour = NO;
    _holdCardFive = NO;
    
    _acceptingBets = YES;
    _mayDealCards = NO;
    _hasDealtCards = NO;
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
    // FLOW OF POKER ROUND
    // -----------------------
    // start new round
    // YES accepting bets
    // NO may deal cards
    // NO has dealt cards
    // NO has discarded
    // NO can show hand results
    // -----------------------
    // push make bet buttons
    // YES may deal cards
    // -----------------------
    // push deal cards button
    // NO accepting bets
    // YES has dealt cards
    // -----------------------
    // select cards to hold
    // push deal cards
    // YES has discarded
    // YES show hand results
    
    
    // METHODS TO USE
    // - start new round
    // - draw new hand
    // - discard and draw replacement cards
    

    // CONSIDER ADDING A RoundStage enum for expected user interaction
    // RoundStageTakingBets
    // RoundStageSelectHoldCards
    // RoundStageFinished
    

        
    if (_hasDiscarded) {
        NSLog(@"Has discarded already");
        [self startNewRound];
    } else {
        NSLog(@"First Discard");
        [self discardAndDrawReplacementCards];
    }
}


#pragma mark - Bets

-(void)addOneToBet
{
    if (!_acceptingBets)
        return;
    
    if (_betAmount >= 5)
        return;
    
    NSInteger balance = [UserMoney reminingMoney];
    if (balance >= 1) {
        [UserMoney withdrawMoney: 1];
        _betAmount++;
        _mayDealCards = YES;
    }
}


-(void)betFullBet
{
    if (!_acceptingBets)
        return;
    
    if (_betAmount >= 5)
        return;

    NSInteger balance = [UserMoney reminingMoney];
    if (balance >= 5) {
        [UserMoney withdrawMoney: 5];
        _betAmount += 5;
        _mayDealCards = YES;
    }
}


-(void)clearBet
{
    if (!_acceptingBets)
        return;
    
    [UserMoney addMoney: _betAmount];
    _betAmount = 0;
    
    _mayDealCards = NO;
}

@end
