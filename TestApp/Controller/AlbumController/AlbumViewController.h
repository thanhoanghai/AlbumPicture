//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>
#import "MNMBottomPullToRefreshManager.h"
#import "MBProgressHUD.h"
#import "BaseViewController.h"

@class STSegmentedControl;

@interface AlbumViewController : BaseViewController <UIPickerViewDelegate, UIPickerViewDataSource,MNMBottomPullToRefreshManagerClient>
{
    NSInteger selectedButton;
    STSegmentedControl *segment;
    
    
    /// * Pull to refresh manager
    MNMBottomPullToRefreshManager *pullToRefreshManager_;
    NSUInteger reloads_;
    
    ///picker
    NSMutableArray *arrayListPicker;
    NSInteger indexPicker;
    
    //hub loading
    MBProgressHUD *HUD;
    
    NSMutableArray *listAlbumObject;

}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UIView *viewContentPicker;
@property (strong, nonatomic) IBOutlet UITableView *tabbleViewAlbum;
@property (nonatomic,retain) STSegmentedControl *segment;

- (IBAction)touchUpInsideButtonDonePicker:(id)sender;
- (void)showTypeAlbum:(BOOL) abc;
//hub loading
- (void)showHUDWithString;
- (void)hideHUD;


@end
