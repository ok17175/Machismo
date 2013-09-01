//
//  cardView.h
//  CardView
//
//  Created by 李深龙 on 13-8-24.
//  Copyright (c) 2013年 李深龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cardView : UIView
@property (nonatomic) NSUInteger rank;
@property (nonatomic,strong) NSString *suit;
@property (nonatomic,strong)NSString *type;
@property(strong,nonatomic) NSString *color;
@property(strong,nonatomic) NSString *symbol;
@property(strong,nonatomic) NSString *shading;
@property(nonatomic) NSUInteger number;
@property (nonatomic)BOOL faceUp;
-(void)pinch:(UIPinchGestureRecognizer *)gesture;
@end
