//
//  EncodeMd5.h
//  TestApp
//
//  Created by HHHHHH on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncodeMd5 : NSObject

+(NSString *) encodeMD5:(NSString *)str;
+ (NSString *)base64String:(NSString *)str;
+(NSString *) encodeMD5base64:(NSString *) str;
+(NSString *) getLinkKeyEndcode:(NSString *)link withKey:(NSString *)key ;
+(NSString*) getLinkRequestPicture:(NSString*)id_gallery withPage:(int)page withKey:(NSString *)key;
+(NSString*) getLinkRequestAlbum:(NSString*)cat_id withPage:(int)page withKey:(NSString *)key;
@end
