//
//  TabBarViewController.m
//  Library&Test
//
//  Created by  on 12-11-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "TabBarView.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController


- (id)initWithControllers: (NSArray *)controllers tabBarButtons: (NSArray *)buttons
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setViewControllers:controllers tabBarButtons: buttons];
        
    }
    return self;
}

-(void) setViewControllers: (NSArray *)controllers tabBarButtons:(NSArray*)buttons
{
    NSAssert([controllers count] > 0, @"The count of controllers is 0.");
    NSAssert([controllers count] > 0, @"The count of buttons is 0.");
    NSAssert([controllers count] == [buttons count], @"The count of controllers is not equal to the count of buttons.");

    [super setViewControllers:controllers];
    [[buttons objectAtIndex:0] setSelected:YES];
    
    // assume all button size is same
    float height = [[buttons objectAtIndex:0] frame].size.height;
    CGRect rect = CGRectMake(0, self.view.bounds.size.height - height, self.view.bounds.size.width, height);
    
    TabBarView *tabBarView = [[TabBarView alloc] initWithFrame:rect tabBarButtons:buttons];
    tabBarView.delegate = self;
    [self.view addSubview:tabBarView];
    
    self.tabBar.hidden = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark  TabBarView delegate

- (void)switchTab: (NSInteger)index
{
    [self setSelectedIndex:index];
}




@end
