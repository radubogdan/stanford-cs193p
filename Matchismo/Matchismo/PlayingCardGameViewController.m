//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Radu Croitoru on 30/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
