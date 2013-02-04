//
//  Card.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-29.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

// what's on the card
@property (strong, nonatomic) NSString *contents;

// state of the card
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;


// returns 0 if the others do not match the receiver
// otherwise returns an integer represeting the quality of the match
// 1 should be the simplest, easiest match
// higher numbers should reflect how much more difficult the match was
- (int)match:(NSArray *)otherCards;

@end
