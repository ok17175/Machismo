//
//  cardView.m
//  CardView
//
//  Created by 李深龙 on 13-8-24.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import "cardView.h"


@interface cardView()
@property (nonatomic) CGFloat scaleFator;
@end

@implementation cardView

@synthesize scaleFator = _scaleFator;

- (CGFloat)scaleFator
{
    if (!_scaleFator) _scaleFator = 0.85;
    return _scaleFator;
}

- (void)setScaleFator:(CGFloat)scaleFator
{
    _scaleFator = scaleFator;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit  = suit;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

- (void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

-(void)setNumber:(NSUInteger)number
{
    _number = number;
    [self setNeedsDisplay];
}

- (NSString *)rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}


- (void)setup
{
    
}

- (void)awakeFromNib
{
    [self setup];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGFloat radius = 12.0;
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    
    [roundedRect addClip];
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    // Draw playingCard
    if ([self.type isEqualToString:@"playingCard"]) {
        
        if (self.faceUp){
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",[self rankAsString],self.suit]];
            if (image){
                CGRect imageRect = CGRectInset(self.bounds, self.bounds.size.width * (1.0 - self.scaleFator),self.bounds.size.height * (1.0 - self.scaleFator));
                
                [image drawInRect:imageRect];
                
            }else{
                [self drawPips];
            }
            
            [self drawConners];
        }else{
            UIImage *image = [UIImage imageNamed:@"cardback.png"];
            [image drawInRect:self.bounds];
        }
    
    }
    
    //Draw setCard
    if ([self.type isEqualToString:@"SetCard"]) {

        NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
        if ([self.color isEqualToString:@"red"])
            [attributes setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        if ([self.color isEqualToString:@"green"])
            [attributes setObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        if ([self.color isEqualToString:@"purple"])
            [attributes setObject:[UIColor purpleColor] forKey:NSForegroundColorAttributeName];
        
        if ([self.shading isEqualToString:@"solid"])
            [attributes setObject:@-5 forKey:NSStrokeWidthAttributeName];
        if ([self.shading isEqualToString:@"open"])
            [attributes setObject:@5 forKey:NSStrokeWidthAttributeName];
        if ([self.shading isEqualToString:@"striped"])
            [attributes addEntriesFromDictionary:@{NSStrokeWidthAttributeName:@-5,NSStrokeColorAttributeName:attributes[NSForegroundColorAttributeName],NSForegroundColorAttributeName:[attributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.1]}];
        
        if ([self.symbol isEqualToString:@"oval"]) self.symbol = @"●";
        if ([self.symbol isEqualToString:@"diamond"]) self.symbol = @"▲";
        if ([self.symbol isEqualToString:@"squiggle"]) self.symbol = @"■";
        
        NSMutableAttributedString *setString = [[NSMutableAttributedString alloc]initWithString:[self.symbol stringByPaddingToLength:self.number withString:self.symbol startingAtIndex:0]];
        
        UIFont *font = [UIFont systemFontOfSize:self.bounds.size.width * 0.3];
        [attributes setObject:font forKey:NSFontAttributeName];
        NSRange range = [[setString string] rangeOfString:[setString string]];
        [setString addAttributes:attributes range:range];
        CGSize setSize = [setString size];
        CGPoint setOrigin = CGPointMake(self.bounds.size.width/2 - setSize.width/2, self.bounds.size.height/2 - setSize.height/2);
        [setString drawAtPoint:setOrigin];
    }
}

- (void)drawPips
{
    if (self.rank == 2 || self.rank == 3 )
        [self drawPipsWithHorizon:0.5 vertical:0.25 upsidedown:YES leftToRight:NO];
    if (self.rank == 4 || self.rank == 5 || self.rank == 6 || self.rank == 7 || self.rank == 8 || self.rank == 9 ||self.rank == 10)
        [self drawPipsWithHorizon:0.3 vertical:0.25 upsidedown:YES leftToRight:YES];
    if (self.rank == 6 || self.rank == 7 || self.rank == 8 )
        [self drawPipsWithHorizon:0.3 vertical:0.5 upsidedown:YES leftToRight:YES];
    if (self.rank == 7 ||self.rank == 8 ||self.rank == 10)
        [self drawPipsWithHorizon:0.5 vertical:0.33 upsidedown:(self.rank != 7) leftToRight:NO];
    if (self.rank == 9 || self.rank == 10 )
        [self drawPipsWithHorizon:0.3 vertical:0.42 upsidedown:YES leftToRight:YES];
    if (self.rank == 1 || self.rank == 3 || self.rank == 5 || self.rank == 9)
        [self drawPipsWithHorizon:0.5 vertical:0.5 upsidedown:NO leftToRight:NO];
}

- (void)drawPipsWithHorizon:(CGFloat)horizon
                   vertical:(CGFloat)vertical
                 upsidedown:(BOOL)upsidedown
                leftToRight:(BOOL)leftToRight
{
    //CGContextRotateCTM(UIGraphicsGetCurrentContext(), M_PI);
    UIFont *pipFont = [UIFont systemFontOfSize:self.bounds.size.width * 0.15];
    NSAttributedString *pipSuit = [[NSAttributedString alloc] initWithString:self.suit
                                                                  attributes:@{NSFontAttributeName:pipFont}];
    CGSize pipSize = [pipSuit size];
    CGPoint pipOrigin = CGPointMake(self.bounds.size.width * horizon - pipSize.width/2, self.bounds.size.height * vertical - pipSize.height/2);
    [pipSuit drawAtPoint:pipOrigin];
    
    CGFloat xTranslation = self.bounds.size.width * (1 - 2 * horizon);
    CGFloat yTranslation = self.bounds.size.height * (1 - 2 * vertical);
    
    if(upsidedown){
        
        pipOrigin.y = pipOrigin.y + yTranslation;
        [pipSuit drawAtPoint:pipOrigin];        
    }
    if(leftToRight){
        
        pipOrigin.x = pipOrigin.x + xTranslation;
        [pipSuit drawAtPoint:pipOrigin];
        if (upsidedown){
            pipOrigin.y =pipOrigin.y - yTranslation;
            [pipSuit drawAtPoint:pipOrigin];
        }
    }
}

- (void)drawConners
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont systemFontOfSize:self.bounds.size.width * 0.15];
    NSAttributedString *text = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",[self rankAsString],self.suit]
                                                               attributes:@{ NSParagraphStyleAttributeName:style,NSFontAttributeName:font}];
    CGRect textBounds;
    textBounds.origin = CGPointMake(2.0, 2.0);
    textBounds.size = [text size];
    [text drawInRect:textBounds];
    
    [self pushAndRotate];
    [text drawInRect:textBounds];
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)pushAndRotate
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(UIGraphicsGetCurrentContext(), M_PI);
    
}


-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded)
        self.scaleFator *= gesture.scale;
    gesture.scale = 1;
}
@end
