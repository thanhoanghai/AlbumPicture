//
//  BaseViewController.m
//  Demo
//
//  Created by Than Hoang Hai on 3/16/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self setTitle:@""];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self addLeftRightCustomButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addBntLeftIconApp
{
    //create a toolbar to have two buttons in the right
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 160, 44.01)];
    
    // create the array to hold the buttons, which then gets added to the toolbar
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    
//    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
//    customView.frame = CGRectMake(0, 0, 35, 30);
//    [customView setImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateNormal];
//    [customView setImage:[UIImage imageNamed:@"home_icon"] forState:UIControlStateHighlighted];
//    [customView addTarget:self action:@selector(actionIconApp) forControlEvents:UIControlEventTouchUpInside];
//    bntLeft1 = [[UIBarButtonItem alloc] initWithCustomView:customView];
    // create a standard “compose” button
    bntLeft1 = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(actionIconApp:)];
    bntLeft1.style = UIBarButtonItemStyleBordered;
    [buttons addObject:bntLeft1];
        
    // create a spacer
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:bi];

    
    // stick the buttons in the toolbar
    [tools setItems:buttons animated:NO];
    
    // and put the toolbar in the nav bar
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
}


-(void)addbntRigtCustom:(int)numbnt
{
    //create a toolbar to have two buttons in the right    
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 160, 44.01)];
    
    // create the array to hold the buttons, which then gets added to the toolbar
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:6];
    
    // create a spacer    
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]                           
                           initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];    
    [buttons addObject:bi];
    
    
    if(numbnt >= 3)
    {
        // create a standard “compose” button
        bntRight3 = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(actionIconTypeAlbum:)];
        bntRight3.style = UIBarButtonItemStyleBordered;
        [buttons addObject:bntRight3];
        
        // create a spacer
        bi = [[UIBarButtonItem alloc]
              initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [buttons addObject:bi];

    }
    if(numbnt >= 2)
    {
        // create a standard “refresh” button
        bntRight2 = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(actionIconRefress:)];
        bntRight2.style = UIBarButtonItemStyleBordered;
        [buttons addObject:bntRight2];
        
        
        // create a spacer
        bi = [[UIBarButtonItem alloc]
              initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        [buttons addObject:bi];

    }
    if(numbnt >=1 )
    {
        // create a standard “add” button
        bntRight1 = [[UIBarButtonItem alloc]
                     initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(actionIconAccount:)];
        bntRight1.style = UIBarButtonItemStyleBordered;
        [buttons addObject:bntRight1];

    }
          
    // stick the buttons in the toolbar    
    [tools setItems:buttons animated:NO];
        
    // and put the toolbar in the nav bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
}

-(void) addLeftRightCustomButton
{
    ///custome right button Finish
    UIBarButtonItem * bntRightCustom;
    UIButton *customView = [UIButton buttonWithType:UIButtonTypeCustom];
    customView.frame = CGRectMake(0, 0, 50, 30);
    [customView setImage:[UIImage imageNamed:@"bnt_account"] forState:UIControlStateNormal];
    [customView setImage:[UIImage imageNamed:@"bnt_account_hightlight"] forState:UIControlStateHighlighted];
    [customView addTarget:self action:@selector(actionIconApp) forControlEvents:UIControlEventTouchUpInside];
    bntRightCustom = [[UIBarButtonItem alloc] initWithCustomView:customView];
    //self.navigationItem.rightBarButtonItem = bntRightCustom;
    
    ///custom left button Sign Out
    UIBarButtonItem * bntLeftCustom;
    UIButton *cusView = [UIButton buttonWithType:UIButtonTypeCustom];
    cusView.frame = CGRectMake(0, 0, 50, 30);
    [cusView setImage:[UIImage imageNamed:@"bnt_account"] forState:UIControlStateNormal];
    [cusView setImage:[UIImage imageNamed:@"bnt_account_hightlight"] forState:UIControlStateHighlighted];
    [cusView addTarget:self action:@selector(actionIconAccount) forControlEvents:UIControlEventTouchUpInside];
    bntLeftCustom = [[UIBarButtonItem alloc] initWithCustomView:cusView];
    //self.navigationItem.leftBarButtonItem = bntLeftCustom;
    
    NSMutableArray *listButton = [NSMutableArray arrayWithObjects:bntLeftCustom,bntRightCustom,nil];//[[NSArray alloc] arra:bntLeftCustom, bntRightCustom, nil] ;
    //self.navigationItem.leftBarButtonItem = listButton;

    
}
-(void) actionIconApp:(id)sender
{
}
-(void) actionIconTypeAlbum:(id)sender
{
}
-(void) actionIconRefress:(id)sender
{
}
-(void) actionIconAccount:(id)sender
{
}

#pragma mark HUD_LOADING
- (void)showHUDWithString{
    
    if(HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [[self view] addSubview:HUD];
        
        HUD.dimBackground = YES;
        HUD.labelText = @"LOADING ... ";
    }
    [HUD show:YES];
}
- (void)hideHUD{
    if(HUD != nil){
        [HUD hide:YES];
    }
}



@end
