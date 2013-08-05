//
//  PlayingCard.m
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)rankStrings
{
    static  NSArray *rankStrings = nil;
    rankStrings = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return rankStrings;
}

@synthesize suit = _suit;

+ (NSArray *)validSuites
{
    static NSArray *validSuites = nil;
    validSuites = @[@"♠",@"♥",@"♣",@"♦"];
    return validSuites;
}

+ (NSArray *)validSymbol
{
    static NSArray *validSymbol = nil;
    validSymbol = @[@"♢",@"▢",@"☉",@"⬥",@"◉",@"■"];
    return validSymbol;
}

+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuites] containsObject:suit])
        _suit = suit;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

-(NSUInteger)rank
{
    return _rank ? _rank :0;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if(otherCards.count == 1){
        PlayingCard *card = otherCards.lastObject;
        
        if ([card.suit isEqualToString:self.suit]) {
            score = 2;
        }else if(card.rank == self.rank){
            score = 1;
        }
    }
    return score;
}
@end
