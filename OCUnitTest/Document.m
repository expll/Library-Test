//
//  Document.m
//  
//
//  Created by expl on 12-11-12.
//  Copyright (c) 2012年 Voyage Group China Technology. All rights reserved.
//

#import "Document.h"

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

static inline NSString *documentPathForKey(NSString *key)
{
    NSInteger keyHash = (NSInteger)[key hash];
    int keyNum = keyHash % 100;
    
    NSString *folderPath = [DocumentDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Dir%d",keyNum]];
    
    //create the folder if not existed
    [[NSFileManager defaultManager] createDirectoryAtPath:folderPath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:NULL];
    key = [key stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    NSString *keyPath = [folderPath stringByAppendingPathComponent:key];
    return keyPath;
}


@interface Document ()

@end

@implementation Document

+ (id)sharedDocument
{
	static Document *_sharedObject;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedObject = [[Document alloc] init];
    });
    
    return _sharedObject;
}

- (id)init
{
	if((self = [super init]))
    {
        
		queue = [[NSOperationQueue alloc] init];
		
		[[NSFileManager defaultManager] createDirectoryAtPath:DocumentDirectory()
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
		
	}
	
	return self;
}


#pragma mark -
#pragma mark Public Methods

- (NSString *)documentDictionary
{
    return DocumentDirectory();
}

- (NSDictionary *)getAppInfo
{
    return [[NSBundle mainBundle] infoDictionary];
}

- (NSString *)getBundleFile: (NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@""];
    return filePath;
}

- (NSString *)getSandboxFile
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    //打印结果如下：
    ///Users/apple/Library/Application Support/iPhone Simulator/4.3/Applications/550AF26D-174B-42E6-881B-B7499FAA32B7/Documents
}


- (void)clearDocument
{

}

- (void)removeDocumentForKey:(NSString*)key
{
	[self removeDataFromDocument:key];
}

- (BOOL)isDocumentedForKey:(NSString*)key
{
    if ( [[NSFileManager defaultManager] fileExistsAtPath:documentPathForKey(key)] )
    {
        return YES;
    }
    
    return NO;
}

#pragma mark Object methods

- (id<NSCoding>)objectForKey:(NSString*)key
{
	if([self isDocumentedForKey:key])
    {
		id sth = [NSKeyedUnarchiver unarchiveObjectWithData:[self getDataForKey:key]];
        return sth;
	}
    else
    {
		return nil;
	}
}

- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key
{
    if([self isDocumentedForKey:key])
    {
        [self deleteDataAtPath:documentPathForKey(key)];
    }
    
    if ([(id)anObject conformsToProtocol:@protocol(NSCoding)])
    {
        NSData *tData = [NSKeyedArchiver archivedDataWithRootObject:anObject];
        [self setDataToDocument:tData forKey:key];
    }
    else
    {
#ifdef DEBUG
        NSAssert(NO, @"Unrealized protocol object send to Method:'- (void)setObject:(id<NSCoding>)anObject forKey:(NSString*)key'");
#endif
    }
    
}



#pragma mark -
#pragma mark Private Methods, Tool Methods



- (void)setDataToDocument:(NSData*)data forKey:(NSString*)key
{
    NSString* documentPath = documentPathForKey(key);
	NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:)]];
	[writeInvocation setTarget:self];
	[writeInvocation setSelector:@selector(writeData:toPath:)];
	[writeInvocation setArgument:&data atIndex:2];
	[writeInvocation setArgument:&documentPath atIndex:3];
	
	[self performDiskWriteOperation:writeInvocation];
    
}

- (void)removeDataFromDocument:(NSString*)key
{
	NSString* documentPath = documentPathForKey(key);
	
	NSInvocation* deleteInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(deleteDataAtPath:)]];
	[deleteInvocation setTarget:self];
	[deleteInvocation setSelector:@selector(deleteDataAtPath:)];
	[deleteInvocation setArgument:&documentPath atIndex:2];
	
	[self performDiskWriteOperation:deleteInvocation];
}

- (NSData*)getDataForKey:(NSString*)key
{
	if([self isDocumentedForKey:key])
    {
		id sth = [NSData dataWithContentsOfFile:documentPathForKey(key) options:0 error:NULL];
        return sth;
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
	[queue addOperation:operation];
    
}

- (void)writeData:(NSData*)data toPath:(NSString *)path
{
	[data writeToFile:path atomically:YES];
}

- (void)deleteDataAtPath:(NSString *)path
{
	[[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
}






//#pragma mark -
//#pragma mark updateDocument
//
//-(void)updateDocumentWithObject:(id<NSCoding>)anObject forKey:(NSString *)key
//{
//    if([self hasDocumentForKey:key]){
//        [self removeDocumentForKey:key];
//        
//    }
//    if(anObject != nil)
//    {
//        [self setObject:anObject forKey:key];
//    }
//}

@end
