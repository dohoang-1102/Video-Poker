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
@property (readonly) NSNumber *hardValue;
@property (readonly) NSNumber *softValue;
@property (nonatomic, assign) CardSuit suit;
@property (nonatomic, assign) CardValue value;


// Kind of card
@property (readonly) BOOL isFaceCard;

@property (readonly) BOOL isAce;
@property (readonly) BOOL isTwo;
@property (readonly) BOOL isThree;
@property (readonly) BOOL isFour;
@property (readonly) BOOL isFive;
@property (readonly) BOOL isSix;
@property (readonly) BOOL isSeven;
@property (readonly) BOOL isEight;
@property (readonly) BOOL isNine;
@property (readonly) BOOL isTen;
@property (readonly) BOOL isJack;
@property (readonly) BOOL isQueen;
@property (readonly) BOOL isKing;



+(Card*)cardWithSuit:(NSInteger)zeroToThree andValue:(NSInteger)oneToThirteen;
-(NSString*)suitString;
-(NSString*)valueString;
-(CardValue)cardValueForNumber:(NSNumber*)num;

-(NSMutableAttributedString*)coloredCenteredString;

@end
