//
//  CardGameViewController.m
//  Machismo
//
//  Created by 李深龙 on 13-6-20.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "Card.h"


@interface CardGameViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *infoLable;
@property (nonatomic) int flipcount;
@property (nonatomic) int currentIndex;
@property (nonatomic) int lastIndex;
@property (strong,nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.startingCardCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCard" forIndexPath:indexPath];
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell using:card animate:NO];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell using:(Card *)Card animate:(BOOL)animate
{
    //abstract
}

- (CardMatchingGame *)game
{
    if(!_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.startingCardCount
                                                        usingDeck:[self createDeck]];
    return _game;
}


                       
- (Deck *)createDeck
{
    return nil;
}

- (IBAction)deal
{
    self.game = nil;
    [self updateUI:0];
    self.infoLable.text  = [NSString stringWithFormat:@""];
    [self setFlipcount:0];
}


-(void)updateUI:(NSUInteger)index
{
    for (UICollectionViewCell *cell in [self.cardCollectionView visibleCells]) {
        NSIndexPath *indexPath = [self.cardCollectionView indexPathForCell:cell];
        Card *card = [self.game cardAtIndex:indexPath.item];
        [self updateCell:cell using:card animate:(indexPath.item == index) ? YES : NO];
        self.scoreLable.text = [NSString stringWithFormat:@"Score:%d",self.game.score];
    }
}

- (IBAction)flipCard:(UIGestureRecognizer *)gesture
{
    CGPoint tapLocation = [gesture locationInView:self.cardCollectionView];
    NSIndexPath *indexPath = [self.cardCollectionView indexPathForItemAtPoint:tapLocation];
    if (indexPath){
        [self.game flipCardAtIndex:indexPath.item];
        self.flipcount++;
        self.lastIndex = self.currentIndex ;
        [self updateUI:indexPath.item];
    }
}

- (void) setFlipcount:(int)flipcount {

    _flipcount = flipcount;
    self.flipsLable.text = [NSString stringWithFormat:@"Flips:%d",self.flipcount];
}


@end
