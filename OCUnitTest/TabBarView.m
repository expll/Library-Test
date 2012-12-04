//
//  TabBarView.m
//  Library&Test
//
//  Created by  on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabBarView.h"

@interface TabBarView()
{
    NSArray *_buttons;
}

@end

@implementation TabBarView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame tabBarButtons: (NSArray*)buttons
{
    NSAssert([buttons count] > 0, @"Count of buttons is 0");
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // layout buttons one after another
        float x = 0;
        float width =  [[buttons objectAtIndex:0] frame].size.width;
        float height =  [[buttons objectAtIndex:0] frame].size.height;
        for (int i = 0; i < [buttons count]; i++) 
        {
            x = width * i;
            
            UIButton *btn = [buttons objectAtIndex:i];
            
            [btn setFrame:CGRectMake(x, 0, width, height)];
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchDown];
            [self addSubview:btn];
            
        }
        
        _buttons = buttons;
        
        // set default
        [[_buttons objectAtIndex:0] setSelected:NO];
    }
    
    return  self;
}

- (void)tabBarButtonClicked: (UIButton*)sender
{
    NSInteger index = [_buttons indexOfObject:sender];

    if (![delegate respondsToSelector:@selector(switchTab:)]) 
    {
        return;
    }
    
    [delegate switchTab:index];
    
    for (int i = 0; i < [_buttons count]; i++) 
    {
        UIButton *btn = (UIButton *)[_buttons objectAtIndex:i];
        if (i ==  index) 
        {
            [btn setSelected:NO];
            btn.userInteractionEnabled = NO;
            
            
            
        } else {
            [btn setSelected:YES];
            btn.userInteractionEnabled = YES;
        }
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
