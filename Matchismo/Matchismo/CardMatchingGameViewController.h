//
//  CardMatchingGameViewController.h
//  Matchismo
//
//  Created by WeiHsiang-Mac on 2013-02-23.
//  Copyright (c) 2013 WeiHsiang-Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardMatchingGameViewController : UIViewController
@property (nonatomic) GamePlayMode mode;
@property (nonatomic) NSUInteger numberOfCards;
@end
