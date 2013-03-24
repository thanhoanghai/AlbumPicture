//
//  ViewFullImageController.h
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFullImageController : UIViewController <UIScrollViewDelegate>
{
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewAds;

@property (strong, nonatomic) NSMutableArray *listItemImageFull;
@property(nonatomic, assign) int indexImage;

- (IBAction)backToDetailAlbumView:(id)sender;
- (IBAction)nextImage:(id)sender;
- (IBAction)backImage:(id)sender;
- (IBAction)downloadAlbumImage:(id)sender;

@end
