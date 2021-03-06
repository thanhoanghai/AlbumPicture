//
//  SGNMenuCell.m
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailAlbumCell.h"
#import "UIImageView+AFNetworking.h"

#define COLOR_MENU_CELL_SELECTED [UIColor colorWithRed:0.15 green:0.17 blue:0.23 alpha:1]
@implementation DetailAlbumCell

@synthesize iconImageView = _iconImageView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"DetailAlbumCell" owner:self options:nil] lastObject];
    
    if (self) 
    {
        UIImageView *cellSelectedBackground = [[UIImageView alloc] init];
        cellSelectedBackground.backgroundColor = COLOR_MENU_CELL_SELECTED;       
        self.selectedBackgroundView = cellSelectedBackground;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setlinkImageViewLeft:(NSString *)url size:(CGSize)size
{
    if(url != nil)
        [self.iconImageView setImageWithURL:[[NSURL alloc] initWithString:url] withSize:size placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
}
-(void)setlinkImageViewRight:(NSString *)url size:(CGSize)size
{
    if(url != nil)
        [self.iconImageView2 setImageWithURL:[[NSURL alloc] initWithString:url] withSize:size placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
}


@end
