//
//  SMSViewController.h
//  TestApp
//
//  Created by HHHHHH on 3/23/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ItemSMSObject.h"

@interface SMSViewController : BaseViewController
{
    ItemSMSObject *itemSMS;
}
@property (weak, nonatomic) IBOutlet UILabel *labelSendto;
@property (weak, nonatomic) IBOutlet UILabel *labelContent;

@end
