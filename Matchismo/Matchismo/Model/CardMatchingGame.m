//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Radu Croitoru on 26/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSUInteger)gameMode {
    if (!_gameMode) {
        _gameMode = 2;
    }
    
    return _gameMode;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];

            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE_CARD = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // Make an array with chosen cards
            NSMutableArray *otherCards = [NSMutableArray array];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            
            // match based on gameMode sent by UI
            if ([otherCards count] == self.gameMode - 1) {
                int matchScore = [card match:otherCards];
            
                if (matchScore) {
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    
                    // Save here when match occur in multiple game
                    NSString *otherCardsLiveResults = @"";
                    
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                        otherCardsLiveResults = [otherCardsLiveResults stringByAppendingFormat:@"%@", otherCard.contents];
                    }
                    
                    self.gameLiveResults = [NSString stringWithFormat:@"Matched %@%@ for %d points", card.contents, otherCardsLiveResults, matchScore * MATCH_BONUS ];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    
                    // Save here when mismatch occur in multiple game
                    NSString *otherCardsLiveResults = @"";
                    
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                        otherCardsLiveResults = [otherCardsLiveResults stringByAppendingFormat:@"%@", otherCard.contents];
                    }
                    
                    self.gameLiveResults = [NSString stringWithFormat:@"%@%@ don't match! %d point penalty", card.contents, otherCardsLiveResults, MISMATCH_PENALTY];
                }
            }
            
            self.score -= COST_TO_CHOOSE_CARD;
            card.chosen = YES;
        }
    }
}

@end
