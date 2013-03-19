//
//  BaseViewController.h
//  Demo
//
//  Created by Than Hoang Hai on 3/16/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{
    UIBarButtonItem *bntRight1;
    UIBarButtonItem *bntRight2;
    UIBarButtonItem *bntRight3;
    
    UIBarButtonItem *bntLeft1;
    
    
    
}
-(void)addBntLeftIconApp;
-(void) actionIconApp:(id)sender;

-(void)addbntRigtCustom:(int)numbnt;
-(void) actionIconTypeAlbum:(id)sender;
-(void) actionIconRefress:(id)sender;
-(void) actionIconAccount:(id)sender;

@end
