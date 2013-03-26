//
//  ViewFullImageController.m
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "ViewFullImageController.h"
#import "UIImageView+AFNetworking.h"
#import "AFImageRequestOperation.h"
#import "ItemImageObject.h"

#define IMAGE_W 320
#define IMAGE_H 460

@interface ViewFullImageController ()

@end

@implementation ViewFullImageController
@synthesize scrollView;
@synthesize imageView;
@synthesize listItemImageFull;
@synthesize indexImage;
@synthesize viewArrow;
@synthesize viewTopBar;
@synthesize imageViewSmall;
@synthesize webview;

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
    totalImage = [listItemImageFull count];
    
    scrollView.maximumZoomScale = 10.0f;
    scrollView.minimumZoomScale = 1.0f;
    scrollView.delegate = self;
    scrollView.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                            initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapRecognizer setNumberOfTapsRequired:2];
    tapRecognizer.numberOfTouchesRequired  = 1;
    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc]
                            initWithTarget:self action:@selector(ClickEventOnImage:)];
    [tapRecognizer1 setNumberOfTapsRequired:2];
    tapRecognizer1.numberOfTouchesRequired  = 1;
    [self.imageViewSmall addGestureRecognizer:tapRecognizer1];


    [self setLinkImageTwoViewAtIndex:indexImage];
    self.imageView.userInteractionEnabled=NO;
    self.imageViewSmall.userInteractionEnabled=YES;
    
    showFull = false;
    self.navigationController.navigationBar.hidden = YES;
    
    webview.delegate = self;
    [self getAdsFromServer:webview];

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
    [self setViewArrow:nil];
    [self setViewTopBar:nil];
    [self setImageViewSmall:nil];
    [self setWebview:nil];
    [super viewDidUnload];
}
#pragma mark set_status_full_image

-(void)delayShowImage
{
        
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if(!showFull)
                return;
            indexImage = indexImage+ 1;
            if(indexImage >= totalImage)
            {
                indexImage = [listItemImageFull count]-1;
                return;
            }
            NSLog(@" slide = %d" , indexImage);
//            if(indexImage < [listItemImageFull count] && showFull)
//            {
//                [self setLinkImageTwoViewAtIndex:indexImage];
//                [self delayShowImage];                
//            }
         if(indexImage < [listItemImageFull count] && showFull)
         {
             ItemImageObject *item  = [listItemImageFull objectAtIndex:indexImage];
             [self.imageView setImageWithURLhasBlock:[[NSURL alloc] initWithString: item.source]
                                    placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]
                                             success:^(Boolean ok)
              {
                  [self delayShowImage];
              }
            failure:^(Boolean notOK){} ];

         }
        
    });
}

-(void) ClickEventOnImage:(id) sender
{
    [self setFullStatusImage];
}


-(void)setFullStatusImage
{
    showFull = !showFull;
    viewArrow.hidden = showFull;
    viewTopBar.hidden = showFull;
    if(showFull)
    {
        [self setImageForView:self.imageView withIndex:indexImage withRect:false];
        [self delayShowImage];
    }else
        [self setImageForView:self.imageViewSmall withIndex:indexImage withRect:true];
        
}


#pragma  mark ActionLoadImage
- (IBAction)nextImage:(id)sender {
    indexImage = indexImage + 1;
    if(indexImage < totalImage)
        [self setLinkImageTwoViewAtIndex:indexImage];
    else
        indexImage = totalImage- 1;
    
}

- (IBAction)backImage:(id)sender {
    indexImage = indexImage -1 ;
    if(indexImage >= 0)
        [self setLinkImageTwoViewAtIndex:indexImage];
    else
        indexImage = 0;

}

- (IBAction)backToDetailAlbum:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)touchDownloadImage:(id)sender {
    [self downloadAlbumImage];
}

- (void)downloadAlbumImage {
    
    NSString *guideName = @"abc.jpg";
    NSString *photourl = [self getLinkImageAtIndex:0];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:photourl]];
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request,NSHTTPURLResponse *response,UIImage *image)
    {
        // Get dir
        NSString *documentsDirectory = nil;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
        documentsDirectory = [paths objectAtIndex:0];
        NSString *pathString = [NSString stringWithFormat:@"%@/%@",documentsDirectory, guideName];
        
        // Save Image
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        [imageData writeToFile:pathString atomically:YES];
        
        NSLog(@"download complete");
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
    {
                                              NSLog(@"%@", [error localizedDescription]);
    }];    
    [operation start];
}

-(void)setImageForView:(UIImageView*)img withIndex:(int)i withRect:(Boolean)hasRect
{
    ItemImageObject *item = [listItemImageFull objectAtIndex:i];
    if(hasRect)
    {
        [img setImageWithURL:[[NSURL alloc] initWithString: item.source]
                    withSize:    self.imageView.frame.size
            placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    }
    else
    {
        [img setImageWithURL:[[NSURL alloc] initWithString: item.source]                    
            placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    }
}

-(void)setLinkImageTwoViewAtIndex:(int)index
{
    if(showFull)
    {
        [self setImageForView:self.imageView withIndex:index withRect:false];
        if(index + 1 < totalImage)
        {
            [self setImageForView:self.imageViewSmall withIndex:(index+1) withRect:true];
        }
    }else
    {
        [self setImageForView:self.imageViewSmall withIndex:index withRect:true];
        if(index + 1 < totalImage)
        {
            [self setImageForView:self.imageView withIndex:(index+1) withRect:false];
        }

    }
}
-(void)setTempImage
{
    if(indexImage+1 < totalImage)
    {
        ItemImageObject *item = [listItemImageFull objectAtIndex:(indexImage+1) ];
        [imageviewTemp setImageWithURL:[[NSURL alloc] initWithString: item.source]
                       placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    }
    
}
-(NSString*) getLinkImageAtIndex:(int)index
{
        ItemImageObject *item = [listItemImageFull objectAtIndex:index];
        return item.source;
}
@end
