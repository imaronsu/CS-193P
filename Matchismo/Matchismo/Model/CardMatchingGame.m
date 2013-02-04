//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-31.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "CardMatchingGame.h"

@interface  CardMatchingGame()
@property (readwrite, nonatomic) NSUInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (GameTurn *) lastFlip
{
    if (!_lastFlip) _lastFlip = [[GameTurn alloc] init];
    return _lastFlip;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1;

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.lastFlip.points = 0;
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {
            self.score -= FLIP_COST;
            
            self.lastFlip.state = FLIPPED_UP;
            self.lastFlip.points = -FLIP_COST;
            self.lastFlip.cards = @[card];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        
                        self.lastFlip.state = MATCH;
                        self.lastFlip.points += matchScore*MATCH_BONUS;
                        self.lastFlip.cards = @[card, otherCard];
                    } else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        
                        self.lastFlip.state = MISMATCH;
                        self.lastFlip.points -= MISMATCH_PENALTY;
                        self.lastFlip.cards = @[card, otherCard];
                    }
                    break;
                }
            }
        } else {
            self.lastFlip.state = FLIPPED_DOWN;
            self.lastFlip.points = 0;
            self.lastFlip.cards = @[card];
        }
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            
            if (card) {
                self.cards[i] = card;
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

@end
