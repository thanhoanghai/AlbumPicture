//
//  ViewFullImageController.h
//  TestApp
//
//  Created by Than Hoang Hai on 3/20/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFullImageController : UIViewController <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end