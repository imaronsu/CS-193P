//
//  SetGameViewController.m
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-18.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//
#import "CardMatchingGame.h"
#import "SetGamecard.h"
#import "SetGameCardDeck.h"
#import "SetGameViewController.h"

#import <QuartzCore/QuartzCore.h>

#define NUMBER_OF_CARDS_TO_DEAL 16

@implementation SetGameViewController

- (Deck *) createDeck {
    return [[SetGameCardDeck alloc] init];
}

- (GamePlayMode)mode {
    return THREE_CARDS_MATCHING;
}

/**
 * Update the UI for the button
 **/
- (void) updateButton: (UIButton *) button
              forCard: (Card *) card {
    
    if ([card isKindOfClass:[SetGameCard class]]) {
        [button setAttributedTitle:[[self class] attributedStringForCard:(SetGameCard *)card withFontSize:button.titleLabel.font.pointSize]
                          forState:UIControlStateSelected];
        [button setAttributedTitle:[[self class] attributedStringForCard:(SetGameCard *)card withFontSize:button.titleLabel.font.pointSize]
                          forState:UIControlStateSelected|UIControlStateDisabled];
        [button setAttributedTitle:[[self class] attributedStringForCard:(SetGameCard *)card withFontSize:button.titleLabel.font.pointSize]
                          forState:UIControlStateNormal];
        
        button.selected = card.isFaceUp;
        button.enabled = !card.isUnplayable;
        [[button layer] setCornerRadius:8.0f];
        
        if (card.isUnplayable) {
            [[button layer] setBorderWidth:0.0f];
            [[button layer] setBorderColor:[UIColor blackColor].CGColor];
            button.alpha = 0.3;
        }
        else
        {
            button.alpha = 1.0;
        }
        
        if (button.selected) {
            [[button layer] setBorderWidth:2.0f];
            [[button layer] setBorderColor:[UIColor blueColor].CGColor];
            [[button layer] setCornerRadius:8.0f];
        } else {
            [[button layer] setBorderWidth:0.0f];
            [[button layer] setBorderColor:[UIColor blackColor].CGColor];
        }
    }
}

#pragma mark - Helper Functions

# define RESULT_STRING_FONT_SIZE 12
+ (NSAttributedString *) getResultStringWithLastFlip: (GameTurn *)lastFlip
                                           andPoints: (int)points {
    NSMutableAttributedString* result = [[NSMutableAttributedString alloc] init];
    CGFloat fontSize = RESULT_STRING_FONT_SIZE;
    
    for (id card in lastFlip.cards) {
        if ([card isKindOfClass:[SetGameCard class]]) {
            [result appendAttributedString:[[self class] attributedStringForCard:(SetGameCard *)card withFontSize: fontSize]];
            if (![card isEqual:[lastFlip.cards lastObject]]){
                [result appendAttributedString:[[NSAttributedString alloc] initWithString:@"&"]];
            }
        }
    }
    
    if (lastFlip.state == MATCH) {
        [result insertAttributedString:[[NSAttributedString alloc] initWithString:@"Matched "] atIndex:0];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" for %d points", points]]];
        
    } else if (lastFlip.state == MISMATCH) {
        [result appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" don't match, %d points", points]]];
    } else if (lastFlip.state == FLIPPED_UP) {
        [result insertAttributedString:[[NSAttributedString alloc] initWithString:@"Flipped up "] atIndex:0];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" ,%d points", points]]];
    } else if (lastFlip.state == FLIPPED_DOWN) {
        [result insertAttributedString:[[NSAttributedString alloc] initWithString:@"Flipped down "] atIndex:0];
        [result appendAttributedString:[[NSAttributedString alloc] initWithString: [NSString stringWithFormat:@" ,%d points", points]]];
    } else {
        result = [[NSMutableAttributedString alloc] init];
    }
    
    return result;
}


