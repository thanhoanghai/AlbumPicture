//
//  SecondView.m
//  TestApp


#import "DetailAlbumController.h"
#import "STSegmentedControl.h"
#import "DetailAlbumCell.h"
#import "EncodeMd5.h"
#import "LRURLs.h"
#import "ItemImageObject.h"



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
    [originalImages addObject:@"http://t2.gstatic.com/images?q=tbn:ANd9GcRerek_2gJSHlHyjuWu2ZFmpW1_-oEonQHsb4qr4invwdDgaHKH"];
    [originalImages addObject:@"http://t3.gstatic.com/images?q=tbn:ANd9GcQfDS4SlFz7_Bh1jOlbPTVl1DYUcr8Ip8VnfabG7vdq2Nky66aT"];
    
    //GET DATA ALBUM OBJECT FROM SERVER
    listItemImage = [[NSMutableArray alloc] init ];
    [self showHUDWithString];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getDataPictureFromServer];
        [self hideHUD];
    });

    
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
#pragma mark getDataFromServer-Json

-(void)getDataPictureFromServer
{
    NSString *speedLabel = [[NSString alloc] initWithFormat:@"galleriesget_pics1@i@s"];
    NSString *linkPicture = [EncodeMd5 getLinkRequestPicture:@"88" withPage:1 withKey:speedLabel];
    //NSString *hashedString = [EncodeMd5 getLinkKeyEndcode:LINK_REQUEST_PICTURE withKey:speedLabel];
    NSLog(@"%@", linkPicture);
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:linkPicture]];
    if(jsonData)
    {
        NSError *error = nil;
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"error is %@", [error localizedDescription]);
            return;
        }
        NSDictionary *keys = [jsonObjects objectForKey:@"Pictures"];
        // values in foreach loop
        if([keys count] > 0 )
            for (NSDictionary *key in keys) {
                [listItemImage addObject: [ItemImageObject itemWithDictionary:key ]];
            }
        lengthListItemImage = [listItemImage count];
        [tabbleViewAlbum reloadData];
        [pullToRefreshManager_ relocatePullToRefreshView];
    }else
        NSLog(@"no data json");
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
    ItemImageObject *item;
    
//SET DATA IMAGEVIEW LEFT
    if( indexPath.row*2 < lengthListItemImage)
    {        
        item = [listItemImage objectAtIndex:indexPath.row];
        [cell setlinkImageViewLeft:item.thumb
                              size:CGSizeMake(IMAGE_W, IMAGE_H)];
        cell.iconImageView.tag = indexPath.row*2;
        //ADD GESTURE FOR IMAGE IN CELL
        cell.iconImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(ClickEventOnImage:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [tapRecognizer setDelegate:self];
        [cell.iconImageView addGestureRecognizer:tapRecognizer];
        [self setShadowForImage:cell.iconImageView];

    }
    

    
//SET DATA IMAGEVIEW RIGHT
    if( (indexPath.row*2 + 1) < lengthListItemImage)
    {
        cell.iconImageView2.hidden = NO;
        item = [listItemImage objectAtIndex:(indexPath.row*2+1)];
        [cell setlinkImageViewRight:item.thumb
                               size:CGSizeMake(IMAGE_W   , IMAGE_H)];
        cell.iconImageView2.tag = indexPath.row*2 + 1;
        //ADD GESTURE FOR IMAGE IN CELL
        cell.iconImageView2.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(ClickEventOnImage:)];
        [tapRecognizer2 setNumberOfTouchesRequired:1];
        [tapRecognizer2 setDelegate:self];
        [cell.iconImageView2 addGestureRecognizer:tapRecognizer2];
        [self setShadowForImage:cell.iconImageView2];

    }else
        cell.iconImageView2.hidden = YES;
    
    return cell;
}
-(void) ClickEventOnImage:(id) sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    if ([tap.view isKindOfClass:[UIImageView class]]) {
        UIImageView *tapView = (UIImageView*)tap.view;
        if (!tapView.image) {
            return;
        }else
        {
            //int tag= tapView.tag;
            NSLog(@"Tag=: %d",tapView.tag);
            [self performSegueWithIdentifier:@"pushToViewFullImage" sender:self];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (lengthListItemImage/2 + lengthListItemImage%2);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    //[self gotoGallery];        
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
