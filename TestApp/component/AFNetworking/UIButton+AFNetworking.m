//
//  UIButton+AFNetworking.m
//
//  Created by David Pettigrew on 6/12/12.
//  Copyright (c) 2012 ELC Technologies. All rights reserved.
//

// Based upon UIImageView+AFNetworking.m
//
// Copyright (c) 2011 Gowalla (http://gowalla.com/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "UIButton+AFNetworking.h"
#import <objc/runtime.h>

#define INDICATOR_TAG 13

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import "UIImage+Extension.h"

@interface AFButtonImageCache : NSCache
- (UIImage *)cachedImageForRequest:(NSURLRequest *)request;
- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request;
@end

#pragma mark -

static char kAFImageRequestOperationObjectKey;

@interface UIButton (_AFNetworking)
@property (readwrite, nonatomic, retain, setter = af_setImageRequestOperation:) AFImageRequestOperation *af_imageRequestOperation;
@end

@implementation UIButton (_AFNetworking)
@dynamic af_imageRequestOperation;
@end

#pragma mark -

@implementation UIButton (AFNetworking)

- (void)setImageWithURL:(NSURL *)url withSize:(CGSize)size placeholderImage:(UIImage *)placeholderImage forState:(UIControlState)state {
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView*)[self viewWithTag:INDICATOR_TAG];
    if(!loadingView){
        loadingView =   [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
        //loadingView.center = self.center;
        loadingView.alpha = 1.0;
        loadingView.hidesWhenStopped = YES;
        [loadingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
        [loadingView setTag:INDICATOR_TAG];
        [self addSubview:loadingView];
    }
    
    [loadingView startAnimating];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPShouldHandleCookies:NO];
    [request setHTTPShouldUsePipelining:YES];
    
    void(^successBlock)(UIImage*) = ^(UIImage *image){
        [self setImage:[image imageByScalingAndCroppingForSize:size] forState:state];
    };
    
    [self setImageWithURLRequest:request placeholderImage:placeholderImage forState: state success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        successBlock(image);
        [loadingView stopAnimating];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        [loadingView stopAnimating];
    }];
}

- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest 
              placeholderImage:(UIImage *)placeholderImage 
                      forState:(UIControlState)state
                       success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                       failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure
{
    [self cancelImageRequestOperation];
    
    UIImage *cachedImage = [[[self class] af_sharedImageCache] cachedImageForRequest:urlRequest];
    if (cachedImage) {
        //[self setImage:cachedImage forState:state];
        self.af_imageRequestOperation = nil;
        
        if (success) {
            success(nil, nil, cachedImage);
        }
    } else {
        [self setImage:placeholderImage forState:state];
        
        AFImageRequestOperation *requestOperation = [[AFImageRequestOperation alloc] initWithRequest:urlRequest];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                //[self setImage:responseObject forState:state];
                self.af_imageRequestOperation = nil;
            }
            
            if (success) {
                success(operation.request, operation.response, responseObject);
            }
            
            [[[self class] af_sharedImageCache] cacheImage:responseObject forRequest:urlRequest];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if ([[urlRequest URL] isEqual:[[self.af_imageRequestOperation request] URL]]) {
                self.af_imageRequestOperation = nil;
            }
            
            if (failure) {
                failure(operation.request, operation.response, error);
            }
            
        }];
        
        self.af_imageRequestOperation = requestOperation;
        
        [[[self class] af_sharedImageRequestOperationQueue] addOperation:self.af_imageRequestOperation];
    }
}

- (AFHTTPRequestOperation *)af_imageRequestOperation {
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, &kAFImageRequestOperationObjectKey);
}

- (void)af_setImageRequestOperation:(AFImageRequestOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kAFImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSOperationQueue *)af_sharedImageRequestOperationQueue {
    static NSOperationQueue *_af_imageRequestOperationQueue = nil;
    
    if (!_af_imageRequestOperationQueue) {
        _af_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_af_imageRequestOperationQueue setMaxConcurrentOperationCount:8];
    }
    
    return _af_imageRequestOperationQueue;
}

+ (AFButtonImageCache *)af_sharedImageCache {
    static AFButtonImageCache *_af_imageCache = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _af_imageCache = [[AFButtonImageCache alloc] init];
    });
    
    return _af_imageCache;
}

#pragma mark -

- (void)cancelImageRequestOperation {
    [self.af_imageRequestOperation cancel];
    self.af_imageRequestOperation = nil;
}

@end

#pragma mark -

static inline NSString * AFButtonImageCacheKeyFromURLRequest(NSURLRequest *request) {
    return [[request URL] absoluteString];
}

@implementation AFButtonImageCache

- (UIImage *)cachedImageForRequest:(NSURLRequest *)request {
    switch ([request cachePolicy]) {
        case NSURLRequestReloadIgnoringCacheData:
        case NSURLRequestReloadIgnoringLocalAndRemoteCacheData:
            return nil;
        default:
            break;
    }
    
	return [self objectForKey:AFButtonImageCacheKeyFromURLRequest(request)];
}

- (void)cacheImage:(UIImage *)image
        forRequest:(NSURLRequest *)request
{
    if (image && request) {
        [self setObject:image forKey:AFButtonImageCacheKeyFromURLRequest(request)];
    }
}

@end

#endif