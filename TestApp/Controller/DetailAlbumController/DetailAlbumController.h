//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "FGalleryViewController.h"
#import "BaseViewController.h"

@class STSegmentedControl;

@interface DetailAlbumController : BaseViewController <FGalleryViewControllerDelegate,MNMBottomPullToRefreshManagerClient,
UIGestureRecognizerDelegate,UIWebViewDelegate>
{
    
    //pull to refress manager
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    
    //gallery
    FGalleryViewController      *gallery;
    NSMutableArray              *originalImages;
    NSMutableArray              *listItemImage;

    int indexClickImage;
    int lengthListItemImage;
    int indexPage;
    
}


@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (strong, nonatomic) IBOutlet UIView *UIviewMain;
@property (strong, nonatomic) NSString *galleryId;

@end
