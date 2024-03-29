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

#import "UserMoney.h"

@interface AppDelegate ()
@property (strong) PokerTableWC *ptwc;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [UserMoney setRemainingMoney: 500];
    
    _ptwc = [[PokerTableWC alloc] initWithWindowNibName: @"PokerTableWindow"];
    [_ptwc showWindow: self];
}



@end
