//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "FGalleryViewController.h"
#import "BaseViewController.h"

@class STSegmentedControl;

@interface DetailAlbumController : BaseViewController <FGalleryViewControllerDelegate,MNMBottomPullToRefreshManagerClient,UIGestureRecognizerDelegate>
{
    
    //pull to refress manager
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    
    //gallery
    FGalleryViewController      *gallery;
    NSMutableArray              *originalImages;
    NSMutableArray              *listItemImage;

    int lengthListItemImage;
    

}


@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;
@property (strong, nonatomic) NSString *galleryId;

@end
