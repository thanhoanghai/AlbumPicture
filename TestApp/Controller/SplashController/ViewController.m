//
//  ViewController.m
//  TestApp


#import "ViewController.h"
#import "AlbumViewController.h"

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self createNavigationBarButton];
    [self addbntRigtCustom:1];
    [self addBntLeftIconApp];
}

-(void)createNavigationBarButton
{
    UIButton *menuView = [UIButton buttonWithType:UIButtonTypeCustom] ;
    menuView.frame = CGRectMake(0, 0, 40, 30);
    [menuView setImage:[UIImage imageNamed:@"bnt_finish"] forState:UIControlStateNormal];
    [menuView setImage:[UIImage imageNamed:@"bnt_finish_hightlight"] forState:UIControlStateHighlighted];
    [menuView addTarget:self action:@selector(actionRightButton1:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithCustomView:menuView] ;

    UIButton *bntView2 = [UIButton buttonWithType:UIButtonTypeCustom] ;
    bntView2.frame = CGRectMake(0, 0, 40, 30);
    [bntView2 setImage:[UIImage imageNamed:@"bnt_finish"] forState:UIControlStateNormal];
    [bntView2 setImage:[UIImage imageNamed:@"bnt_finish_hightlight"] forState:UIControlStateHighlighted];
    [bntView2 addTarget:self action:@selector(actionRightButton1:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc] initWithCustomView:bntView2] ;
    
    NSArray *listButton = [[NSArray alloc] initWithObjects:rightButton1, rightButton2, nil] ;
    self.navigationItem.leftBarButtonItem = rightButton2;

}
-(void)actionRightButton1:(id)sender
{
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        [self performSegueWithIdentifier:@"MySegue" sender:self];
    });
   
   
}


- (IBAction)buttonPressed:(id)sender
{
    [self performSegueWithIdentifier:@"MySegue" sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MySegue"]) {
        
        // Get destination view
        //SecondView *vc = [segue destinationViewController];
        
        // Get button tag
        //NSInteger tagIndex = [(UIButton *)sender tag];
        
        // Set the selected button in the new view
        //[vc setSelectedButton:tagIndex];
    }
}

@end
