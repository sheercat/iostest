//
//  WIFirstScrollView.m
//  WebInspector
//
//  Created by Tomoo Amano on 2013/01/04.
//  Copyright (c) 2013年 Tomoo Amano. All rights reserved.
//

#import "WIFirstScrollView.h"

@implementation WIFirstScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches){
        if (touch.view == self){
            [self findAndResignFirstResponder];
        }
    }
}

-(void)findAndResignFirstResponder{
    [self endEditing:YES];
}

@end
