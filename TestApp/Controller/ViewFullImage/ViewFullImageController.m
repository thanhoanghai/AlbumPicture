//
//  ViewFullImageController.m
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ViewFullImageController.h"
#import "UIImageView+AFNetworking.h"

@interface ViewFullImageController ()

@end

@implementation ViewFullImageController
@synthesize scrollView;
@synthesize imageView;
@synthesize imageViewAds;

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
    
    scrollView.maximumZoomScale = 10.0f;
    scrollView.minimumZoomScale = 1.0f;
    scrollView.delegate = self;
    
    [self.imageView setImageWithURL:[[NSURL alloc] initWithString:@"http://www.cavemancircus.com/wp-content/uploads/images/2012/august/asian_2/hot_asian_girls_4.jpg"]  placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
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
@end
