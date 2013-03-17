//
//  UIView+HiddenTableText.m
//  LondonRemember
//
//  Created by tran vuong kha on 10/3/12.
//  Copyright (c) 2012 tpl. All rights reserved.
//

#import "UIView+HiddenTableText.h"

@implementation UIView (HiddenTableText)
- (UIView*)initWithFrame:(CGRect)frame andText:(NSString *)text{
    UIView* nomatchesView = [[UIView alloc] initWithFrame:frame];
    nomatchesView.backgroundColor = [UIColor clearColor];
    
    UILabel *matchesLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,320,320)];
    matchesLabel.font = [UIFont boldSystemFontOfSize:18];
    matchesLabel.minimumFontSize = 12.0f;
    matchesLabel.numberOfLines = 1;
    matchesLabel.lineBreakMode = UILineBreakModeWordWrap;
    matchesLabel.shadowColor = [UIColor lightTextColor];
    matchesLabel.textColor = [UIColor darkGrayColor];
    matchesLabel.shadowOffset = CGSizeMake(0, 1);
    matchesLabel.backgroundColor = [UIColor clearColor];
    matchesLabel.textAlignment =  UITextAlignmentCenter;
    
    //Here is the text for when there are no results
    matchesLabel.text = text;
    
    
    nomatchesView.hidden = YES;
    [nomatchesView addSubview:matchesLabel];
    
    return nomatchesView;
}
@end
