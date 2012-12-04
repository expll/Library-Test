//
//  OCUnitTestTests.m
//  OCUnitTestTests
//
//  Created by  on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OCUnitTestTests.h"
#import "Cache.h"
#import "URLCache.h"
#import "NetworkApi.h"
#import "Reachability.h"

@implementation OCUnitTestTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    NSLog(@"========== test starting ==========");
    
    
    NetworkApi *netWorkApi = [NetworkApi sharedNetworkApi];
    //Cache *cache = [Cache sharedCache];
    
    [netWorkApi fetchImageWith:@"http://www-deadline-com.vimg.net/wp-content/uploads/2011/03/pbs_logo_20110328235546.jpg" success:^(UIImage* image) {
        NSLog(@"SUCCESS!");
    } failure:^(NSError *error) {
        NSLog(@"ERROR: %@", error.description);
    } requestType:request_image];
    
    
    
    
    NSLog(@"==========   test ended  ==========");
}

@end
