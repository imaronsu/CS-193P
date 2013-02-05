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
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    self.lastFlip.points = 0;
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {

            // Gather all of the cards to be matched
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                }
            }
            
            self.score -= FLIP_COST;
            
            self.lastFlip.state = FLIPPED_UP;
            self.lastFlip.points = -FLIP_COST;
            self.lastFlip.cards = @[card];
            
            if ((otherCards.count+1) == self.playMode) {
                
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    // we have a match
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    card.unplayable = YES;
                    
                    self.score += matchScore * MATCH_BONUS;
                    
                    self.lastFlip.state = MATCH;
                    self.lastFlip.points += matchScore*MATCH_BONUS;
                    
                    [otherCards addObject:card];
                    self.lastFlip.cards = [NSArray arrayWithArray:otherCards];
                } else {
                    // we don't have a match
                    
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    
                    self.score -= MISMATCH_PENALTY;
                    
                    self.lastFlip.state = MISMATCH;
                    self.lastFlip.points -= MISMATCH_PENALTY;
                    
                    [otherCards addObject:card];
                    self.lastFlip.cards = [NSArray arrayWithArray:otherCards];;
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
    return[self initWithCardCount:count usingDeck:deck gamePlayMode:TWO_CARDS_MATCHING];
}

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
           gamePlayMode:(GamePlayMode) mode
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
        
        self.playMode = mode;
    }
    
    return self;
}

@end
