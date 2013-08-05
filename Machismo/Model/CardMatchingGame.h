//
//  CardMatchingGame.h
//  Machismo
//
//  Created by 李深龙 on 13-6-25.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger) cardCount
             usingDeck:(Deck *) deck;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) int score;
@property (nonatomic,readonly) NSString *matchType;
@property (nonatomic,readonly) BOOL matched;
@property (nonatomic,readonly) int matchScore;
@property (nonatomic)BOOL  isGameOver;
@end
