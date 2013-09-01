//
//  CardGameViewController.h
//  Machismo
//
//  Created by 李深龙 on 13-6-20.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
@interface CardGameViewController : UIViewController
@property(nonatomic)NSUInteger startingCardCount;
-(Deck *)createDeck;
- (void)updateCell:(UICollectionViewCell *)cell using:(Card *)Card animate:(BOOL)animate;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;
@end
