//  Hand.h
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>
@class Card;
@interface Hand : NSObject

@property (strong) NSMutableArray *cards;
@property (readonly) NSNumber *numberOfCards;

+(Hand*)handWithCards:(NSArray*)cards;
-(void)addCard:(Card*)aCard;
-(void)removeCard:(Card*)aCard;
-(void)replaceCard:(Card*)discard WithCard:(Card*)newCard;

-(NSArray*)arrayOfCardsSortedByValueAscending:(BOOL)yn;

-(NSArray*)attributedStringsForCards;

@end
