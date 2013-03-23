//
//  ItemSMSObject.m
//  TestApp
//
//  Created by HHHHHH on 3/23/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ItemSMSObject.h"

@implementation ItemSMSObject

@synthesize service;
@synthesize content;

+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[ItemSMSObject alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*) dictionary
{
    if(self = [super init])
    {
        self.service = nil;
        self.content = nil;
              
        // read from json value
        if([dictionary objectForKey:JSONSMS_service] && [dictionary objectForKey:JSONSMS_service]!= [NSNull null]){
            self.service = [dictionary objectForKey:JSONSMS_service];
        }
        
        if([dictionary objectForKey:JSONSMS_content] && [dictionary objectForKey:JSONSMS_content]!= [NSNull null]){
            self.content = [dictionary objectForKey:JSONSMS_content];
        }
                
    }
    return self;
}

@end
