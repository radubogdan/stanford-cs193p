//
//  Card.h
//  Matchismo
//
//  Created by Radu Croitoru on 24/12/14.
//  Copyright (c) 2014 Radu Croitoru. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int) match:(NSArray *)otherCards;

@end
