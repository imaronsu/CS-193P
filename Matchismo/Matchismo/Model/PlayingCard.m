//
//  PlayingCard.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-30.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
#define SAME_RANK_BONUS 4
#define SAME_SUIT_BONUS 1
- (int)match:(NSArray *)otherCards
{
    bool match = NO;
    NSUInteger numCardsWithSameRank = 0;
    int score = 0;
    
    for (id otherCard in otherCards)
    {
        if ([otherCard isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = (PlayingCard *)otherCard;
            
            
            
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                match = YES;
            } else if (otherPlayingCard.rank == self.rank) {
                numCardsWithSameRank += 1;
            }
            else{
                match = NO;
                break;
            }
        }
    }
    
    if (match){
        score += otherCards.count*SAME_SUIT_BONUS;
    } else{
        if (numCardsWithSameRank == otherCards.count ){
            score += numCardsWithSameRank*SAME_RANK_BONUS;
        }
    }
    
    return score;
}

// contents is concatenation of rank and suit
// rank is represented as a string by indexing into +rankStrings
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

// must synthesize suit because we implement both setter and getter
@synthesize suit = _suit;

// the four suits as strings
+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

// validates that the passed suit is one of the +validSuits
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// returns ? if the suit has never been set (i.e. is nil)
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

// converts rank of 0 to ?
// converts rank of 1 to A
// converts ranks of 11, 12, 13, to J, Q, K
+ (NSArray *)rankStrings
{
    return @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

// returns the maximum legal rank
+ (NSUInteger)maxRank
{
    return [self rankStrings].count-1;
}

// ensures that the set rank is legal
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
@end
