//
//  TabBarView.h
//  Library&Test
//
//  Created by  on 12-11-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomTabBarViewDelegate <NSObject>

- (void)switchTab: (NSInteger)index;

@end

@interface TabBarView : UIView
{
    id<CustomTabBarViewDelegate> delegate;
}

@property id delegate;

- (id)initWithFrame:(CGRect)frame tabBarButtons: (NSArray*)buttons;

@end
