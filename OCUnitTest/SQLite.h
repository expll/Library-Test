//
//  SQLite.h
//  Library&Test
//
//  Created by  on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SQLite : NSObject

@property(readonly) NSManagedObjectContext *context;  
@property(readonly) NSManagedObjectModel *model;

+ (id) sharedSQLite;







@end
