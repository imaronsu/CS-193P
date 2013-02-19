//
//  SetCardDeck.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-17.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "SetGameCard.h"
#import "SetGameCardDeck.h"

@implementation SetGameCardDeck

- (id)init {
    
    self = [super init];
    if(self){
        for(NSNumber *number in [SetGameCard validNumbers]){
            for(NSString *symbol in [SetGameCard validSymbols] ){
                for(NSString *shading in [SetGameCard validShadings]){
                    for(NSString *color in [SetGameCard validColors]) {
                        SetGameCard *card = [[SetGameCard alloc]initWithNumber:number withSymbol:symbol withShading:shading withColor:color];
                        
                        if(card){
                            [self addCard:card atTop:YES];
                        }
                    }
                }
            }
        }
    }
    
    return self;
}

@end
