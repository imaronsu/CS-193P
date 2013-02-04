//
//  LastFlip.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-01.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "GameTurn.h"

@implementation GameTurn

- (id)init {
    
    self = [super init];
    
    if (self) {
        self.state = UNKNOWN_STATE;
    }
    
    return self;
}

@end
