//
//  CardMatchingGameViewController.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-23.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardMatchingGameViewController.h"
#import "Deck.h"
#import "SetGameCard.h"

@interface CardMatchingGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;

@end

@implementation CardMatchingGameViewController


- (CardMatchingGame *)game {
    if (!_game) {
        
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                               gamePlayMode:self.mode];
    }
    return _game;
}

- (Deck *) createDeck {
    // abstract class
    return nil;
}


- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)redeal:(id)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [self updateButton:cardButton forCard:card];
    }
    
    [self updateResultLabel];
    [self updateScoreLabel];
    [self updateFlipCountLabel];
}

- (void) updateButton: (UIButton *) button
              forCard: (Card *) card {
    
    // abstract
}

- (void) updateFlipCountLabel{
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)updateResultLabel{
    GameTurn* lastFlip = [self.game lastFlip];
    int points = lastFlip.points;
    
    self.resultLabel.attributedText = [[self class] getResultStringWithLastFlip:            lastFlip
                                                                      andPoints:points];
    self.resultLabel.textAlignment = NSTextAlignmentCenter;
    
}

- (void)updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

+ (NSAttributedString *) getResultStringWithLastFlip: (GameTurn *)lastFlip
                                 andPoints: (int)points {
    return [[NSAttributedString alloc] init];
}



@end
