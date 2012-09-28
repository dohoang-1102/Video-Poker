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
//    _ptwc = [[PokerTableWC alloc] initWithWindowNibName: @"PokerTableWindow"];
//    [_ptwc showWindow: self];
    
    
    NSCountedSet *analyzer = [NSCountedSet set];
    for (int i = 0; i < 10000; i++) {
        [analyzer addObject: @( arc4random() % 5 + 1 )];
    }
    
    NSLog(@"%@", analyzer.arrayOfCountsAscending);
    NSLog(@"%@", analyzer.arrayOfCountsDescending);
    
    
    

    

}

@end
