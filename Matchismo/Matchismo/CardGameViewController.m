//
//  CardGameViewController.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-28.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "GameTurn.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) NSInteger flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *dealButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gamePlayMode;
@end

@implementation CardGameViewController
- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]
                                                gamePlayMode:TWO_CARDS_MATCHING];
    }
    return _game;
}


- (IBAction)switchGamePlayMode:(UISegmentedControl *)sender {
    if (self.gamePlayMode.selectedSegmentIndex == 0) {
        _game.playMode = TWO_CARDS_MATCHING;
    } else if (self.gamePlayMode.selectedSegmentIndex == 1) {
        _game.playMode = THREE_CARDS_MATCHING;
    } else {
        NSLog(@"IN AN UNKNOWN GAME PLAY MODE");
    }
}

- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
}

- (IBAction)flipCard:(UIButton *)sender {
    self.gamePlayMode.enabled = NO;
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
    self.gamePlayMode.enabled = YES;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        
        cardButton.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        if (card.isFaceUp)
        {
            [cardButton setImage:nil
                        forState:UIControlStateNormal];
        } else {
            [cardButton setImage:card.backImage
                        forState:UIControlStateNormal];

        }
    }
    
    [self updateResultLabel];
    [self updateScoreLabel];
    [self updateFlipCountLabel];
}

- (void) updateFlipCountLabel{
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)updateResultLabel{
    GameTurn* lastFlip = [self.game lastFlip];
    int points = lastFlip.points;
    NSString* resultStr;
    

    Card* card;
    NSString *strToAppend;
    
    
    // the first card
    card = lastFlip.cards[0];
    NSString *cardsStr = [NSString stringWithFormat:@"%@", card.contents];
        
    if ([lastFlip.cards count] > 1){
        
        
        for (int i = 1; i < [lastFlip.cards count]-1; i++) {
            card = lastFlip.cards[i];
            strToAppend = [NSString stringWithFormat:@", %@", card.contents];
            cardsStr = [cardsStr stringByAppendingString:strToAppend];
        }
        
        // last card
        card = [lastFlip.cards lastObject];
        strToAppend = [NSString stringWithFormat:@" and %@", card.contents];
        cardsStr = [cardsStr stringByAppendingString:strToAppend];
    }


    if (lastFlip.state == MATCH) {
        resultStr = [NSString stringWithFormat:@"Matched %@ for %d points", cardsStr, points];

    } else if (lastFlip.state == MISMATCH) {
        resultStr = [NSString stringWithFormat:@"%@ don't match, %d points", cardsStr, points];
        
    } else if (lastFlip.state == FLIPPED_UP) {
        resultStr = [NSString stringWithFormat:@"Flipped up %@, %d point", cardsStr, points];
        
    } else if (lastFlip.state == FLIPPED_DOWN) {
        resultStr = [NSString stringWithFormat:@"Flipped down %@, %d point", cardsStr, points];
    } else {
        resultStr = nil;
    }
    
    self.resultLabel.text = resultStr;
}

- (void)updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

@end
