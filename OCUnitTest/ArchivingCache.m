//
//  Cache.m
//  Cache
//
//  Created by expl on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ArchivingCache.h"
#import <sqlite3.h>
#import <UIKit/UIKit.h>

static NSString *_CacheDirectory;

static inline NSString *CacheDirectory()
{
	if(!_CacheDirectory)
    {
		NSString *cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
		_CacheDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:@"Cache"] copy];
        
	}
    
	return _CacheDirectory;
}

static inline NSString *cachePathForKey(NSString *key)
{
    NSInteger keyHash = (NSInteger)[key hash];
    int keyNum = keyHash % 100;
    
    NSString *folderPath = [CacheDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Dir%d",keyNum]];
    
    //create the folder if not existed
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
    key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"___"];
    NSString *keyPath = [folderPath stringByAppendingPathComponent:key];
    
    return keyPath;
}



@interface ArchivingCache ()

- (void)setCacheData:(NSData*)data forKey:(NSString*)key;
- (void)removeItemFromCache:(NSString*)key;
- (NSData*)getDataForKey:(NSString*)key;

//Disk Operation
- (void)performDiskWriteOperation:(NSInvocation *)invocation;
- (void)writeData:(NSData*)data toPath:(NSString *)path;
- (void)deleteDataAtPath:(NSString *)path;


@end

#pragma mark -

@implementation ArchivingCache


+ (id)sharedCache
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; 
    });
    return _sharedObject;
}


- (id)init
{
	if((self = [super init]))
    {
        
		diskOperationQueue = [[NSOperationQueue alloc] init];
		
		[[NSFileManager defaultManager] createDirectoryAtPath:CacheDirectory()
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];		
	}
	
	return self;
}


#pragma mark -
#pragma mark Public Methods

- (void)clearCache
{
    
}

- (void)removeCacheForKey:(NSString*)key
{
	[self removeItemFromCache:key];
}

- (BOOL)isCachedForKey:(NSString*)key
{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:cachePathForKey(key)] )
    {
        return YES;
    }
    
    return NO;
}

#pragma mark Object methods

- (id<NSCoding>)objectForKey:(NSString*)key
{
	if([self isCachedForKey:key])
    {
		return [NSKeyedUnarchiver unarchiveObjectWithData:[self getDataForKey:key]];
	}
    else
    {
		return nil;
	}
}

- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key
{
    if([self isCachedForKey:key])
    {
        [self deleteDataAtPath:cachePathForKey(key)];
    }
    
    if ([(id)anObject conformsToProtocol:@protocol(NSCoding)])
    {
        NSData *tData = [NSKeyedArchiver archivedDataWithRootObject:anObject];
        [self setCacheData:tData forKey:key];
    }
    else
    {
        NSAssert(NO, @"Unrealized protocol object send to Method:'- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key'");
    }
    
}



#pragma mark -
#pragma mark Private:Tool Methods

- (void)setCacheData:(NSData*)data forKey:(NSString*)key
{
    NSString* cachePath = cachePathForKey(key);
	NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
	[writeInvocation setTarget:self];
	[writeInvocation setSelector:@selector(writeData:toPath:)];
	[writeInvocation setArgument:&data atIndex:2];
	[writeInvocation setArgument:&cachePath atIndex:3];
	
	[self performDiskWriteOperation:writeInvocation];
    
}

- (void)removeItemFromCache:(NSString*)key
{
	NSString* cachePath = cachePathForKey(key);
	
	NSInvocation* deleteInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(deleteDataAtPath:)]];
	[deleteInvocation setTarget:self];
	[deleteInvocation setSelector:@selector(deleteDataAtPath:)];
	[deleteInvocation setArgument:&cachePath atIndex:2];
	
	[self performDiskWriteOperation:deleteInvocation];
}

- (NSData*)getDataForKey:(NSString*)key
{
	if([self isCachedForKey:key])
    {
        NSLog(@"key:%@",cachePathForKey(key));
        
		return [NSData dataWithContentsOfFile:cachePathForKey(key) options:0 error:NULL];
        
        
	}
    else
    {
		return nil;
	}
}

#pragma mark Disk Operation

- (void)performDiskWriteOperation:(NSInvocation *)invocation
{
	NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
	[diskOperationQueue addOperation:operation];
    
}

- (void)writeData:(NSData*)data toPath:(NSString *)path
{
    BOOL success = [data writeToFile:path atomically:YES];
    
    if(success){
        NSLog(@"path:%@",path);
    }
    else{
        NSAssert(false, @"");
        
    }
    
    
}

- (void)deleteDataAtPath:(NSString *)path
{
	[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    
    NSLog(@"path:%@",path);
}




@end



