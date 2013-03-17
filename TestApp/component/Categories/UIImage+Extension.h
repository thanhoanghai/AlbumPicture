//
//  UIImage+Extension.h
//  BETAward
//
//  Created by Duc Ngo on 2/27/12.
//  Copyright (c) 2012 Chaotic Moon Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Extension)
- (UIImage *) changeBackgroundColorToColor:(UIColor*)color;
- (UIImage *)crop:(CGRect)rect;
- (UIImage*)scaleToSize:(CGSize)size;
- (UIImage*) imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
