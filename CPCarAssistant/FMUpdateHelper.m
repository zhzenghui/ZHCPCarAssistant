//
//  FMUpdateHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FMUpdateHelper.h"

@implementation FMUpdateHelper

static FMDatabase *db;


- (NSString *)sql :(NSDictionary *)itemDict :(DBTableName)tableName;
{
    
    NSMutableString *sql = [NSMutableString string];
    
    for (int i =0 ; i <[[itemDict allValues] count]; i++) {
        NSLog(@"%@", [[itemDict allKeys] objectAtIndex:i]);
        NSLog(@"%@", [[itemDict allValues] objectAtIndex:i]);        
    }
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            [sql appendFormat: @"insert into ConsumeRecord (type, price, uptime) values('%@', '%@', '%@') ", 
             [itemDict objectForKey:KConsumeRecordType],
             [itemDict objectForKey:KConsumeRecordPrice],
             [itemDict objectForKey:KConsumeRecordUptime]
             ];
            break;
        }
        case DBTableNameMyCar:
        {
            [sql appendFormat: @"insert into ConsumeRecord (type, price, uptime) values('%@', '%@', '%@') ", 
             [itemDict objectForKey:KConsumeRecordType],
             [itemDict objectForKey:KConsumeRecordPrice],
             [itemDict objectForKey:KConsumeRecordUptime]
             ];
            break;
        }
        case DBTableNameMessage:
        {
            [sql appendFormat: @"insert into message (ID, Dealer, UDID, Message, Answer, IsAnswer, UpTime) values('%@', '%@', '%@', '%@', '%@', '%@', '%@') ", 
             [itemDict objectForKey:KMessageId],
             [itemDict objectForKey:KMessageDealer],
             [itemDict objectForKey:KMessageUDID],
             [itemDict objectForKey:KMessageMessage],
             [itemDict objectForKey:KMessageAnswer],
             [itemDict objectForKey:KMessageIsAnswer],
             [itemDict objectForKey:KMessageUpTime]
             ];
            break;
        }
        case DBTableNameAuto:
        {
            [sql appendFormat: @"insert into Auto (AutoID,AutoImg, IsTestDrive, MSRP,Name,  OrderNum, SeriesID) values('%@','%@', '%@', '%@','%@', '%@', '%@') ", 
             [itemDict objectForKey:KAuto_AutoID],
             [itemDict objectForKey:KAuto_AutoImg],
             [itemDict objectForKey:KAuto_IsTestDrive],
             [itemDict objectForKey:KAuto_MSRP],
             [itemDict objectForKey:KAuto_Name],
             [itemDict objectForKey:KAuto_OrderNum],
             [itemDict objectForKey:KAuto_SeriesID]
             ];
            break;
        }
        case DBTableNameAutoSeries:
        {
            [sql appendFormat: @"insert into AutoSeries (SeriesID,Name, SeriesImg, Describe, OrderNum) values('%@','%@', '%@', '%@','%@') ", 
             [itemDict objectForKey:KAutoSeries_SeriesID],
             [itemDict objectForKey:KAutoSeries_Name],
             [itemDict objectForKey:KAutoSeries_SeriesImg],
             [itemDict objectForKey:KAutoSeries_Describe],
             [itemDict objectForKey:KAutoSeries_OrderNum]
             ];
            break;
        }
        case DBTableNameImages:
        {
            
            [sql appendFormat: @"insert into Images (ImageID,AutoID, Thumbnail, ImgURL,Describe,Name,SeriesImg, OrderNum) values('%@','%@', '%@', '%@','%@', '%@','%@', '%@') ", 
             [itemDict objectForKey:KImages_ImageID],
             [itemDict objectForKey:KImages_AutoID],
             [itemDict objectForKey:KImages_Thumbnail],
             [itemDict objectForKey:KImages_ImgURL],
             [itemDict objectForKey:KImages_Describe],             
             [itemDict objectForKey:KImages_Name],
             [itemDict objectForKey:KImages_SeriesImg],
             [itemDict objectForKey:KImages_OrderNum]
             ];
            break;
        }
        default:
            break;
    }
    
    return sql;
}

- (void)update:(NSDictionary *)itemDict :(DBTableName)tableName
{
    NSString * sql = [self sql:itemDict :tableName];
    
    BOOL res = [db executeUpdate:sql];
    if (!res) {
        debugLog(@"error to insert data: %@",sql);
    } else {
        debugLog(@"succ to insert data");
    }
}
- (void)updateData:(NSArray *)itemArray :(DBTableName)tableName
{
    if ([db open]) {
        
        for (NSDictionary *itemDict in itemArray) {
            
            [self update:itemDict:tableName];
        }
        [db close];
    }
    else {
        debugLog(@"error to db not open");
    }
}

+ (FMUpdateHelper *)updateHelper:(DBTypeName)dbTypeName;
{
    FMUpdateHelper *updateHelper = [[[FMUpdateHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:dbTypeName];
    return updateHelper;
}
@end
