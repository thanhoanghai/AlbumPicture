//
//  SGNMenuCell.h
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlbumCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView2;

-(void)setlinkImageViewLeft:(NSString *)url size:(CGSize)size;
-(void)setlinkImageViewRight:(NSString *)url size:(CGSize)size;
@end
