//
//  PlayingCardDeck.m
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(id)init
{
    self = [super init];
    
    if(self){
    for (NSString *suit in [PlayingCard validSuites])
         {
             for (NSUInteger rank = 1 ; rank <= [PlayingCard maxRank]; rank++) {
                 PlayingCard *card = [[PlayingCard alloc] init];
                 card.suit = suit;
                 card.rank = rank;
                 [self addCard:card atTop:YES];
             }
         }
    }
    return self;
}
@end
