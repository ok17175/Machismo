//
//  PlayingCardGameViewController.m
//  Machismo
//
//  Created by 李深龙 on 13-8-27.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h" 
#import "PlayingCard.h"
#import "PlayingCardCollectionViewCell.h"



@implementation PlayingCardGameViewController


- (NSUInteger)startingCardCount;
{
    return 30;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
    
}

- (void)updateCell:(UICollectionViewCell *)cell using:(Card *)card animate:(BOOL)animate
{
    if ([cell isKindOfClass:[PlayingCardCollectionViewCell class]]){
        cardView *cardView = ((PlayingCardCollectionViewCell *)cell).cardView;
        if ([card isKindOfClass:[PlayingCard class]]) {
            
            PlayingCard *play = (PlayingCard *)card;
            cardView.rank = play.rank;
            cardView.suit = play.suit;
            cardView.faceUp = play.isFaceUp;
            cardView.type = @"playingCard";
            cardView.alpha = play.isUnplayable ? 0.3 : 1.0;
            if (animate){
                [UIView transitionWithView:cardView
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionFlipFromLeft
                                animations:^{
                    cardView.faceUp = play.isFaceUp;}
                                completion:NULL];
            }
        }
    }
}

@end
