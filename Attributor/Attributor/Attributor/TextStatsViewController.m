//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Radu Croitoru on 31/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlineCharactersLabel;

@end

@implementation TextStatsViewController

// Just for test :P

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    self.textToAnalyze = [[NSAttributedString alloc] initWithString:@"test" attributes:@{ NSForegroundColorAttributeName: [UIColor greenColor], NSStrokeWidthAttributeName: @-3 }];
//}

- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    _textToAnalyze = textToAnalyze;
    if (self.view.window) [self updateUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void)updateUI {
    int colorful = [[self charactersWithAttribute:NSForegroundColorAttributeName] length];
    int outlined = [[self charactersWithAttribute:NSStrokeWidthAttributeName] length];
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d colorful characters", colorful];
    self.outlineCharactersLabel.text = [NSString stringWithFormat:@"%d outlined characters", outlined];
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName {
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]) {
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        } else {
            index++;
        }
    }
    
    return characters;
    
}

@end
