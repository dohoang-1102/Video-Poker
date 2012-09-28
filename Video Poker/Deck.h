//  Deck.h
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>
@class Card;
@interface Deck : NSObject
@property (strong) NSMutableArray *cards;

+(Deck*)deck;
+(Deck*)shuffledDeck;

-(Card*)drawACard;
-(NSArray*)drawNumberOfCards:(int)number;
-(void)shuffle;
-(void)fillNewDeck;

@end
