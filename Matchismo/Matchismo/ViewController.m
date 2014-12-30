//
//  ViewController.m
//  Matchismo
//
//  Created by Radu Croitoru on 24/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) NSMutableArray *gameHistory;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameMode;
@property (weak, nonatomic) IBOutlet UILabel *liveScoreLabel;
@end

@implementation ViewController

// abstract method
- (Deck *)createDeck {
    return nil;
}

- (CardMatchingGame *)game {    
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        [self gameModeSegControl:self.gameMode];
    }
    
    return _game;
}

- (NSMutableArray *)gameHistory {
    if (!_gameHistory) {
        _gameHistory = [[NSMutableArray alloc] init];
    }
    
    return _gameHistory;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self.gameMode setEnabled:NO];
    [self UpdateUI];
}

- (IBAction)resetGameButton:(id)sender {
    self.game = nil;
    self.gameHistory = nil;
    [self.gameMode setEnabled:YES];
    [self UpdateUI];
}

- (IBAction)gameModeSegControl:(UISegmentedControl *)sender {
    self.game.gameMode = sender.selectedSegmentIndex + 2;
}

- (void)UpdateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        cardButton.enabled = !card.isMatched;
    }
    
    self.liveScoreLabel.text = [NSString stringWithFormat:@"%@", [self factorGameLiveResults:self.game.gameLiveResults]];
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSString *)factorGameLiveResults:(NSString *)gameLiveResults {
    return gameLiveResults ? gameLiveResults : @"";
}

@end
