//
//  SecondView.m
//  TestApp


#import "AlbumViewController.h"
#import "STSegmentedControl.h"
#import "AlbumCell.h"



@implementation AlbumViewController
@synthesize segment;
@synthesize tabbleViewAlbum;
@synthesize pickerView;
@synthesize viewContentPicker;


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

    
}

/*
 STSegmentedControl
 */
- (void)valueChanged:(id)sender {
	STSegmentedControl *control = sender;
	NSLog(@"ST Index: %i", control.selectedSegmentIndex);
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

- (IBAction)showTypeAlbum:(id)sender {
    viewContentPicker.hidden = NO;
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
#pragma mark -
#pragma mark UITableView methods

/**
 * Asks the data source to return the number of sections in the table view
 *
 * @param An object representing the table view requesting this information.
 * @return The number of sections in tableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

/**
 * Asks the data source for a cell to insert in a particular location of the table view
 *
 * @param tableView: A table-view object requesting the cell.
 * @param indexPath: An index path locating a row in tableView.
 * @return An object inheriting from UITableViewCellthat the table view can use for the specified row.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AlbumCell";
    AlbumCell *cell = (AlbumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if(cell==nil){
        cell = [[AlbumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"AlbumCell"];
    }
    
    [cell setlinkImage:@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTZmCoTsuOs-03ZElCvRKCMQOvBMVWGMFFJaRGY_uMsjFdjoT9n"
                  size:CGSizeMake(IMAGE_SIZE, IMAGE_SIZE)];
    
    
	
    //	if (result == nil) {
    //
    //        result = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //        result.selectionStyle = UITableViewCellSelectionStyleNone;
    //        result.textLabel.backgroundColor = [UIColor clearColor];
    //    }
    //
    //    result.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];
    //    UIView *backgroundView = [[UIView alloc] initWithFrame:result.frame];
    //
    //    if (indexPath.row % 2 == 0) {
    //        backgroundView.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    //    } else {
    //        backgroundView.backgroundColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    }
    //    result.backgroundView = backgroundView;
    return cell;
}

/**
 * Tells the data source to return the number of rows in a given section of a table view
 *
 * @param tableView: The table-view object requesting this information.
 * @param section: An index number identifying a section in tableView.
 * @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 + (5 * reloads_);
}

/**
 * Asks the delegate for the height to use for a row in a specified location.
 *
 * @param The table-view object requesting this information.
 * @param indexPath: An index path that locates a row in tableView.
 * @return A floating-point value that specifies the height (in points) that row should be.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self performSegueWithIdentifier:@"showAlbumDetail" sender:sender];
    [self performSegueWithIdentifier:@"showAlbumDetail" sender:[self.tabbleViewAlbum cellForRowAtIndexPath:indexPath]];
    
    
}

#pragma mark -
#pragma mark MNMBottomPullToRefreshManagerClient

/**
 * This is the same delegate method as UIScrollView but required in MNMBottomPullToRefreshManagerClient protocol
 * to warn about its implementation. Here you have to call [MNMBottomPullToRefreshManager tableViewScrolled]
 *
 * Tells the delegate when the user scrolls the content view within the receiver.
 *
 * @param scrollView: The scroll-view object in which the scrolling occurred.
 */
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




@end
