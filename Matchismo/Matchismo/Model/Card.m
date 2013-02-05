//
//  Card.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-29.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "Card.h"
@interface Card()
@end

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    
    return score;
}

@end
