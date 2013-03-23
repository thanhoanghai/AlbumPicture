//
//  SMSViewController.m
//  TestApp
//
//  Created by HHHHHH on 3/23/13.
//  Copyright (c) 2013 SiJack Software Ltd. All rights reserved.
//

#import "SMSViewController.h"
#import "EncodeMd5.h"
#import "LRURLs.h"

@interface SMSViewController ()

@end

@implementation SMSViewController
@synthesize labelContent;
@synthesize labelSendto;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self showHUDWithString];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getDataSmsFromServer];
        [self hideHUD];
    });

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//GET DATA SMS FROM SERVER
-(void)getDataSmsFromServer
{
    NSString *speedLabel = [[NSString alloc] initWithFormat:@"infosget_smsinf1@i@s"];
    NSString *hashedString = [EncodeMd5 getLinkKeyEndcode:LINK_REQUEST_SMS withKey:speedLabel];
    NSLog(@"%@", hashedString);
    
    NSData *jsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:hashedString]];
    if(jsonData)
    {
        NSError *error = nil;
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"error is %@", [error localizedDescription]);
            return;
        }        
        itemSMS = [ItemSMSObject itemWithDictionary:jsonObjects];
        labelContent.text = itemSMS.content;
        labelSendto.text = itemSMS.service;
    }
}


- (void)viewDidUnload {
    [self setLabelSendto:nil];
    [self setLabelContent:nil];
    [super viewDidUnload];
}
@end
