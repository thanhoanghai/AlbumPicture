//
//  Tab1_GreenScreenViewController.h
//  Demo
//
//  Created on 18/10/2011.
//  Copyright (c) 2011 MaybeLost.com - All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MNMBottomPullToRefreshManager.h"


@class STSegmentedControl;


@interface AlbumViewController : BaseViewController
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, MNMBottomPullToRefreshManagerClient> 
{
      STSegmentedControl *segment;
    
    /**
     * Pull to refresh manager
     */
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    
    /**
     * Reloads (for testing purposes)
     */
    NSUInteger reloads_;
        

}
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;
@property (nonatomic,retain) STSegmentedControl *segment;
@end
