//
//  Cache.h
//  Cache
//
//  Created by expl on 12-11-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cache : NSObject {
@private
	NSOperationQueue* diskOperationQueue;
    
}

+ (Cache *)sharedCache;

- (void)clearCache;
- (void)removeCacheForKey:(NSString*)key;

- (BOOL)isCachedForKey:(NSString*)key;

- (id<NSCoding>)objectForKey:(NSString*)key;
- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key;




@end

