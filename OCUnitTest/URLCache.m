//
//  URLCache.m
//  
//
//  Created by expl on 12-11-12.
//  Copyright (c) 2012年 Voyage Group China Technology. All rights reserved.
//

#import "URLCache.h"
#import "Cache.h"

@implementation URLCache

+ (id)sharedCache
{
    __strong static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
	
	return _sharedInstance;
}

- (id) init
{
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request
{
    NSString *pathString = [[request URL] absoluteString];
    
    if([self isNeedToCache:pathString] 
       && [[Cache sharedCache] isCachedForKey:pathString])
    {
        NSData *data =(NSData *)[[Cache sharedCache] objectForKey:pathString];
        NSURLResponse *response = [[NSURLResponse alloc] initWithURL:[request URL]
                                                            MIMEType:[NSString stringWithFormat:@"image/%@",[pathString pathExtension]]
                                               expectedContentLength:[data length]
                                                    textEncodingName:nil];
        NSLog(@"%@",pathString);
        
        return [[NSCachedURLResponse alloc] initWithResponse:response data:data];
        
    }
    else
    {
        return [super cachedResponseForRequest:request];
    }
    
}

- (void)storeCachedResponse:(NSCachedURLResponse *)cachedResponse forRequest:(NSURLRequest *)request
{
    NSString *pathString = [[request URL] absoluteString];
    
    if([self isNeedToCache:pathString])
    {
        [[Cache sharedCache] setObject:cachedResponse.data forKey:pathString];
        
        NSLog(@"%@",pathString);
    }
    else
    {
        [super storeCachedResponse:cachedResponse forRequest:request];
    }
    
}

-(BOOL)isNeedToCache:(NSString *)str{
    return [str hasSuffix:@".jpg"] || [str hasSuffix:@".jpeg"] ||  [str hasSuffix:@".gif"] || [str hasSuffix:@".png"] ;
}
@end
