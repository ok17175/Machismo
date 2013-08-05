//
//  CardGameViewController.m
//  Machismo
//
//  Created by 李深龙 on 13-6-20.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (nonatomic) int flipcount;
@property (nonatomic) int currentIndex;
@property (nonatomic) int lastIndex;
@property (strong,nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong,nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                        usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (IBAction)deal
{
    if(_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                       usingDeck:[[PlayingCardDeck alloc] init]];
    [self updateUI];
    self.infoLable.text  = [NSString stringWithFormat:@""];
    [self setFlipcount:0];
}
/*
- (void)setCardButtons:(NSArray *)cardButtons{
   
    _cardButtons = cardButtons;
    [self updateUI];
}
*/
-(void)updateUI
{
    
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        UIImage *cardBackImage = [UIImage imageNamed:@"Browser-AudioOnly.png"];
        //UIImage *cardBackImageTransparent = [UIImage imageNamed:@"transparent-card-back.png"];

     
        [cardButton setTitle:card.contents forState:UIControlStateSelected];        
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        //NSLog(@"button state: %d,card content: %@", cardButton.state,card.contents);
        
        if (card.isFaceUp)
        [cardButton setImage:Nil forState:UIControlStateNormal];
        else
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.unplayable ? 0.3 : 1.0;
        
    }
    self.scoreLable.text = [NSString stringWithFormat:@"Scores:%d",self.game.score];
    if(self.game.matched){
        
        NSString *currentContent = [self.game cardAtIndex:self.currentIndex].contents;
        NSString *lastContent = [self.game cardAtIndex:self.lastIndex].contents;
        NSString *tempContent = [NSString stringWithFormat:@"%@ & %@",currentContent,lastContent];
        
        self.infoLable.text =[NSString stringWithFormat:@"Match %@  for %d points!",tempContent,self.game.matchScore];

    }else if(!self.game.isGameOver){
        self.infoLable.text = [NSString stringWithFormat:@"flip %@",[self.game cardAtIndex:self.currentIndex].contents];
            }
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipcount++;
    self.lastIndex = self.currentIndex ;
    self.currentIndex = [self.cardButtons indexOfObject:sender];
    
    [self updateUI];
}

- (void) setFlipcount:(int)flipcount {

    _flipcount = flipcount;
    self.flipsLable.text = [NSString stringWithFormat:@"Flips:%d",self.flipcount];
}


@end
