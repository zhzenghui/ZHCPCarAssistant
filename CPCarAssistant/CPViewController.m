//
//  CPViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#import "CPViewController.h"
//#import "UINavigationBarCategory.h"
#define Klogo 11

@implementation CPViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - customer method

- (void)setButtonImage
{
    NSString *imageStr = [NSString stringWithFormat:@"index_menu_%d_0", preTag-10];
    UIImage *image= [UIImage imageNamed:imageStr];
    
    [preButton setImage:image forState:UIControlStateNormal];
    

}

- (IBAction)menuTap:(id)sender 
{
    [self setButtonImage];

    
    [_headView setHidden:YES];

    UIButton *button = (UIButton *)sender;    

    preTag = button.tag;
    preButton = button;
    
    
    NSString *imageStr = [NSString stringWithFormat:@"index_menu_%d_1", button.tag-10];
    UIImage *image= [UIImage imageNamed:imageStr];
    
    [button setImage:image forState:UIControlStateNormal];

    
    UIViewController *viewController = nil; 
    

    
    switch (  button.tag ) {
        case KMENU_BUTTON_Activity:
        {
            viewController = [[ActivityViewController alloc] init];
            break;
        }               
        case KMENU_BUTTON_AutoModel:
        {
            viewController = [[AutoModelViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_Dealer_Boutique:
        {
            viewController = [[Dealer_BoutiqueViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_MessageView:
        {
            viewController = [[MessageViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_OriginalFittings:
        {
            viewController = [[OriginalFittingsViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_OwnersFAQView:
        {
            viewController = [[OwnersFAQViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_SysSetting:
        {
            viewController = [[SysSettingViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_TestDrive_Preserver:
        {
            viewController = [[TestDrive_PreserverViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_ViolateView:
        {
            viewController = [[ViolateViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_Gas_StopsView:
        {
            viewController = [[Gas_StopsViewController alloc] init];
            break;
        }
        case KMENU_BUTTON_ConsumeRecordView:
        {
            viewController = [[ConsumeRecordViewController alloc] init];
            break;
        }
            
        default:
            break;
    }
    

    [self.navigationController pushViewController:viewController animated:YES];
    
    [viewController release];

}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"汽车助手";
    

    
    UIImage *headImage = [UIImage imageNamed:@"logo"];

    CGRect rect = CGRectMake((320-100- headImage.size.width)/2, 3, headImage.size.width, headImage.size.height);
    
    UIView *headView = [[UIView alloc] initWithFrame:rect];
    headView.backgroundColor = [UIColor clearColor];
    
    _headView = headView;
    
    UIImageView *headImageView = [[UIImageView alloc] initWithImage:headImage];
    headImageView.frame = rect;
    [headView addSubview:headImageView];
        
    [headImageView release];

    self.navigationItem.titleView = headView;
    

}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_headView setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    
    [super dealloc];
}
@end
