//  Hand.m
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "Hand.h"
#import "Card.h"

@interface Hand ()
@end

@implementation Hand

- (id)init
{
    self = [super init];
    if (self) {
        _cards = [NSMutableArray array];
    }
    return self;
}

+(Hand *)handWithCards:(NSArray *)cards
{
    Hand* newHand = [[Hand alloc] init];
    newHand.cards = [NSMutableArray arrayWithArray: cards];
    return newHand;
}


-(void)replaceCard:(Card*)discard WithCard:(Card*)newCard
{
    NSInteger discardIndex = [_cards indexOfObject: discard];
    [_cards replaceObjectAtIndex: discardIndex withObject: newCard];
}

-(void)addCard:(Card*)aCard
{
    [_cards addObject: aCard];
}


-(void)removeCard:(Card*)aCard
{
    [_cards removeObject: aCard];
}


-(NSString *)description
{
    NSMutableString *descString = [NSMutableString string];
    [descString appendFormat: @"%@ { \n", self.class];
    
    [self.cards enumerateObjectsUsingBlock:^(Card *aCard, NSUInteger idx, BOOL *stop) {
        [descString appendFormat: @"\t%@\n", aCard];
    }];
    
    [descString appendString: @"}"];
    return descString;
}

-(NSArray*)attributedStringsForCards
{
    NSMutableArray *cardLabels = [NSMutableArray array];
    for (Card *aCard in _cards) {
        [cardLabels addObject: aCard.coloredCenteredString];
    }
    return cardLabels;
}

#pragma mark - Statistics

-(NSNumber *)numberOfCards
{
    return @( _cards.count );
}

#pragma mark - Sort Cards

-(NSArray*)arrayOfCardsSortedByValueAscending:(BOOL)yn
{
    NSSortDescriptor* valueSorter = [NSSortDescriptor sortDescriptorWithKey: @"value" ascending: yn];
    return [_cards sortedArrayUsingDescriptors: @[ valueSorter ]];
}


@end
