//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "FGalleryViewController.h"

@class STSegmentedControl;

@interface DetailAlbumController : UIViewController <FGalleryViewControllerDelegate>
{
    NSInteger selectedButton;
    /**
     * Pull to refresh manager
     */
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    
    /**
     * Reloads (for testing purposes)
     */
    NSUInteger reloads_;
    //gallery
    FGalleryViewController      *gallery;
    NSMutableArray              *originalImages;

}


@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;



@end
