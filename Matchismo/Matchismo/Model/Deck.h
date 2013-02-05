//
//  Deck.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-01-29.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
