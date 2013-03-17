//
//  SecondView.m
//  TestApp


#import "SecondView.h"

@implementation SecondView

@synthesize selectedButton, outputlabel;

- (void)viewDidLoad
{
    [outputlabel setText:[NSString stringWithFormat:@"Your button was %d", selectedButton]];
}

@end
