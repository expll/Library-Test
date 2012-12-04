//
//  Network.h
//  
//
//  Created by expl on 11/12/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Network : NSObject

@property (nonatomic,strong) NSOperationQueue *queue;

//
// types
//
typedef enum {
    request_http,
    request_image,
    request_json,
    request_property_list,
    request_url_connection,
    request_xml
} requestType;

//
// commonly used
//
+ (id)sharedNetwork;
- (NSInteger)checkHostConnection: (NSString *)host;
- (void)loadDataWithUrl:(NSString *)urlString success:(void(^)(id))success failure:(void(^)(NSError *))failure requestType:(requestType)type;
- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void(^)(id))success failure:(void(^)(NSError *))failure;


//
// api different as app
//
- (void)fetchImageWith:(NSString *)url 
               success:(void(^)(id))success 
               failure:(void(^)(NSError *))failure;

- (void)fetchImageDataWith:(NSString *)url 
               success:(void(^)(id))success
               failure:(void(^)(NSError *))failure;





@end
