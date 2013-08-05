//
//  setCard.m
//  Machismo
//
//  Created by 李深龙 on 13-8-3.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "setCard.h"

@implementation setCard

@synthesize color = _color,symbol = _symbol,shading = _shading;

-(id) init
{
    self = [super init];
    return self;
}

- (NSString *) color
{
    return _color ? _color :@"?";
}

- (void) setColor:(NSString *) color
{
    if ([[setCard validcolors] containsObject:color]) _color = color;
}
- (NSString *) symbol
{
    return _symbol ? _symbol :@"?";
}

- (void) setSymbol:(NSString *) symbol
{
    if ([[setCard validsymbols] containsObject:symbol]) _symbol = symbol;
}
- (NSString *) shading
{
    return _shading ? _shading :@"?";
}

- (void) setShading:(NSString *)shading
{
    if ([[setCard validshadings] containsObject:shading]) _shading = shading;
}

- (NSString *) contents
{
    return [NSString stringWithFormat:@"%@:%@:%@:%d",
            self.color,self.symbol,self.shading,self.number];
}

+(NSArray *) validcolors
{
    return @[@"red",@"purple",@"green"];
}

+(NSArray *) validshadings
{
    return @[@"opne",@"solid",@"striped"];
}

+(NSArray *) validsymbols
{
    return @[@"diamond",@"oval",@"squiggle"];
}

+(NSUInteger)maxNumber
{
    return 3;
}
-(int)match:(NSArray *)otherCards
{
    int score = 0;
    if ([otherCards count] == 2){
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        
        [colors addObject:self.color];
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        for (id otherCard in otherCards) {
            setCard *otherSetCard = (setCard *) otherCards;
            if (![colors containsObject:otherSetCard.color])
              [colors addObject:otherSetCard.color];
            if (![symbols containsObject:otherSetCard.symbol])
                [symbols addObject:otherSetCard.symbol];
            if (![shadings containsObject:otherSetCard.shading])
                [shadings addObject:otherSetCard.shading];
            if (![numbers containsObject:@(otherSetCard.number)])
                [numbers addObject:@(otherSetCard.number)];
        }
        
        if (([colors count] == 1      || [colors count ] == 3)
            && ([symbols count] == 1  || [symbols count] == 3)
            && ([shadings count] == 1|| [shadings count] == 3)
            && ([numbers count] == 1  || [numbers count] == 3)) {
            score = 5;
        }
    
    }
    return score;
}

@end
