//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"

@class STSegmentedControl;

@interface AlbumViewController : BaseViewController <UIPickerViewDelegate, UIPickerViewDataSource,MNMBottomPullToRefreshManagerClient,UIWebViewDelegate>
{
    NSInteger selectedButton;
    STSegmentedControl *segment;
    
    
    /// * Pull to refresh manager
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    
    ///picker
    NSMutableArray *arrayListCategoriesPicker;
    NSInteger indexPicker;
    
        
    NSMutableArray *listAlbumObject;
    int indexPage;

}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *viewContentPicker;
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (nonatomic,retain) STSegmentedControl *segment;

- (IBAction)touchUpInsideButtonDonePicker:(id)sender;
- (void)showTypeAlbum:(BOOL) abc;


@end
