//  AppDelegate.m
//  Video Poker
//  Created by Martin Nash on 8/18/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.


#import "AppDelegate.h"
#import "PokerTableWC.h"
#import "NSCountedSet+SuperCountedSet.h"

#import "Hand.h"
#import "PokerHand.h"
#import "PokerHand+HandExplanationStrings.h"
#import "Deck.h"
#import "Card.h"

@interface AppDelegate ()
@property (strong) PokerTableWC *ptwc;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
//    _ptwc = [[PokerTableWC alloc] initWithWindowNibName: @"PokerTableWindow"];
//    [_ptwc showWindow: self];
    
    
    while (TRUE) {
        Deck *deck = [Deck shuffledDeck];
        PokerHand* hand = [PokerHand pokerHandFromDeck: deck];
        
        if (hand.result == PokerHandResultStraight) {

            NSLog(@"Straight");
            NSCountedSet *suits = [NSCountedSet set];
            for (Card *aCard in hand.cards) {
                [suits addObject: aCard.suitString];
            }

            if (suits.count == 1)
                NSLog(@"%@", hand);
        }
    
    }
    
    
    
    
    
}

@end
