//
//  ViewController.m
//  TestApp


#import "ViewController.h"
#import "AlbumViewController.h"

@implementation ViewController
@synthesize uiImageView;

-(void)viewDidLoad
{
    [super viewDidLoad];
    //[self createNavigationBarButton];
    [self addbntRigtCustom:1];
    [self addBntLeftIconApp];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    sleep(2);
    [self performSegueWithIdentifier:@"MySegue" sender:self];

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

- (void)viewDidUnload {
    [self setUiImageView:nil];
    [super viewDidUnload];
}
@end
