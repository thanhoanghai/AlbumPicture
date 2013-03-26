//
//  ViewFullImageController.h
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ViewFullImageController : BaseViewController <UIScrollViewDelegate,UIGestureRecognizerDelegate,UIWebViewDelegate>
{
    Boolean showFull;
    UIImageView *imageviewTemp;
    int totalImage;
}
@property (weak, nonatomic) IBOutlet UIWebView *webview;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall;
@property (weak, nonatomic) IBOutlet UIView *viewArrow;
@property (weak, nonatomic) IBOutlet UIView *viewTopBar;


@property (strong, nonatomic) NSMutableArray *listItemImageFull;
@property(nonatomic, assign) int indexImage;

- (IBAction)nextImage:(id)sender;
- (IBAction)backImage:(id)sender;
- (IBAction)backToDetailAlbum:(id)sender;
- (IBAction)touchDownloadImage:(id)sender;


@end
