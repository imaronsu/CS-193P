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

@interface CardGameViewController()
@end

#define NUMBER_OF_CARDS_TO_DEAL 22
@implementation CardGameViewController

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}
- (GamePlayMode)mode {
    return TWO_CARDS_MATCHING;
}

- (void) updateButton: (UIButton *) button
              forCard: (Card *) card {
    if ([card isKindOfClass:[PlayingCard class]]) {
        [button setTitle:card.contents forState:UIControlStateSelected];
        [button setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        button.selected = card.isFaceUp;
        button.enabled = !card.isUnplayable;
        
        button.alpha = (card.isUnplayable ? 0.3 : 1.0);
        
        if (card.isFaceUp)
        {
            [button setImage:card.frontImage
                    forState:UIControlStateNormal];
        } else {
            [button setImage:card.backImage
                    forState:UIControlStateNormal];
            
        }
    }
}

+ (NSAttributedString *) getResultStringWithLastFlip: (GameTurn *)lastFlip
                                 andPoints: (int)points {

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
        resultStr = @"";
    }
    
    return [[NSAttributedString alloc] initWithString:resultStr];
}
@end

