//
//  UnitTest.m
//  OCUnitTest
//
//  Created by  on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UnitTest.h"
#import "TestData.h"

#import "Cache.h"
#import "URLCache.h"
#import "Network.h"
#import "SQLite.h"
#import "Reachability.h"

#import "rootViewController.h"
#import "WLAppDelegate.h"
#import "TabBarView.h"
#import "TabBarViewController.h"
#import "NavigationController.h"

#import "Single.h"
#import "Car.h"
#import "BZ.h"


@interface UINavigationBar (UINavigationBarCategory)

- (void)setBackground;

@end

@implementation UINavigationBar (UINavigationBarCategory)

- (void)setBackground
{
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    background.backgroundColor = [[UIColor alloc] initWithRed:203.0/255 green:203.0/255 blue:203.0/255 alpha:1];
    [self sendSubviewToBack:background];
}

@end



@interface UnitTest () {
    rootViewController *rootvc;
    id _sender;
}

@end

@implementation UnitTest

+ (id) sharedUnitTest
{
    static UnitTest *_sharedObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[UnitTest alloc] init];
    });
    
    return _sharedObject;
}

-(void) starttest:(id)sender
{
    NSLog(@"========== test starting ==========");
    _sender = sender;
    [self BUTTON];
    
    
 
    NSLog(@"==========   test ended  ==========");
    

}



# pragma mark test 


/*
 *
 *  Custom TabBar Test Using Button 
 *
 */

- (void)BUTTON
{
    UIViewController *vc1 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *vc2 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *vc3 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    UIViewController *vc4 = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    label.text = @"11111111111";
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [view1 addSubview:label];
    vc1.view = view1;
    NavigationController *navc = [[NavigationController alloc] initWithRootViewController:vc1];
    vc1.navigationItem.title = @"haha";
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [[UIColor alloc] initWithRed:203.0/255 green:203.0/255 blue:203.0/255 alpha:1];
    //vc1.navigationItem.titleView = titleView;
    if ([navc.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [navc.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background.png"] forBarMetrics:nil];
    }
    

    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    label2.text = @"22222222222";
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [view2 addSubview:label2];
    vc2.view = view2;
    
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    label3.text = @"333333333333";
    [view3 addSubview:label3];
    vc3.view = view3;
    
    UIView *view4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 120, 50)];
    label4.text = @"444444444444";
    [view4 addSubview:label4];
    vc4.view = view4;
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    float buttonWidth = [_sender window].bounds.size.width/4;
    btn1.frame  = CGRectMake(0, 0, buttonWidth, 55);
    btn2.frame  = CGRectMake(buttonWidth, 0, buttonWidth, 55);
    btn3.frame  = CGRectMake(buttonWidth * 2, 0, buttonWidth, 55);
    btn4.frame  = CGRectMake(buttonWidth * 3, 0, buttonWidth, 55);
    
    [btn1 setImage:[UIImage imageNamed:@"search_unselected.png"] forState:UIControlStateSelected];
    [btn1 setImage:[UIImage imageNamed:@"search_selected.png"] forState:UIControlStateNormal];
    [btn1 setShowsTouchWhenHighlighted:YES];
    [btn1 setSelected:YES];
    [btn2 setImage:[UIImage imageNamed:@"bookmark_unselected.png"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"bookmark_selected.png"] forState:UIControlStateNormal];
    [btn2 setShowsTouchWhenHighlighted:YES];
    [btn2 setSelected:YES];
    [btn3 setImage:[UIImage imageNamed:@"store_unselected.png"] forState:UIControlStateSelected];
    [btn3 setImage:[UIImage imageNamed:@"store_selected.png"] forState:UIControlStateNormal];
    [btn3 setShowsTouchWhenHighlighted:YES];
    [btn3 setSelected:YES];
    [btn4 setImage:[UIImage imageNamed:@"more_unselected.png"] forState:UIControlStateSelected];
    [btn4 setImage:[UIImage imageNamed:@"more_selected.png"] forState:UIControlStateNormal];
    [btn4 setShowsTouchWhenHighlighted:YES];
    [btn4 setSelected:YES];
    
    NSArray *buttons = [NSArray arrayWithObjects:btn1, btn2, btn3, btn4, nil];
    NSArray *controllers = [NSArray arrayWithObjects:navc, vc2, vc3, vc4, nil];
    
    [(WLAppDelegate *)_sender window].rootViewController = [[TabBarViewController alloc] initWithControllers:controllers tabBarButtons:buttons];
    
}

- (void)BG
{
    [NSURLCache setSharedURLCache:[URLCache sharedCache]];
    
    //Cache *cache = [Cache sharedCache];
    
    //
    //     [TEST] fetchImageWith
    //
    /*
     [netWorkApi fetchImageWith:@"http://www-deadline-com.vimg.net/wp-content/uploads/2011/03/pbs_logo_20110328235546.jpg" success:^(UIImage* image) {
     NSLog(@"SUCCESS!");
     dispatch_async(dispatch_get_main_queue(), ^{
     if (sender) {
     [[(rootViewController *)sender imageView] setImage: image];
     }
     });
     } failure:^(NSError *error) {
     NSLog(@"ERROR: %@", error.description);
     } requestType:request_image];
     */
    
    //
    //      [TEST] 
    //
    /*
     [netWorkApi fetchImageWith:@"http://www-deadline-com.vimg.net/wp-content/uploads/2011/03/pbs_logo_20110328235546.jpg" success:^(NSData* data) {
     NSLog(@"SUCCESS!");
     dispatch_async(dispatch_get_main_queue(), ^{
     if (sender) {
     [[(rootViewController *)sender imageView] setImage: [UIImage imageWithData:data]];
     }
     });
     } failure:^(NSError *error) {
     NSLog(@"ERROR: %@", error.description);
     }];
     */
    
    //
    //      [TEST]
    //
    /*
     rootvc = (rootViewController *)sender;
     UITableView *tableView = [[UITableView alloc] initWithFrame:rootvc.view.bounds style:UITableViewStylePlain];
     tableView.delegate = self;
     tableView.dataSource = self;
     
     [rootvc.view addSubview:tableView];
     */
    
    //
    //      [TEST] : SQLite
    //
    
    SQLite *sqlite = [SQLite sharedSQLite];
    
    for (int i = 0; i < 5; ++i) 
    {
        BZ *bz = [BZ insertInManagedObjectContext:sqlite.context];
        bz.kind = [NSString stringWithFormat:@"BZ1234-%d_2", i];
        [sqlite.context save:nil];
    }
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"kind LIKE %@", @"*"];
    //    NSArray *array = [sqlite objectWithEntity:@"BZ" predicate:predicate];
    //    for (int i = 0; i < [array count]; ++i) {
    //        NSLog(@"%@", [[array objectAtIndex:i] kind]);
    //    }
    
    
    //
    // ============     2 methods to get managed object:     ======
    //
    //Child *c = [[Child alloc] initWithEntity:[[sqlite.model entitiesByName] objectForKey:@"Child"] insertIntoManagedObjectContext:sqlite.context];
    //Child *c = [NSEntityDescription insertNewObjectForEntityForName:@"Child" inManagedObjectContext:sqlite.context];
    
    

}


#pragma mark == tableview delegate ==

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[TestData sharedTestData] imageUrls] count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"sole";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *resource = [[[TestData sharedTestData] imageUrls] objectAtIndex:indexPath.row];
    [[Network sharedNetwork] fetchImageWith:resource success:^(UIImage* image) {
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
        });
        
    } failure:^(NSError *error) {
        ;
    } ];

    
    return cell;
    
}























































@end
