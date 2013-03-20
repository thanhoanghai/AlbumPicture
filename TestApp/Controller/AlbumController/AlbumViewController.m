//
//  SecondView.m
//  TestApp

#import <QuartzCore/QuartzCore.h>
#import "AlbumViewController.h"
#import "STSegmentedControl.h"
#import "AlbumCell.h"
#import "MBProgressHUD.h"
#import "LRRequestHelper.h"
#import "LRURLs.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "EncodeMd5.h"

@implementation AlbumViewController
@synthesize segment;
@synthesize tabbleViewAlbum;
@synthesize pickerView;
@synthesize viewContentPicker;

#define IMAGE_W 106
#define IMAGE_H 85
#define IMAGE_SIZE (79.0 * [UIScreen mainScreen].scale)

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    /*
	 STSegmentedControl
	 */
    NSArray *objects =
    [NSArray arrayWithObjects:@"Album", @"Moi nhat", @"Hot nhat", @"Top", nil];
	segment = [[STSegmentedControl alloc] initWithItems:objects];
	segment.frame = CGRectMake(0, 0, 320, 40);
	[segment addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
	segment.selectedSegmentIndex = 1;
	segment.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self.view addSubview:segment];
    
    
    //pull to loadview
    reloads_ = -1;
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:tabbleViewAlbum withClient:self];
    
    //default View picker
    viewContentPicker.hidden = YES;
    indexPicker = 0;
    arrayListPicker = [[NSMutableArray alloc] initWithObjects:
                   @"Sexy girl",
                   @"Wind",
                   @"Noen",
                   @"Spring",
                   @"Champion",
                   @"Football",
                   @"Picnic",
                   nil];
    
    
    //REQUEST HELPER
//    [self showHUDWithString];
//    [LRRequestHelper loadLink:LINK_REQUEST_ALBUM success:^(id result){
//        {
//            NSLog(@"%@",result);
//            [self hideHUD];
//        }
//    } failure:^(NSString *err){
//        NSLog(@"Errororororororo %@",err);
//    }];

    NSString *speedLabel = [[NSString alloc] initWithFormat:@"galleriesget_pics1@i@s"];
    NSString *hashedString = [EncodeMd5 getLinkKeyEndcode:LINK_REQUEST_ALBUM withKey:speedLabel];
    NSLog(@"%@", hashedString);
    
    
    NSURL *url = [[NSURL alloc] initWithString:hashedString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@", JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
    
    //ADD CUSTOM TOP RIGHT BUTTON
    [self addbntRigtCustom:3];
    bntRight3.enabled = false;
    [self addBntLeftIconApp];
    
}

/*
 STSegmentedControl
 */
- (void)valueChanged:(id)sender {
	STSegmentedControl *control = sender;
	NSLog(@"ST Index: %i", control.selectedSegmentIndex);
    if(control.selectedSegmentIndex == 0)
        bntRight3.enabled = true;
    else
        bntRight3.enabled = false;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self loadTable];
}



- (void)viewDidUnload
{
    [self setTabbleViewAlbum:nil];
    [self setViewContentPicker:nil];
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark Action-TopButtonNavigation
-(void) actionIconTypeAlbum:(id)sender
{
    [self showTypeAlbum:NO];
}
-(void) actionIconApp:(id)sender
{
    
}

#pragma mark PickerView
#pragma mark - Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    indexPicker = row;
    //[pickerView reloadComponent:0];
    NSLog(@"indexpicker = %d", indexPicker);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	return [arrayListPicker count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [arrayListPicker objectAtIndex:row];
}

- (IBAction)touchUpInsideButtonDonePicker:(id)sender {
    viewContentPicker.hidden = YES;
}

- (void)showTypeAlbum:(BOOL) abc {
    viewContentPicker.hidden = abc;
}



#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showAlbumDetail"]) {
        //NSIndexPath *indexPath = [self.tabbleViewAlbum indexPathForSelectedRow];
//        DetailAlbumViewController *destViewController = segue.destinationViewController;
//        destViewController.recipeName = @"Hello";
    }
}

#pragma mark -
#pragma mark Aux view methods

/*
 * Loads the table
 */
- (void)loadTable {
    
    reloads_++;
    
    [tabbleViewAlbum reloadData];
    
    [pullToRefreshManager_ tableViewReloadFinished];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    [pullToRefreshManager_ relocatePullToRefreshView];
}
#pragma mark - UI
-(void)setShadowForImage:(UIImageView*)img
{
    img.layer.shadowColor = [UIColor blackColor].CGColor;
    img.layer.shadowOpacity = 1.0f;
    img.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    img.layer.shadowRadius = 2.0f;
    img.layer.masksToBounds = NO;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:img.bounds];
    img.layer.shadowPath = path.CGPath;
   
}

#pragma mark -
#pragma mark UITableView methods


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //CUSTOME CELL
    static NSString *CellIdentifier = @"AlbumCell";
    AlbumCell *cell = (AlbumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[AlbumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AlbumCell"];
    }
    
    [cell setlinkImage:@"http://t3.gstatic.com/images?q=tbn:ANd9GcQIz6wCv3vKTJRnmrnG6q-N387pROv1av3yywpg6jAxgkMBZ84oFA"
                  size:CGSizeMake(IMAGE_W, IMAGE_H)];
        
    
    //SHADOW FOR IMAGE
    [self setShadowForImage:cell.iconImageView];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 + (5 * reloads_);
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self performSegueWithIdentifier:@"showAlbumDetail" sender:sender];
    [self performSegueWithIdentifier:@"showAlbumDetail" sender:[self.tabbleViewAlbum cellForRowAtIndexPath:indexPath]];
    
    
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [pullToRefreshManager_ tableViewScrolled];
}

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewReleased]
 *
 * Tells the delegate when dragging ended in the scroll view.
 *
 * @param scrollView: The scroll-view object that finished scrolling the content view.
 * @param decelerate: YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation.
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [pullToRefreshManager_ tableViewReleased];
}

/**
 * Tells client that refresh has been triggered
 * After reloading is completed must call [MNMBottomPullToRefreshManager tableViewReloadFinished]
 *
 * @param manager PTR manager
 */
- (void)bottomPullToRefreshTriggered:(MNMBottomPullToRefreshManager *)manager {
    
    [self performSelector:@selector(loadTable) withObject:nil afterDelay:1.0f];
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
