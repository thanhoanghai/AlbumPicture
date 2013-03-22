//
//  ItemAlbumObject.m
//  TestApp
//
//  Created by HHHHHH on 3/22/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ItemAlbumObject.h"

@implementation ItemAlbumObject

@synthesize id_;
@synthesize cat_id;
@synthesize name;
@synthesize thumb;

+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[ItemAlbumObject alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*) dictionary
{
    if(self = [super init])
    {
        self.id_ = nil;
        self.name = nil;
        self.cat_id = nil;
        self.thumb = nil;
        
        // read from json value
        if([dictionary objectForKey:JSONAlbum_id] && [dictionary objectForKey:JSONAlbum_id]!= [NSNull null]){
            self.id_ = [dictionary objectForKey:JSONAlbum_id];
        }
        
        if([dictionary objectForKey:JSONAlbum_cat_id] && [dictionary objectForKey:JSONAlbum_cat_id]!= [NSNull null]){
            self.cat_id = [dictionary objectForKey:JSONAlbum_cat_id];
        }
        
        if([dictionary objectForKey:JSONAlbum_name] && [dictionary objectForKey:JSONAlbum_name]!= [NSNull null]){
            self.name = [dictionary objectForKey:JSONAlbum_name];
        }
        
        if([dictionary objectForKey:JSONAlbum_thumb] && [dictionary objectForKey:JSONAlbum_thumb]!= [NSNull null]){
            self.thumb = [dictionary objectForKey:JSONAlbum_thumb];
        }
        
    }
    return self;
}

@end
