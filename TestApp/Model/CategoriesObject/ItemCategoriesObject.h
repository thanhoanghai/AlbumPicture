//
//  ItemCategoriesObject.h
//  TestApp
//
//  Created by HHHHHH on 3/22/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONCategories_id @"id"
#define JSONCategories_cat_name @"cat_name"



@interface ItemCategoriesObject : NSObject
{}
@property (strong, nonatomic) NSString *id_;
@property (strong, nonatomic) NSString *cat_name;

+ (id)itemWithDictionary:(NSDictionary*) dictionary;
- (id)initWithDictionary:(NSDictionary*) dictionary;
@end
