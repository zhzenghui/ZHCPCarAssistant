//
//  ConsumeRecordViewController.h
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsumeRecordViewController : UIViewController
{
//    ConsumeRecordI
    NSMutableArray *_consumeRecordArray;
    NSMutableDictionary *_carDict;
    
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIView *oneView;
@property (retain, nonatomic) IBOutlet UIView *twoView;
@property (retain, nonatomic) IBOutlet UIView *addView;

@property (retain, nonatomic) IBOutlet UITextField *carNumTextField;
@property (retain, nonatomic) IBOutlet UITextField *carModelTextField;
@property (retain, nonatomic) IBOutlet UITextField *payTimeTextField;
@property (retain, nonatomic) IBOutlet UITextField *currentMilageTextField;

- (IBAction)openTwo:(id)sender;
- (IBAction)saveCarInfo:(id)sender;
@end
