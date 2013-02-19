//
//  SetCard.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-17.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "SetGameCard.h"

/**
 * A SetGameCard object is varying in four features: number (1, 2, or 3); symbol (diamond, squiggle, oval); shading (solid, striped, or open); and color (red, green, or purple).
 *
 *  - `number` : { 1 | 2 | 3 }
 *  - `symbol` : { diamond | squiggle | oval }
 *  - `shading` : { solid | striped | open }
 *  - `color` : { red | green | purple }
 *
 *  Following are rules that defines a 'set':
 *
 *  - They all have the same number, or they have three different numbers.
 *
 *  - They all have the same symbol, or they have three different symbols.
 *
 *  - They all have the same shading, or they have three different shadings.
 *
 *  - They all have the same color, or they have three different colors.
 *
 *  The rules of Set are summarized by: If you can sort a group of three cards into "Two of X and one of Y,"
 *  then it is not a set.
 *  @warning *Note:* Any value can passed into attributed. However, class will ignore invalid values. reccomend use convenience initializer to create SetGameCard object;
 **/
@implementation SetGameCard

NSUInteger  const SET_GAME_CARD_NUMBER_ONE      = 1;
NSUInteger  const SET_GAME_CARD_NUMBER_TWO      = 2;
NSUInteger  const SET_GAME_CARD_NUMBER_THREE    = 3;
NSString  *const SET_GAME_CARD_SYMBOL_DIAMOND  = @"diamond";
NSString  *const SET_GAME_CARD_SYMBOL_SQUIGGLE = @"squiggle";
NSString  *const SET_GAME_CARD_SYMBOL_OVAL     = @"oval";
NSString  *const SET_GAME_CARD_SHADING_SOLID   = @"solid";
NSString  *const SET_GAME_CARD_SHADING_STRIPED = @"striped";
NSString  *const SET_GAME_CARD_SHADING_OPEN    = @"open";
NSString  *const SET_GAME_CARD_COLOR_RED       = @"red";
NSString  *const SET_GAME_CARD_COLOR_GREEN     = @"green";
NSString  *const SET_GAME_CARD_COLOR_PURPLE    = @"purple";

#define NUMBER_MATCH_CARDS 2
#define MATCH_BONUS 10

- (id)initWithNumber:(NSNumber*)number withSymbol:(NSString*)symbol withShading:(NSString*)shading withColor:(NSString*)color{
    self = [super init];
    if(self){
        
        self.number = number;
        self.symbol = symbol;
        self.shading = shading;
        self.color = color;
        
        // if any value is not valid, then return nil
        if(!self.number |!self.symbol | !self.shading | !self.color ){
            self = nil;
        }
    }
    return self;
}


-(NSString*) contents{
    return self.symbol;
}

-(NSString*) description{
    return [@[self.number,self.symbol,self.shading,self.color]componentsJoinedByString:@","] ;
}

-(int) match:(NSArray*) cardArray{
    int score = 0;
    if([cardArray count] != NUMBER_MATCH_CARDS){ // game set must compare 3 cards, one itself and two other cards
        
        return score;
    }
    
    NSMutableArray *allThreeCards = [cardArray mutableCopy];
    [allThreeCards addObject:self];
    BOOL pass = true;
    
    pass &= [[self class]isSet:[[self class] getSameItemFromCards: allThreeCards withSelector: @selector(number)]];
    pass &= [[self class]isSet:[[self class] getSameItemFromCards: allThreeCards withSelector: @selector(symbol)]];
    pass &= [[self class]isSet:[[self class] getSameItemFromCards: allThreeCards withSelector: @selector(shading)]];
    pass &= [[self class]isSet:[[self class] getSameItemFromCards: allThreeCards withSelector: @selector(color)]];

    
    score = pass ? MATCH_BONUS : 0;
    
    return score;
}


/**
 * Returns list of object in same group of each card in card array
 * @param cards a SetGameCard array
 * @return array of item in same group
 **/
+(NSArray*) getSameItemFromCards:(NSArray*)cards withSelector:(SEL)getter{
    NSMutableArray *result = [[NSMutableArray alloc]init];
    for(id card in cards){
        if ([card isKindOfClass:[SetGameCard class]]){
            SetGameCard *setGameCard = (SetGameCard *)card;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            id attribute = [setGameCard performSelector:getter];
#pragma clang diagnostic pop
            [result addObject:attribute];
        }
    }
    return result;
}


/**
 * Returns a boolean value to specifiy weather elements in array is a set or not.
 * @param array array to be evluated
 * @return if group of elements is a set or not.
 **/
+(BOOL) isSet:(NSArray*) array{
    BOOL result = true;
    for(id token in array){
        int tokenCountInArray = [[array indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            return [obj isEqual:token];
        }]count];
        if(tokenCountInArray == 1  || tokenCountInArray == [array count]){
            // do nothing
        }else{
            result = false;
        }
    }
    return result;
}

-(void)setNumber:(NSNumber *)number{
    if([[[self class] validNumbers] containsObject: number]){
        _number = number;
    }
}

-(void)setSymbol:(NSString *)symbol{
    if([[[self class] validSymbols] containsObject: symbol]){
        _symbol = symbol;
    }
}

-(void)setShading:(NSString *)shading{
    if([[[self class] validShadings] containsObject: shading]){
        _shading = shading;
    }
}

-(void)setColor:(NSString *)color{
    if([[[self class] validColors] containsObject: color]){
        _color = color;
    }
}


+(NSSet*) validNumbers{
    return[[[NSSet alloc] initWithArray: @[ @(SET_GAME_CARD_NUMBER_ONE), @(SET_GAME_CARD_NUMBER_TWO), @(SET_GAME_CARD_NUMBER_THREE) ]]copy];
}

+(NSSet*) validSymbols{
    return [[[NSSet alloc] initWithArray: @[ SET_GAME_CARD_SYMBOL_DIAMOND, SET_GAME_CARD_SYMBOL_SQUIGGLE , SET_GAME_CARD_SYMBOL_OVAL]]copy];
}

+(NSSet*) validShadings{
    return [[[NSSet alloc] initWithArray: @[ SET_GAME_CARD_SHADING_SOLID, SET_GAME_CARD_SHADING_STRIPED, SET_GAME_CARD_SHADING_OPEN]]copy];
}

+(NSSet*) validColors{
    return [[[NSSet alloc] initWithArray: @[ SET_GAME_CARD_COLOR_RED, SET_GAME_CARD_COLOR_GREEN, SET_GAME_CARD_COLOR_PURPLE]]copy];
}


@end

