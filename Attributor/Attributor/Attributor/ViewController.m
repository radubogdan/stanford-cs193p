//
//  ViewController.m
//  Attributor
//
//  Created by Radu Croitoru on 28/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import "ViewController.h"
#import "TextStatsViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;
@property (weak, nonatomic) IBOutlet UIButton *unoutlineButton;
@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"analyzeText"]) {
        if ([segue.destinationViewController isKindOfClass:[TextStatsViewController class]]) {
            TextStatsViewController *tsvc = (TextStatsViewController *)segue.destinationViewController;
            tsvc.textToAnalyze = self.body.textStorage;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName: @-3,
                           NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, [title length])];
     
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(preferredFontChanged:) name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIContentSizeCategoryDidChangeNotification object:nil];
}

- (void)preferredFontChanged:(NSNotification *)notification {
    [self usePreferredFont];
}

- (void)usePreferredFont {
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.headline.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender {
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}

- (IBAction)outlineBodySelection:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3,
                                           NSStrokeColorAttributeName: [UIColor blackColor]}
                                   range:self.body.selectedRange];
}

- (IBAction)unoutlineBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

@end
