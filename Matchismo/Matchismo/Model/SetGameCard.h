//
//  SetCard.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-17.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import "Card.h"

FOUNDATION_EXPORT NSUInteger  const SET_GAME_CARD_NUMBER_ONE;
FOUNDATION_EXPORT NSUInteger  const SET_GAME_CARD_NUMBER_TWO;
FOUNDATION_EXPORT NSUInteger  const SET_GAME_CARD_NUMBER_THREE;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SYMBOL_DIAMOND;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SYMBOL_SQUIGGLE;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SYMBOL_OVAL;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SHADING_SOLID;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SHADING_STRIPED;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_SHADING_OPEN;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_COLOR_RED;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_COLOR_GREEN;
FOUNDATION_EXPORT NSString  *const SET_GAME_CARD_COLOR_PURPLE;

@interface SetGameCard : Card
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

/**
 * Helper Initializer
 */
- (id)initWithNumber:(NSNumber*)number
          withSymbol:(NSString*)symbol
         withShading:(NSString*)shading
           withColor:(NSString*)color;

/**
 * Gets the number of SetGameCard object
 * @return set of NSNumber.
 **/
+(NSSet*) validNumbers;

/**
 * Gets the symbol of SetGameCard object
 * @return set of NSString.
 **/
+(NSSet*) validSymbols;

/**
 * Gets the shading of SetGameCard object
 * @return set of NSString.
 **/
+(NSSet*) validShadings;

/**
 * Gets the color of SetGameCard object
 * @return set of NSString.
 **/
+(NSSet*) validColors;



@end
