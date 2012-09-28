//  Card.h
//  CardTest
//  Created by Martin Nash on 8/6/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    CardSuitSpade = 0,
    CardSuitClub,
    CardSuitHeart,
    CardSuitDiamond
    } CardSuit;

typedef enum : NSInteger {
    CardValueAce = 1,
    CardValueTwo,
    CardValueThree,
    CardValueFour,
    CardValueFive,
    CardValueSix,
    CardValueSeven,
    CardValueEight,
    CardValueNine,
    CardValueTen,
    CardValueJack,
    CardValueQueen,
    CardValueKing,
    } CardValue;

@interface Card : NSObject
@property (readonly) BOOL isFaceCard;
@property (readonly) NSNumber *hardValue;
@property (readonly) NSNumber *softValue;
@property (nonatomic, assign) CardSuit suit;
@property (nonatomic, assign) CardValue value;

+(Card*)cardWithSuit:(NSInteger)zeroToThree andValue:(NSInteger)oneToThirteen;
-(NSString*)suitString;
-(NSString*)valueString;
-(CardValue)cardValueForNumber:(NSNumber*)num;

-(NSMutableAttributedString*)coloredCenteredString;

@end
