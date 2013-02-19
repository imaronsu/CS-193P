//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-30.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                NSString *frontImageName = [NSString stringWithFormat:@"%@%d", card.suit, card.rank];
                card.backImage = [UIImage imageNamed:@"card-back"];
                card.frontImage = [UIImage imageNamed:frontImageName];
                [self addCard:card atTop:YES];
            }
        }
    }
    
    return self;
}

@end
