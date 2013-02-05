//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-31.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
#import "GameTurn.h"

typedef enum gamePlayModeType {
    TWO_CARDS_MATCHING = 2,
    THREE_CARDS_MATCHING = 3
} GamePlayMode;

@interface CardMatchingGame : NSObject
@property (readonly, nonatomic) NSUInteger score;
@property (strong, nonatomic) GameTurn *lastFlip;
@property (nonatomic) GamePlayMode playMode;

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
           gamePlayMode:(GamePlayMode) mode;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
