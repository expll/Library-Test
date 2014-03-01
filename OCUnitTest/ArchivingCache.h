//
//  Cache.h
//  Cache
//  Created by expl on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*
 该类将作为单例使用：
 （1）使用的是“固化”的存储方式。
 （2）该类的实例将配合其他的单例生成一个静态库。
 */

#import <Foundation/Foundation.h>


@interface ArchivingCache : NSObject {
@private
	NSOperationQueue* diskOperationQueue;
    
}

+ (ArchivingCache *)sharedCache;

- (void)clearCache;
- (void)removeCacheForKey:(NSString*)key;

- (BOOL)isCachedForKey:(NSString*)key;

- (id<NSCoding>)objectForKey:(NSString*)key;
- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key;




@end

