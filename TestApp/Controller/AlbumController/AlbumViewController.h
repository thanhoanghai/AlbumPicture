//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"

@class STSegmentedControl;

@interface AlbumViewController : UIViewController
{
    NSInteger selectedButton;
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

@property (nonatomic) NSInteger selectedButton;
@property (nonatomic, weak) IBOutlet UILabel *outputlabel;
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;
@property (nonatomic,retain) STSegmentedControl *segment;


@end
