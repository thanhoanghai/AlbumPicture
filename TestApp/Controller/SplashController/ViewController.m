//
//  ViewController.m
//  TestApp


#import "ViewController.h"
#import "SecondView.h"

@implementation ViewController


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
