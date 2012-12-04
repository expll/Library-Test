//
//  SQLite.m
//  Library&Test
//
//  Created by  on 12-11-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SQLite.h"

static NSString *_DocumentDirectory;

static inline NSString *DocumentDirectory()
{
	if(!_DocumentDirectory)
    {
		NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		_DocumentDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:DOCUMENT] copy];
	}
	
	return _DocumentDirectory;
}

@interface SQLite ()
{
   
}

@end

@implementation SQLite
@synthesize context, model;

+ (id) sharedSQLite
{
    static SQLite *_sharedObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[SQLite alloc] init];
    });
    
    return _sharedObject;
}

- (id) init
{
    self = [super init];
    if (self) {
        
        // read model
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        // set path
        NSString *path = [DocumentDirectory() stringByAppendingPathComponent: @"store_2.data"];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        if (![[NSFileManager defaultManager] fileExistsAtPath:DocumentDirectory()]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:DocumentDirectory()
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:NULL];
        }
        
        
#ifdef DEBUG
        NSLog(@"%@", path);
#endif
        
        NSError *error = nil;
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType 
                              configuration:nil 
                                        URL:storeURL
                                    options:nil
                                      error:&error]) {
            [NSException raise:@"Open failed" format:@"%@", [error userInfo]];
        }

        // create Context object
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // set undo manager
        [context setUndoManager:nil];
    }
    
    return self;
}



#pragma mark ==  ==







@end
