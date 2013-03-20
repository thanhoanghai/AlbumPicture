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
    
    [self.imageView setImageWithURL:[[NSURL alloc] initWithString:@"http://www.janlamm.com/Superman/Superman8.jpg"]  placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    //self.navigationController.navigationBar.hidden = YES;

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
    [super viewDidUnload];
}
@end
