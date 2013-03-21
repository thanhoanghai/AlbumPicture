//
//  LRSearchItem.h
//  LondonRemember
//
//  Created by tran vuong kha on 9/18/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import <Foundation/Foundation.h>

#define JSONAlbum_gallery_id @"gallery_id"
#define JSONAlbum_name @"name"
#define JSONAlbum_source @"source"
#define JSONAlbum_thumb @"thumb"

@interface AlbumObject : NSObject
{
}

@property (strong, nonatomic) NSString *gallery_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *source;
@property (strong, nonatomic) NSString *thumb;

+ (id)itemWithDictionary:(NSDictionary*) dictionary;
- (id)initWithDictionary:(NSDictionary*) dictionary;









@end
