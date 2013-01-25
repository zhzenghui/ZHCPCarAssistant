//
//  ConsumeRecordViewController.m
//  CPCarAssistant
//
//  Created by dong xin on 12-12-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//



#define KConsumeRecordID @"id"
#define KConsumeRecordType @"Type"
#define KConsumeRecordPrice @"Price"
#define KConsumeRecordUptime @"Uptime"

#define KSessionUserCousumeTag @"cousumeTag"

#define KCarID @"carid"
#define KCarModel @"carmodel"
#define KCarPayDateTime @"paydatetime"
#define KCarMileage @"mileage"

#import "ConsumeRecordViewController.h"
#import "FMHelper.h"

@implementation ConsumeRecordViewController
@synthesize tableView = _tableView;
@synthesize oneView = _oneView;
@synthesize twoView = _twoView;
@synthesize addView = _addView;
@synthesize carNumTextField = _carNumTextField;
@synthesize carModelTextField = _carModelTextField;
@synthesize payTimeTextField = _payTimeTextField;
@synthesize currentMilageTextField = currentMilageTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
}

//  初始化  
- (void)initData
{
    //  id  type   price   uptime
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          @"id", KConsumeRecordID,
                          @"type", KConsumeRecordType,
                          @"price", KConsumeRecordPrice,
                          @"uptime", KConsumeRecordUptime,
                          nil];
    
    NSMutableArray *consumeRecord = [[NSMutableArray alloc] init];
    NSMutableDictionary *carDict = [[NSMutableDictionary alloc] init];
    _carDict =  carDict;

    for (int i =0 ; i<10; i++) {
        [consumeRecord addObject:dict];
    }
    _consumeRecordArray =  consumeRecord;
    
    
}

//激活引导
- (void)guid
{
    [self.view addSubview:_oneView];
}


- (IBAction)openTwo:(id)sender 
{
    
    [self.view addSubview:_twoView];
}

- (void)saveCarInfomation
{
    NSLog(@"%@",  [NSString escopeString:_carNumTextField.text]);
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSString escopeString:_carNumTextField.text], KConsumeRecordType, 
                          [NSString escopeString:_carNumTextField.text], KConsumeRecordPrice, 
                          [NSString escopeString:_carNumTextField.text], KConsumeRecordUptime, 
                          nil];
    
    [[FMInsertHelper insertHelper:DBTypeNameDocument] insert:dict :DBTableNameConsumeRecord];

    [_twoView removeFromSuperview];
    [_oneView removeFromSuperview];
}

- (IBAction)saveCarInfo:(id)sender 
{
    [self saveCarInfomation];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"cousume";
    NSDictionary *userDict = [NSDictionary dictionaryWithObjectsAndKeys:@"0", KSessionUserCousumeTag, nil];
    
    if ([[userDict objectForKey:KSessionUserCousumeTag] isEqualToString:@"1"]) {
        [self initData];
    }
    else {
        [self guid];
    }
    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setOneView:nil];
    [self setTwoView:nil];
    [self setAddView:nil];
    [self setCarNumTextField:nil];
    [self setCarModelTextField:nil];
    [self setPayTimeTextField:nil];
    [self setCurrentMilageTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark -
#pragma mark UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 92;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _consumeRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
//    static NSString *CellIdentifier = @"Cell";
    
//    ActivityTableViewCell *cell = (ActivityTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ActivityTableViewCell" owner:self options:nil];
//        
//        for (id currentObject in topLevelObjects){
//            if ([currentObject isKindOfClass:[UITableViewCell class]]){
//                cell =  (ActivityTableViewCell *) currentObject;
//                break;
//            }
//        }
//    }    
	// Configure the cell.
    
    
//    cell.titleLabel.text = [[self.activityArray objectAtIndex:indexPath.row] objectForKey:KActivity_Title];
    cell.textLabel.text = [[_consumeRecordArray objectAtIndex:indexPath.row] objectForKey:KConsumeRecordPrice];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 92)] autorelease];
    headView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"policy_box"]];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (void)dealloc {
    [_tableView release];
    [_oneView release];
    [_twoView release];
    [_addView release];
    [_carNumTextField release];
    [_carModelTextField release];
    [_payTimeTextField release];
    [currentMilageTextField release];
    [super dealloc];
}

@end
