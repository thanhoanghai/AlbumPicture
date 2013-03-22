//
//  ViewFullImageController.m
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ViewFullImageController.h"
#import "UIImageView+AFNetworking.h"
#import "ItemImageObject.h"

#define IMAGE_W 320
#define IMAGE_H 302

@interface ViewFullImageController ()

@end

@implementation ViewFullImageController
@synthesize scrollView;
@synthesize imageView;
@synthesize imageViewAds;
@synthesize listItemImageFull;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    indexImage = 0;
    
    scrollView.maximumZoomScale = 10.0f;
    scrollView.minimumZoomScale = 1.0f;
    scrollView.delegate = self;
    
    [self setLinkImageAtIndex:0];
    
    [self.imageViewAds setImageWithURL:[[NSURL alloc] initWithString:@"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSDlITgoDxJuYLzINzBYfgSXI92YYyX3vTqbwQucI9LfALvGqon"]  placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    self.navigationController.navigationBar.hidden = YES;

}

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return imageView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setImageView:nil];
    [self setImageViewAds:nil];
    [super viewDidUnload];
}
- (IBAction)backToDetailAlbumView:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextImage:(id)sender {
    indexImage = indexImage + 1;
    if(indexImage < [listItemImageFull count])
        [self setLinkImageAtIndex:indexImage];
    else
        indexImage = [listItemImageFull count] - 1;
    
}

- (IBAction)backImage:(id)sender {
    indexImage = indexImage -1 ;
    if(indexImage >= 0)
        [self setLinkImageAtIndex:indexImage];
    else
        indexImage = 0;

}

-(void)setLinkImageAtIndex:(int)index
{
    ItemImageObject *item = [listItemImageFull objectAtIndex:index];
    [self.imageView setImageWithURL:[[NSURL alloc] initWithString: item.source]  withSize:CGSizeMake(IMAGE_W, IMAGE_H) placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
}
@end
