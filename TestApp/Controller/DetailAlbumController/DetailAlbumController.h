//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "FGalleryViewController.h"

@class STSegmentedControl;

@interface DetailAlbumController : UIViewController <FGalleryViewControllerDelegate,MNMBottomPullToRefreshManagerClient,UIGestureRecognizerDelegate>
{
    
    //pull to refress manager
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    
    //gallery
    FGalleryViewController      *gallery;
    NSMutableArray              *originalImages;

}


@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;



@end
