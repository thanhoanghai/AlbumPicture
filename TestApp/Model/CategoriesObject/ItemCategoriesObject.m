//
//  ItemCategoriesObject.m
//  TestApp
//
//  Created by HHHHHH on 3/22/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ItemCategoriesObject.h"

@implementation ItemCategoriesObject

@synthesize id_;
@synthesize cat_name;

+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[ItemCategoriesObject alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*) dictionary
{
    if(self = [super init])
    {
        self.id_ = nil;
        self.cat_name = nil;
               
        // read from json value
        if([dictionary objectForKey:JSONCategories_id] && [dictionary objectForKey:JSONCategories_id]!= [NSNull null]){
            self.id_ = [dictionary objectForKey:JSONCategories_id];
        }
        
        if([dictionary objectForKey:JSONCategories_cat_name] && [dictionary objectForKey:JSONCategories_cat_name]!= [NSNull null]){
            self.cat_name = [dictionary objectForKey:JSONCategories_cat_name];
        }
                    
    }    
    return self;
}

@end
