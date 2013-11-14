//
//  XML.m
//  Library&Test
//
//  Created by Tiny on 11/1/13.
//
//

#import "XML.h"

@implementation XML

+ (XML *)sharedXML
{
    static XML *_sharedObject;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[XML alloc] init];
    });
    
    return _sharedObject;
}

- (id) init
{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

@end
