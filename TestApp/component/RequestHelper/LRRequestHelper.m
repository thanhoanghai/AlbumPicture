//
//  LRRequestHelper.m
//  LondonRemember
//
//  Created by tran vuong kha on 9/17/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import "LRRequestHelper.h"
#import "LRApiClient.h"
#import <CommonCrypto/CommonDigest.h>

@interface LRRequestHelper()
/**
 Returns UTC formatted current datetime
 */
+ (NSString *)UTCDate;

/**
 Returns API request signature
 @param the path to sign
 @return the signed path
 */
+ (NSString *)signatureForPath:(NSString *)path;

/**
 SHA1 Encrypts a string
 */
+ (NSString*)SHA1Digest:(NSString*)input;

/**
 Returns the current logged in users user token for api requests
 */
+ (NSString *)userToken;
/**
 Returns the request url with server type, domain and path
 */
+ (NSString *)requestURLWithPath:(NSString *)path;
/**
 Returns the request URL
 */
+ (NSString *)buildUrlWithBase:(NSString *)urlBase
                   requestPath:(NSString *)path
                 withUserToken:(BOOL)boolean;
/**
 return signed path
 */
+ (NSString *)buildSignedPath:(NSString *)path;

/**
 return path with id
 */
+ (NSString *)path:(NSString*) path withId:(NSString* )_id;

@end
@implementation LRRequestHelper

#pragma mark - private helper functions
+ (NSString *)UTCDate
{
    NSDate *date = [[NSDate alloc] init];
    
    NSString *utc = [NSString stringWithFormat:@"%i",(int)[date timeIntervalSince1970]];
    
    return utc;
}


+ (NSString*)SHA1Digest:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}



+ (NSString *)userToken
{
    return @"";
}

+ (NSString *)requestURLWithPath:(NSString *)path
{
    return @"";
}

+ (NSString *)buildUrlWithBase:(NSString *)urlBase
                   requestPath:(NSString *)path
                 withUserToken:(BOOL)boolean
{
    return @"";
}


+ (NSString *)path:(NSString*) path withId:(NSString* )_id{
    return [NSString stringWithFormat:@"%@/%@",path,_id];
}

#pragma mark - Search function

+(void)loadLink:(NSString *)link
                              success:(void (^)(id))successBlock
                              failure:(void (^)(NSString *))failureBlock{
    // set params
    NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
    //[params setObject:query forKey:@"q"]

    // call api
    [[LRApiClient sharedClient] getPath:link
                             parameters:params
                                success:^(AFHTTPRequestOperation *operation, id JSON) {
                                    // success                                   
                                    if(successBlock){                                        
                                        successBlock(JSON);
                                    }
                                }
                                failure:^(AFHTTPRequestOperation *operation, NSError *error){
                                    if(failureBlock){
                                        failureBlock([error localizedDescription]);
                                    }
                                    // failure
                                }];
}


@end
