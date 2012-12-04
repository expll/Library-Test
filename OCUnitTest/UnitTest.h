//
//  UnitTest.h
//  OCUnitTest
//
//  Created by  on 12-11-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UnitTest : NSObject
<UITableViewDelegate, UITableViewDataSource>

+ (id) sharedUnitTest;

-(void) starttest:(id)sender;

@end
