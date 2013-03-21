

#import "AlbumObject.h"

@implementation AlbumObject
@synthesize gallery_id;
@synthesize thumb;
@synthesize source;
@synthesize name;


+ (id)itemWithDictionary:(NSDictionary*) dictionary
{
    return [[AlbumObject alloc] initWithDictionary:dictionary];
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
        if([dictionary objectForKey:JSONAlbum_gallery_id] && [dictionary objectForKey:JSONAlbum_gallery_id]!= [NSNull null]){
            self.gallery_id = [dictionary objectForKey:JSONAlbum_gallery_id];
        }

        if([dictionary objectForKey:JSONAlbum_name] && [dictionary objectForKey:JSONAlbum_name]!= [NSNull null]){
            self.name = [dictionary objectForKey:JSONAlbum_name];
        }

        if([dictionary objectForKey:JSONAlbum_source] && [dictionary objectForKey:JSONAlbum_source]!= [NSNull null]){
            self.source = [dictionary objectForKey:JSONAlbum_source];
        }

        if([dictionary objectForKey:JSONAlbum_thumb] && [dictionary objectForKey:JSONAlbum_thumb]!= [NSNull null]){
            self.thumb = [dictionary objectForKey:JSONAlbum_thumb];
        }

    }    
    return self;
}
@end
