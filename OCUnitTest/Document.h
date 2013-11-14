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

// 获取应用程序的信息
- (NSDictionary *)getAppInfo;

// 获取Bundle中的文件
- (NSString *)getBundleFile: (NSString *)fileName;

// 获取沙盒文件
- (NSString *)getSandboxFile;

- (NSString *)documentDictionary;

- (void)clearDocument;
- (void)removeDocumentForKey:(NSString*)key;

- (BOOL)isDocumentedForKey:(NSString*)key;

- (id<NSCoding>)objectForKey:(NSString*)key;
- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key;

@end
