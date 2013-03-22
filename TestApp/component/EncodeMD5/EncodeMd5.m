//
//  EncodeMd5.m
//  TestApp
//
//  Created by HHHHHH on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "EncodeMd5.h"
#import <CommonCrypto/CommonDigest.h>
#import "LRURLs.h"

@implementation EncodeMd5


+(NSString *) encodeMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    // Create lowercase NSString
    NSString *format = @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X";
    NSString *hashedString = [[NSString stringWithFormat:format, result[0], result[1], result[2], result[3], result[4],
                               result[5], result[6], result[7],
                               result[8], result[9], result[10], result[11], result[12],
                               result[13], result[14], result[15]] lowercaseString];
    return hashedString;
    
}

+ (NSString *)base64String:(NSString *)str
{
    NSData *theData = [str dataUsingEncoding: NSASCIIStringEncoding];
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+(NSString *) encodeMD5base64:(NSString *) str
{
    NSString *base64 = [self base64String:str];
    NSString *md5 = [self encodeMD5:base64];
    return md5;
}

+(NSString *) getLinkKeyEndcode:(NSString *)link withKey:(NSString *)key
{
    NSString *keyEncode = [self encodeMD5base64:key];
    NSString *linkMd5 = [NSString stringWithFormat:@"%@%@",link,keyEncode];
    return linkMd5;
}
+(NSString*) getLinkRequestPicture:(NSString*)id_gallery withPage:(int)page withKey:(NSString *)key
{
    NSString *keyEncode = [self encodeMD5base64:key];
    NSString *link = [NSString stringWithFormat:@"%@%@%@%d%@%@",LINK_REQUEST_PICTURE,
                         id_gallery,LINK_PARAM_PAGE,page,LINK_PARAM_DEVIE_KEY,keyEncode];
    return link;
}
+(NSString*) getLinkRequestAlbum:(NSString*)cat_id withPage:(int)page withKey:(NSString *)key
{
    NSString *keyEncode = [self encodeMD5base64:key];
    NSString *link = [NSString stringWithFormat:@"%@%@%@%d%@%@",LINK_REQUEST_ALBUM,
                      cat_id,LINK_PARAM_PAGE,page,LINK_PARAM_DEVIE_KEY,keyEncode];
    return link;
}

@end
