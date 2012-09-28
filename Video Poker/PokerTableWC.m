//  PokerTableWC.m
//  Video Poker
//  Created by Martin Nash on 8/18/12.
//  Copyright (c) 2012 Martin Nash. All rights reserved.


#import "PokerTableWC.h"

#import "VideoPokerRound.h"

#import "Card.h"
#import "Deck.h"
#import "Hand.h"
#import "PokerHand.h"
#import "PokerHand+HandExplanationStrings.h"

NSString* holdCardString = @"HOLD";

@interface PokerTableWC ()

@property (weak) IBOutlet NSButton *cardButton1;
@property (weak) IBOutlet NSButton *cardButton2;
@property (weak) IBOutlet NSButton *cardButton3;
@property (weak) IBOutlet NSButton *cardButton4;
@property (weak) IBOutlet NSButton *cardButton5;

@property (weak) IBOutlet NSTextField *holdLabel1;
@property (weak) IBOutlet NSTextField *holdLabel2;
@property (weak) IBOutlet NSTextField *holdLabel3;
@property (weak) IBOutlet NSTextField *holdLabel4;
@property (weak) IBOutlet NSTextField *holdLabel5;

@property (weak) IBOutlet NSTextField *resultTextField;
@property (weak) IBOutlet NSButton *dealButton;

@property (strong) VideoPokerRound *currentRound;

@end


@implementation PokerTableWC


- (void)windowDidLoad
{
    [super windowDidLoad];
 
    // start up a fresh new round
    _currentRound = [[VideoPokerRound alloc] init];
    [self updateDealButtonLabel];
    [self updateCardButtonLabels];
}


#pragma mark - Enable and disable buttons


-(void)disablePushingCardButtons
{
    [_cardButton1 setEnabled: NO];
    [_cardButton2 setEnabled: NO];
    [_cardButton3 setEnabled: NO];
    [_cardButton4 setEnabled: NO];
    [_cardButton5 setEnabled: NO];
}


-(void)enablePushingCardButtons
{
    [_cardButton1 setEnabled: NO];
    [_cardButton2 setEnabled: NO];
    [_cardButton3 setEnabled: NO];
    [_cardButton4 setEnabled: NO];
    [_cardButton5 setEnabled: NO];
}


#pragma mark - Update labels

-(void)updateResultLabel
{
    if (_currentRound.canShowHandResult)
        _resultTextField.stringValue = [_currentRound.theHand handExplanationString];
    else
        _resultTextField.stringValue = @"";
}


-(void)updateDealButtonLabel
{
    if (_currentRound.hasDiscarded) {
        _dealButton.title = @"Start New Hand";
    } else {
        _dealButton.title = @"Deal Cards";
    }
}


-(void)updateCardButtonLabels
{
    // get attributed strings to put in label
    NSArray *attStrings = [_currentRound.theHand attributedStringsForCards];
    _cardButton1.attributedTitle = attStrings[0];
    _cardButton2.attributedTitle = attStrings[1];
    _cardButton3.attributedTitle = attStrings[2];
    _cardButton4.attributedTitle = attStrings[3];
    _cardButton5.attributedTitle = attStrings[4];
}


-(void)clearHoldLabels
{
    NSArray* holdLabels = @[ _holdLabel1, _holdLabel2, _holdLabel3, _holdLabel4, _holdLabel5 ];
    [holdLabels makeObjectsPerformSelector: @selector(setStringValue:) withObject: @""];
}


#pragma mark - User Interaction


- (IBAction)dealButtonPushed:(id)sender
{
    [_currentRound moveToNextRoundPhase];
    
    if (_currentRound.hasDiscarded) {
        [self disablePushingCardButtons];
    } else {
        [self enablePushingCardButtons];
        [self clearHoldLabels];
    }
    
    
    [self updateDealButtonLabel];
    [self updateCardButtonLabels];
    [self updateResultLabel];
}


- (IBAction)pushedFirstCardButton:(NSButton*)sender
{
    NSTextField* correspondingHoldLabel = nil;
    
    if (sender == _cardButton1) {
        correspondingHoldLabel = _holdLabel1;
        _currentRound.holdCardOne = !_currentRound.holdCardOne;
    }

    if (sender == _cardButton2) {
        correspondingHoldLabel = _holdLabel2;
        _currentRound.holdCardTwo = !_currentRound.holdCardTwo;
    }
    
    if (sender == _cardButton3) {
        correspondingHoldLabel = _holdLabel3;
        _currentRound.holdCardThree = !_currentRound.holdCardThree;
    }
    
    if (sender == _cardButton4) {
        correspondingHoldLabel = _holdLabel4;
        _currentRound.holdCardFour = !_currentRound.holdCardFour;
    }
    
    if (sender == _cardButton5) {
        correspondingHoldLabel = _holdLabel5;
        _currentRound.holdCardFive = !_currentRound.holdCardFive;
    }
    

    
    if ([correspondingHoldLabel.stringValue isEqualToString: holdCardString])
        correspondingHoldLabel.stringValue = @"";
    else
        correspondingHoldLabel.stringValue = holdCardString;
}





@end
