//
//  SetCardDeck.m
//  Machismo
//
//  Created by 李深龙 on 13-8-3.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "SetCardDeck.h"
#import "setCard.h"

@implementation SetCardDeck

-(id)init
{
    self = [super init];
    for(NSString *color in [setCard validcolors]){
        for (NSString *symbol in [setCard validsymbols]) {
                for (NSString *shading in [setCard validshadings]) {
                    for (NSUInteger number = 1; number <= 3;number++) {
                        setCard *card = [[setCard alloc] init];
                        card.color = color;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.number = number;
                        [self addCard:card atTop:YES];
                }
            }
        }
    }
    return self;
}

@end
