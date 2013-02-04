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

@interface CardMatchingGame : NSObject
@property (readonly, nonatomic) NSUInteger score;
@property (strong, nonatomic) GameTurn *lastFlip;

// designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void) reset;

@end
