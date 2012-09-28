//  Card.m
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import "Card.h"
@implementation Card

+(Card *)cardWithSuit:(NSInteger)zeroToThree andValue:(NSInteger)oneToThirteen
{
    Card* newCard = [[Card alloc] init];
    newCard.suit = zeroToThree;
    newCard.value = oneToThirteen;
    return newCard;
}

#pragma mark - Description

-(NSString *)description
{
    return [NSString stringWithFormat: @"%@ %@", self.suitString, self.valueString];
}

-(NSString*)suitString
{
    switch (self.suit) {
        case CardSuitClub:
            return @"♣";
            break;
        
        case CardSuitDiamond:
            return @"♦";
            break;
        
        case CardSuitHeart:
            return @"♥";
            break;
        
        case CardSuitSpade:
            return @"♠";
            break;
            
        default:
            return nil;
            break;
    }
    
    return nil;
}

-(NSString*)valueString
{
    switch (self.value) {
        case CardValueAce:
            return @"Ace";
            break;

        case CardValueJack:
            return @"Jack";
            break;
            
        case CardValueQueen:
            return @"Queen";
            break;
        
        case CardValueKing:
            return @"King";
            break;
            
        default:
            return [NSString stringWithFormat: @"%ld", self.value];
            break;
    }
    
    return nil;
}

-(NSMutableAttributedString*)coloredCenteredString
{    
    // SET THE COLOR
    NSColor *strColor = [NSColor blackColor];
    if (_suit == CardSuitDiamond || _suit == CardSuitHeart)
        strColor = [NSColor redColor];
    
    // SET THE ALIGNMENT
    NSMutableParagraphStyle *ps = [[NSMutableParagraphStyle alloc] init];
    [ps setAlignment: NSCenterTextAlignment];
    
    NSMutableAttributedString *colorString = [[NSMutableAttributedString alloc] initWithString: self.description];
    [colorString addAttribute: NSParagraphStyleAttributeName value: ps range: NSMakeRange(0, colorString.length)];
    [colorString addAttribute: NSForegroundColorAttributeName value: strColor range: NSMakeRange(0, colorString.length)];

    return colorString;
}

#pragma mark - Characteristics

-(CardValue)cardValueForNumber:(NSNumber *)num
{
    if (num.integerValue == 14)
        return CardValueAce;
    
    return (CardValue)num.integerValue;
}

-(NSNumber *)hardValue
{
    if (_value == CardValueAce)
        return @14;

    return @(_value);
}

-(NSNumber *)softValue
{
    return @(_value);
}

-(BOOL)isFaceCard
{
    if (_value == CardValueKing)
        return YES;

    if (_value == CardValueQueen)
        return YES;

    if (_value == CardValueJack)
        return YES;

    return NO;
}


@end
