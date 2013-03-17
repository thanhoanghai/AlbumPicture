//
//  SGNMenuCell.h
//  custom_navigation
//
//  Created by TPL2806 on 9/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumCell : UITableViewCell

@property(nonatomic,strong) IBOutlet UIImageView *iconImageView;
@property(nonatomic,strong) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;


- (void) setlinkImage:(NSString *)url size:(CGSize)size;
@end
