//
//  SecondView.m
//  TestApp


#import "DetailAlbumController.h"
#import "STSegmentedControl.h"
#import "DetailAlbumCell.h"



@implementation DetailAlbumController
@synthesize tabbleViewAlbum;


#define IMAGE_W 130
#define IMAGE_H 170
#define IMAGE_SIZE (79.0 * [UIScreen mainScreen].scale)

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
       
    //pull to loadview
    reloads_ = -1;
    pullToRefreshManager_ = [[MNMBottomPullToRefreshManager alloc] initWithPullToRefreshViewHeight:60.0f tableView:tabbleViewAlbum withClient:self];
    
    
    //gallery define
    gallery = [[FGalleryViewController alloc] initWithPhotoSource:self];

    originalImages = [[NSMutableArray alloc]init];
    [originalImages addObject:@"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSHSZKWpTX6509BBTDPOfFjxY6BPYxK-hxINX6baRjEoAu35HdaCA"];
    [originalImages addObject:@"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSWXWCd6nWedy3ImzLrJ9sTaL_9w5Pn7MHnwRfik80SZSGZ222N"];
    [originalImages addObject:@"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcSd4dasldsbxB2_Hrpp5T-gG9UH_eLCKZGhHudEBLzWOvxt4yh3-w"];
    
    
    //SET TITLE FOR DETAIL ALBUM
    [self setTitle:@"SEXY GIRL"];
}

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
    [self setUIviewMain:nil];
    [self setTabbleViewAlbum:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Gallery
-(void)gotoGallery
{
    [self.navigationController pushViewController:gallery animated:YES];
    if(gallery.isThumbViewShowing){
        [gallery hideThumbnailViewWithAnimation:NO];
    }
    [gallery resetImageViewZoomLevels];
}
//gallery define
#pragma mark - FGalleryViewControllerDelegate implementation
- (int)numberOfPhotosForPhotoGallery:(FGalleryViewController*)gallery{
    return [originalImages count];
}
- (FGalleryPhotoSourceType)photoGallery:(FGalleryViewController*)gallery sourceTypeForPhotoAtIndex:(NSUInteger)index{
    return FGalleryPhotoSourceTypeNetwork;
}

-(NSString *)photoGallery:(FGalleryViewController *)gallery urlForPhotoSize:(FGalleryPhotoSize)size atIndex:(NSUInteger)index{
    return [originalImages objectAtIndex:index];
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
    
    static NSString *CellIdentifier = @"DetailCell";
    DetailAlbumCell *cell = (DetailAlbumCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell==nil){
        cell = [[DetailAlbumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DetailCell"];
    }
        
    [cell setlinkImageViewLeft:[originalImages objectAtIndex:(indexPath.row%3)]
     size:CGSizeMake(IMAGE_W, IMAGE_H)];
    [cell setlinkImageViewRight:[originalImages objectAtIndex:((indexPath.row+2)%3)]
                          size:CGSizeMake(IMAGE_W   , IMAGE_H)];

    
    [self setShadowForImage:cell.iconImageView];
    [self setShadowForImage:cell.iconImageView2];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5 + (5 * reloads_);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //[self gotoGallery];
        [self performSegueWithIdentifier:@"pushToViewFullImage" sender:[self.tabbleViewAlbum cellForRowAtIndexPath:indexPath]];
        
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
