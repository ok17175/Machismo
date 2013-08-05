//
//  Card.m
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}
@end
