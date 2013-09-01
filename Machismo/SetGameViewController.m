//
//  SetGameViewController.m
//  Machismo
//
//  Created by 李深龙 on 13-8-3.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "setCard.h"
#import "CardMatchingGame.h"
#import "cardView.h"
#import "setCardCollectionViewCell.h"

@interface SetGameViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong,nonatomic) NSMutableArray *cardSelected;
@property (strong,nonatomic) setCard *setcard;
@property (nonatomic) int scores;
//@property (strong,nonatomic) NSArray *selectCards;
@property (weak, nonatomic) IBOutlet cardView *setCardView;
@end

@implementation SetGameViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(id) init
{
    self = [super init];
    
    return self;
}

- (void)setSetCardView:(cardView *)setCardView
{
    _setCardView = setCardView;
    self.setCardView.type = @"SetCard";
    self.setCardView.color = @"red";
    self.setCardView.shading = @"open";
    self.setCardView.symbol = @"▲";
    self.setCardView.number = 3;
    self.setCardView.faceUp = YES;
}

//@synthesize game = _game;

- (CardMatchingGame *)game
{
    if (!_game){
        _game = [[CardMatchingGame alloc] initWithCardCount:24
                                                  usingDeck:[[SetCardDeck alloc] init]];
    }
    return _game;
}
/*
- (IBAction)deal
{
    if(_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.setButtons.count
                                                       usingDeck:[[SetCardDeck alloc] init]];
    [self updateUI];
    //self.infoLable.text  = [NSString stringWithFormat:@""];
    [self setFlipcount:0];
}
*/


 

- (NSAttributedString *) updateAttributeString:(NSAttributedString *) string withAttributeOfCard:(setCard *) setcard{
    NSMutableAttributedString *mutableString = [string mutableCopy];
    NSRange range = [[mutableString string] rangeOfString:setcard.contents];
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    NSString *symbol = @"";
    
    if ([setcard.color isEqualToString:@"red"])
        [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    if ([setcard.color isEqualToString:@"green"])
        [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
    if ([setcard.color isEqualToString:@"purple"])
        [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
    
    if ([setcard.symbol isEqualToString:@"oval"]) symbol = @"●";
    if ([setcard.symbol isEqualToString:@"diamond"]) symbol = @"▲";
    if ([setcard.symbol isEqualToString:@"squiggle"]) symbol = @"■";
    
    if ([setcard.shading isEqualToString:@"solid"])
        [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
    if ([setcard.shading isEqualToString:@"open"])
        [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
    if ([setcard.shading isEqualToString:@"striped"])
        [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName:@-5,NSStrokeColorAttributeName:attributes[NSForegroundColorAttributeName],NSForegroundColorAttributeName:[attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]}];
    
    symbol = [symbol stringByPaddingToLength:setcard.number withString:symbol startingAtIndex:0];
    
    [mutableString replaceCharactersInRange:range withAttributedString:[[NSAttributedString alloc] initWithString:symbol attributes:attributes ]];
    
    return mutableString;
              
    
}

- (NSUInteger)startingCardCount;
{
    return 20;
}

-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
    
}

- (void)updateCell:(UICollectionViewCell *)cell using:(Card *)card animate:(BOOL)animate
{
    if ([cell isKindOfClass:[setCardCollectionViewCell class]]){
        cardView *cardView = ((setCardCollectionViewCell *)cell).cardView;
        if ([card isKindOfClass:[setCard class]]) {
            
            setCard *play = (setCard *)card;
            cardView.color = play.color;
            cardView.symbol = play.symbol;
            cardView.shading = play.shading;
            cardView.faceUp = play.isFaceUp;
            cardView.number = play.number;
            cardView.type = @"SetCard";
            cardView.alpha = play.isFaceUp ? 0.3 : 1.0;
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
