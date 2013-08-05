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

@interface SetGameViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
//@property (strong,nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetGameViewController

/*

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

//@synthesize game = _game;

- (CardMatchingGame *)game
{
    _game = [[CardMatchingGame alloc] initWithCardCount:24
                                              usingDeck:[[SetCardDeck alloc] init]];
    return _game;
}

- (IBAction)deal
{
    if(_game)_game = [[CardMatchingGame alloc] initWithCardCount:self.setButtons.count
                                                       usingDeck:[[SetCardDeck alloc] init]];
    [self updateUI];
    //self.infoLable.text  = [NSString stringWithFormat:@""];
    [self setFlipcount:0];
}



- (void)setsetButtons:(NSArray *)setButtons{
    
    _setButtons = setButtons;
    [self updateUI];
}
 

- (NSAttributedString *) updateAttributeString:(NSAttributedString *) string withAttributeOfCard:(setCard *) setcard{
    NSMutableAttributedString * mutableString = [string mutableCopy];
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
    if ([setcard.symbol isEqualToString:@"oval"]) symbol = @"▲";
    if ([setcard.symbol isEqualToString:@"oval"]) symbol = @"■";
    
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

-(void)updateUI
{
    
    for (UIButton *setButton in self.setButtons) {
        Card *card = [self.game cardAtIndex:[self.setButtons indexOfObject:setButton]];
        
        //if ([card isKindOfClass: [setCard class]])
        
        setCard *setcard = (setCard *)card;
        
        
        NSAttributedString *title = [[NSAttributedString alloc] initWithString:setcard.contents];
        
        title = [self updateAttributeString:title withAttributeOfCard:setcard];
        [setButton setAttributedTitle:title forState:UIControlStateNormal];
        
        setButton.selected = setcard.isFaceUp;
        
        
        setButton.enabled = !setcard.isUnplayable;
        setButton.alpha = setcard.unplayable ? 0 : 1.0;
        
    }
    //[super updateUI];
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
*/

@end
