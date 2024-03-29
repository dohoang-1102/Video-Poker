//
//  VideoPokerRound.h
//  Video Poker
//
//  Created by Martin Nash on 8/26/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PokerHand;
@interface VideoPokerRound : NSObject

@property (strong) PokerHand *theHand;

@property (assign) NSInteger betAmount;

@property (assign) BOOL mayDealCards;
@property (assign) BOOL acceptingBets;
@property (assign) BOOL hasDealtCards;
@property (assign) BOOL hasDiscarded;
@property (assign) BOOL canShowHandResult;

@property (assign) BOOL holdCardOne;
@property (assign) BOOL holdCardTwo;
@property (assign) BOOL holdCardThree;
@property (assign) BOOL holdCardFour;
@property (assign) BOOL holdCardFive;

-(void)moveToNextRoundPhase;

-(void)addOneToBet;
-(void)betFullBet;
-(void)clearBet;

@end
