//
//  GameTurn.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-01.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameTurn : NSObject

typedef enum gameTurnStateType {
    MATCH,
    MISMATCH,
    FLIPPED_UP,
    FLIPPED_DOWN,
    UNKNOWN_STATE
} GameTurnState;

@property (nonatomic) GameTurnState state;
@property (nonatomic) int points;
@property (weak, nonatomic) NSArray* cards;
@end
