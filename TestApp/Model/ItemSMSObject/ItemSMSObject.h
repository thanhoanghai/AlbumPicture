//
//  ItemSMSObject.h
//  TestApp
//
//  Created by HHHHHH on 3/23/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONSMS_service @"service"
#define JSONSMS_content @"content"

@interface ItemSMSObject : NSObject


@property (strong, nonatomic) NSString *service;
@property (strong, nonatomic) NSString *content;

+ (id)itemWithDictionary:(NSDictionary*) dictionary;
- (id)initWithDictionary:(NSDictionary*) dictionary;

@end
