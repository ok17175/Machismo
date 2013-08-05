//
//  CardMatchingGame.m
//  Machismo
//
//  Created by 李深龙 on 13-6-25.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "CardMatchingGame.h"
#import "Card.h"
#import "PlayingCard.h"

@interface CardMatchingGame() 
@property(nonatomic,strong)NSMutableArray *cards;
@property(nonatomic,readwrite) int score;
@property (nonatomic,readwrite) NSString *matchType;
@property (nonatomic,readwrite) BOOL matched;
@property (nonatomic,readwrite)int matchScore;
@property (nonatomic)int faceDownCardCount;
@end

@implementation CardMatchingGame


-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(id)initWithCardCount:(NSUInteger) cardCount
             usingDeck:(Deck *) deck
{
    self = [super init];
    if(self){
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            self.cards[i] = card;
        }
    }
    
    return self;
    
}
-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    self.matched  = NO;
    self.isGameOver = NO;
    self.faceDownCardCount = 0;
    if(!card.isUnplayable){
        if(!card.isFaceUp){
        
            for (Card *othercard in self.cards) {
                if(!othercard.isFaceUp) self.faceDownCardCount += 1;
                
                if(othercard.isFaceUp && !othercard.isUnplayable){
                    self.matchScore = [card match:@[othercard]];
                    if(self.matchScore){
                        card.Unplayable = YES;
                        othercard.unplayable = YES;
                        self.score += self.matchScore *5;
                        self.matched = YES;
                        self.matchType = self.matchScore == 1 ? @"suit" : @"rank";
                    }else{
                        othercard.faceUp = NO;
                        self.score -= 1;
                        self.matched = NO;
                    }
                    
                    break;
                }
                
                /*if(!self.matched && !othercard.isFaceUp && !othercard.isUnplayable){
                    self.matchScore = [card match:@[othercard]];
                    if(self.matchScore) self.isGameOver = NO;
                    else self.isGameOver = YES;
                }*/
            
            }
            self.score -= 1;
        }
        card.FaceUp = !card.isFaceUp;
        
        //check if no more match
        /*if (self.faceDownCardCount < 5){
        for (Card *carda in self.cards){
            for (Card *cardb in self.cards){
                if(![carda.contents isEqualToString:cardb.contents]){
                    if(!carda.isFaceUp && !carda.isUnplayable && !cardb.isFaceUp && !cardb.isUnplayable){
                        self.matchScore = [carda match:@[cardb]];
                        if (self.matchScore) self.isGameOver = NO;
                        else self.isGameOver = YES;
                                           
                    }
                }
            }
        }
    }*/
}
}



-(Card *)cardAtIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index]:nil;
}

@end
