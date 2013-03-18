//
//  LRRequestHelper.h
//  LondonRemember
//
//  Created by tran vuong kha on 9/17/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LRRequestHelper : NSObject

+(void)loadLink:(NSString *)link
                        success:(void (^)(id))successBlock
                        failure:(void (^)(NSString *))failureBlock;


@end
