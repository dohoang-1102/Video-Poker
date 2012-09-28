//  AppDelegate.m
//  Video Poker
//  Created by Martin Nash on 8/18/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.


#import "AppDelegate.h"
#import "PokerTableWC.h"
#import "NSCountedSet+SuperCountedSet.h"


@interface AppDelegate ()
@property (strong) PokerTableWC *ptwc;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _ptwc = [[PokerTableWC alloc] initWithWindowNibName: @"PokerTableWindow"];
    [_ptwc showWindow: self];
}

@end
