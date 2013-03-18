//
//  LRApiClient.m
//  LondonRemember
//
//  Created by tran vuong kha on 9/18/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import "LRApiClient.h"
#import "AFJSONRequestOperation.h"
#import "LRURLs.h"
@implementation LRApiClient

+ (LRApiClient *)sharedClient{
    static LRApiClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",kServer,kDomain];
    dispatch_once(&onceToken,^{sharedClient = [[LRApiClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];});
    return sharedClient;
    
}

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
   // [self setDefaultHeader:<#(NSString *)#> value:<#(NSString *)#>
   // [self setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    return self;
}

+ (LRApiClient *)postClient{
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",kServer,kDomain];
   return [[LRApiClient alloc] initWithBaseURL1:[NSURL URLWithString:baseUrl]];
}

- (id)initWithBaseURL1:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	//[self setDefaultHeader:@"Accept" value:@"application/json"];
    // [self setDefaultHeader:<#(NSString *)#> value:<#(NSString *)#>
     [self setDefaultHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
    return self;
}
@end
