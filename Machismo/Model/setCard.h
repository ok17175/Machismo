//
//  setCard.h
//  Machismo
//
//  Created by 李深龙 on 13-8-3.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface setCard : Card
@property(strong,nonatomic) NSString *color;
@property(strong,nonatomic) NSString *symbol;
@property(strong,nonatomic) NSString *shading;
@property(nonatomic) NSUInteger number;

+(NSArray *) validcolors;
+(NSArray *) validsymbols;
+(NSArray *) validshadings;
+(NSUInteger)maxNumber;



@end
