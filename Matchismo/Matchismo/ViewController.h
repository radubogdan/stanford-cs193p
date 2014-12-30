//
//  ViewController.h
//  Matchismo
//
//  Created by Radu Croitoru on 24/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//
//  Abstract class. Must implement methods as described below!

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController

// protected, abstract
- (Deck *)createDeck;

@end

