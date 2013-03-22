

#import "ItemImageObject.h"

@implementation ItemImageObject
@synthesize gallery_id;
@synthesize thumb;
@synthesize source;
@synthesize name;


+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[ItemImageObject alloc] initWithDictionary:dictionary];
}

- (id)initWithDictionary:(NSDictionary*) dictionary
{
    if(self = [super init])
    {
        self.gallery_id = nil;
        self.name = nil;
        self.source = nil;
        self.thumb = nil;
        
        // read from json value
        if([dictionary objectForKey:JSONPicture_gallery_id] && [dictionary objectForKey:JSONPicture_gallery_id]!= [NSNull null]){
            self.gallery_id = [dictionary objectForKey:JSONPicture_gallery_id];
        }

        if([dictionary objectForKey:JSONPicture_name] && [dictionary objectForKey:JSONPicture_name]!= [NSNull null]){
            self.name = [dictionary objectForKey:JSONPicture_name];
        }

        if([dictionary objectForKey:JSONPicture_source] && [dictionary objectForKey:JSONPicture_source]!= [NSNull null]){
            self.source = [dictionary objectForKey:JSONPicture_source];
        }

        if([dictionary objectForKey:JSONPicture_thumb] && [dictionary objectForKey:JSONPicture_thumb]!= [NSNull null]){
            self.thumb = [dictionary objectForKey:JSONPicture_thumb];
        }

    }    
    return self;
}
@end
