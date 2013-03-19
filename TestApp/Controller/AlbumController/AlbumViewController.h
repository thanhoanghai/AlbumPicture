//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"

@class STSegmentedControl;

@interface AlbumViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource ,UIGestureRecognizerDelegate,MNMBottomPullToRefreshManagerClient>
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
    
    ///picker
    NSMutableArray *arrayListPicker;
    NSInteger indexPicker;
    
    //hub loading
    MBProgressHUD *HUD;


}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *viewContentPicker;
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (nonatomic,retain) STSegmentedControl *segment;

- (IBAction)touchUpInsideButtonDonePicker:(id)sender;
- (IBAction)showTypeAlbum:(id)sender;
//hub loading
- (void)showHUDWithString;
- (void)hideHUD;


@end
