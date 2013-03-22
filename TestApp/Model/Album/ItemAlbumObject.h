//
//  ItemAlbumObject.h
//  TestApp
//
//  Created by HHHHHH on 3/22/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONAlbum_id @"id"
#define JSONAlbum_cat_id @"cat_id"
#define JSONAlbum_name @"name"
#define JSONAlbum_thumb @"thumb"

@interface ItemAlbumObject : NSObject

@property (strong, nonatomic) NSString *id_;
@property (strong, nonatomic) NSString *cat_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *thumb;

+ (id)itemWithDictionary:(NSDictionary*) dictionary;
- (id)initWithDictionary:(NSDictionary*) dictionary;

@end
