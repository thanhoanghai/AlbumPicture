//
//  LRApiClient.h
//  LondonRemember
//
//  Created by tran vuong kha on 9/18/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"
@interface LRApiClient : AFHTTPClient
+ (LRApiClient *)sharedClient;

+ (LRApiClient *)postClient;
@end
