//
//  CPViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"


@interface CPViewController : BaseViewController
{
    UIButton *preButton;
    UIView *_headView;
    int preTag;
}
- (IBAction)menuTap:(id)sender;

@end