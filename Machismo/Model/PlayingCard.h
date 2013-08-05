//
//  PlayingCard.h
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property(strong,nonatomic) NSString *suit;
@property(nonatomic) NSUInteger rank;

-(int)match:(NSArray *)otherCards;

+ (NSArray *)validSuites;
+ (NSUInteger)maxRank;

@end
