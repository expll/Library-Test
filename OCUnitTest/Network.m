//
//
//  Created by expl on 11/12/12.
//  Copyright (c) 2012 . All rights reserved.
//

#import "Network.h"
#import "Reachability.h"
#import "AFHTTPClient.h"
#import "AFImageRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "AFURLConnectionOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFPropertyListRequestOperation.h"

@interface Network()

@end

@implementation Network
@synthesize queue;

#pragma mark == commonly used ==
+ (Network *)sharedNetwork{
    static dispatch_once_t  onceToken;
    static Network *sharedInstance;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Network alloc] init];
        sharedInstance.queue = [[NSOperationQueue alloc] init];
        [sharedInstance.queue setMaxConcurrentOperationCount:4];
    });
    return sharedInstance;
}

-(NSInteger)checkHostConnection: (NSString *)host {
	Reachability *reachability = [Reachability reachabilityWithHostname:host];
	NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
	return remoteHostStatus;
}

-(void)loadDataWithUrl:(NSString *)urlString 
               success:(void(^)(id))success 
               failure:(void(^)(NSError *))failure
           requestType:(requestType)type
{
    if([self checkHostConnection:HOST] == NotReachable){
        dispatch_async(dispatch_get_main_queue(), ^{
            failure(nil);
        });
        return;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    id operation = nil;
    
    switch (type) {
        case request_http:
        {
            operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                success(responseObject);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                ;
            }];
            
            break;
        }
        case request_image:
        {
            operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(image);
                });
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {

            }];
            
            break;
        } 
        case request_json:
        {
            operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(JSON);
                });
            } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                ;
            }];
        } break;
        case request_property_list:
        {
            ;
            break;
        }
        case request_url_connection:
        {
            ;
            break;
        }
        case request_xml:
        {
            ;
            break;
        }
        default:
            break;
    }
    
    NSAssert(operation, @"operation is nil");
    
    [queue addOperation:operation];
}

- (void)postPath:(NSString *)path parameters:(NSDictionary *)parameters success:(void(^)(id))success failure:(void(^)(NSError *))failure
{
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:path]];
    [client postPath:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}


#pragma mark == different as app ==
- (void)fetchImageWith:(NSString *)url 
               success:(void(^)(id))success 
                  failure:(void(^)(NSError *))failure 
{
    [self loadDataWithUrl:url success:success failure:failure requestType:request_image];
}

- (void)fetchImageDataWith:(NSString *)url 
               success:(void(^)(id))success 
               failure:(void(^)(NSError *))failure 
{
    [self loadDataWithUrl:url success:success failure:failure requestType:request_http];
}








@end
