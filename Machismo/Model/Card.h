//
//  Card.h
//  Machismo
//
//  Created by 李深龙 on 13-6-22.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(strong,nonatomic) NSString *contents;
@property(nonatomic,getter = isFaceUp)BOOL faceUp;
@property(nonatomic,getter = isUnplayable)BOOL unplayable;

-(int)match:(NSArray *)otherCards;
@end
