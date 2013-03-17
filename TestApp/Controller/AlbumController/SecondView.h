//
//  SecondView.h
//  TestApp


#import <UIKit/UIKit.h>

@interface SecondView : UIViewController
{
    NSInteger selectedButton;
}

@property (nonatomic) NSInteger selectedButton;
@property (nonatomic, weak) IBOutlet UILabel *outputlabel;

@end
