//
//  playingCard.m
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "playingCard.h"

@implementation PlayingCard

-(NSString *)contents
{
    return [[playingCard rankStrings] [self.rank] stringByAppendingSrring:self.suit];
}

-(NSString *) suit
{
    return _suit ? _suit : @"?";
}

+(NSString *) rankStrings
{
    static NSArray *rankStrings = nil;
}
@end

