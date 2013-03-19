//
//  SGNMenuCell.m
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AlbumCell.h"
#import "UIImageView+AFNetworking.h"

#define COLOR_MENU_CELL_SELECTED [UIColor colorWithRed:0.15 green:0.17 blue:0.23 alpha:1]
@implementation AlbumCell

@synthesize iconImageView = _iconImageView;
@synthesize contentLabel = _contentLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"AlbumCell" owner:self options:nil] lastObject];
    
    if (self) 
    {
// Initialization code
//        UIImageView *cellBackground = [[UIImageView alloc] init];
//        cellBackground.image = [UIImage imageNamed:@"bg_slide_nav.png"];
//        self.backgroundView = cellBackground;
//
        UIImageView *cellSelectedBackground = [[UIImageView alloc] init];
        cellSelectedBackground.backgroundColor = COLOR_MENU_CELL_SELECTED;
        //cellSelectedBackground.image = [UIImage imageNamed:@"bg_transparent"];
        self.selectedBackgroundView = cellSelectedBackground;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setlinkImage:(NSString *)url size:(CGSize)size
{
    if(url != nil)
        [self.iconImageView setImageWithURL:[[NSURL alloc] initWithString:url] withSize:size placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
}


@end
