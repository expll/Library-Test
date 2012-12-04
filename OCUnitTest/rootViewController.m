//
//  rootViewControllerViewController.m
//  OCUnitTest
//
//  Created by  on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "rootViewController.h"
#import "UnitTest.h"
#import "TestData.h"

@interface rootViewController ()

@end

@implementation rootViewController
@synthesize imageView, button, button2;

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
#if UNITTEST
    UnitTest *unitTest = [UnitTest sharedUnitTest];
    [unitTest starttest:self];
#endif
    [self.button setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateSelected];
    [self.button setImage:[UIImage imageNamed:@"4.png"] forState:UIControlStateNormal];
    [self.button setSelected:YES];
    //[self.button setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateHighlighted];
    //[self.button setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateDisabled];
    //[self.button setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateApplication];
    //[self.button setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateReserved];
//    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:5];
//    [self.button setShowsTouchWhenHighlighted:YES]; //不发光
//    [self.button setAdjustsImageWhenDisabled:NO];
//    [self.button setAdjustsImageWhenHighlighted:NO];
    [self.button addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchDown];
   
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark
- (void)changeButtonStatus
{
    //[self.button setSelected:YES];
}

- (void)log
{
    NSLog(@"touch down....");
    NSLog(@"%d", [self.button state]);
    //[self.button setSelected:YES];
    [self.button setUserInteractionEnabled:NO];
    //[self.button setEnabled:NO];
}


@end
