//
//  PlayingCard.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-30.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

// the suit must be one of the strings returned by +validSuits
// a suit of nil means this card hs never had its suit set
// invalid suits (including nil) will be ignored by the setter
@property (strong, nonatomic) NSString *suit;

// the rank must be between 0 and +maxRank
// a rank of 0 means this card has never had its rank set (or was reset)
// invalid ranks will be ignored by the setter
@property (nonatomic) NSUInteger rank;

// array of valid suit strings
// this should be an NSSet
+ (NSArray *) validSuits; // of NSString
+ (NSUInteger) maxRank;

@end