+(NSAttributedString*) attributedStringForCard:(SetGameCard*)card
                                  withFontSize:(CGFloat) fontSize {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc]init];
    NSString *cardDisplayString = @"";
    
    for(int i=0 ; i < [card.number intValue] ; i++){
        cardDisplayString = [cardDisplayString stringByAppendingString:[[self class] displayStringForSymbol:card.symbol]];
    }
    
    [result setAttributedString:[[NSAttributedString alloc]initWithString:cardDisplayString]];
    
    NSDictionary *attribute = @{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize],
                                 NSForegroundColorAttributeName : [[self class]forgroundColorForCard:card],
                                 NSStrokeWidthAttributeName : @-10,
                                 NSStrokeColorAttributeName :  [[self class]strokeColorForCard:card] };
    
    [result setAttributes:attribute range:[[result string]rangeOfString:[result string]]];
    
    return result;
}

+(UIColor*)forgroundColorForCard:(SetGameCard*)card{
    NSDictionary *colorMap = @{
                               [@[SET_GAME_CARD_COLOR_GREEN    ,SET_GAME_CARD_SHADING_OPEN] componentsJoinedByString:@""]:[UIColor whiteColor],
                               [@[SET_GAME_CARD_COLOR_RED      ,SET_GAME_CARD_SHADING_OPEN] componentsJoinedByString:@""]:[UIColor whiteColor],
                               [@[SET_GAME_CARD_COLOR_PURPLE   ,SET_GAME_CARD_SHADING_OPEN] componentsJoinedByString:@""]:[UIColor whiteColor],
                               
                               [@[SET_GAME_CARD_COLOR_GREEN    ,SET_GAME_CARD_SHADING_SOLID] componentsJoinedByString:@""]:[[self class]greenColor],
                               [@[SET_GAME_CARD_COLOR_RED      ,SET_GAME_CARD_SHADING_SOLID] componentsJoinedByString:@""]:[[self class]redColor],
                               [@[SET_GAME_CARD_COLOR_PURPLE   ,SET_GAME_CARD_SHADING_SOLID] componentsJoinedByString:@""]:[[self class]purpleColor],
                               
                               [@[SET_GAME_CARD_COLOR_GREEN    ,SET_GAME_CARD_SHADING_STRIPED] componentsJoinedByString:@""]:[[self class]lightGreenColor],
                               [@[SET_GAME_CARD_COLOR_RED      ,SET_GAME_CARD_SHADING_STRIPED] componentsJoinedByString:@""]:[[self class]lightRedColor],
                               [@[SET_GAME_CARD_COLOR_PURPLE   ,SET_GAME_CARD_SHADING_STRIPED] componentsJoinedByString:@""]:[[self class]lightPurpleColor],
                               
                               };
    return [colorMap valueForKey:[@[card.color,card.shading] componentsJoinedByString:@""]];
}

+(UIColor*)strokeColorForCard:(SetGameCard*)card{
    NSDictionary *colorMap = @{SET_GAME_CARD_COLOR_GREEN:[[self class] greenColor],
                               SET_GAME_CARD_COLOR_RED:[[self class] redColor],
                               SET_GAME_CARD_COLOR_PURPLE:[[self class]purpleColor]};
    return [colorMap valueForKey:card.color];
}

+(NSString*) displayStringForSymbol:(NSString*)symbol{
    NSDictionary *symbolMap = @{SET_GAME_CARD_SYMBOL_DIAMOND:@"▲",
                                SET_GAME_CARD_SYMBOL_OVAL:@"●",SET_GAME_CARD_SYMBOL_SQUIGGLE:@"■"};
    return [symbolMap valueForKey:symbol] ? [symbolMap valueForKey:symbol] : symbol;
}

+(UIColor*) greenColor{       return [UIColor colorWithRed:0 green:1 blue:0 alpha:1]; }
+(UIColor*) redColor{         return [UIColor colorWithRed:1 green:0 blue:0 alpha:1]; }
+(UIColor*) purpleColor{      return [UIColor colorWithRed:0 green:0 blue:1 alpha:1]; }
+(UIColor*) lightGreenColor{  return [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3]; }
+(UIColor*) lightRedColor{    return [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3]; }
+(UIColor*) lightPurpleColor{ return [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3]; }



@end
