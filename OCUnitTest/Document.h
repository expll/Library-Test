//
//  Document.h
//  
//
//  Created by expl on 12-11-12.
//  Copyright (c) 2012年 Voyage Group China Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Document : NSObject{
@private
	NSOperationQueue* queue;
}
+ (Document *)sharedDocument;

- (void)clearDocument;
- (void)removeDocumentForKey:(NSString*)key;

- (BOOL)isDocumentedForKey:(NSString*)key;

- (id<NSCoding>)objectForKey:(NSString*)key;
- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key;

@end
