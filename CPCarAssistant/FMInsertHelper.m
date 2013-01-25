//
//  FBInsertHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//




#import "FMInsertHelper.h"
#import "FMDatabase.h"

@implementation FMInsertHelper



static FMDatabase *db;

+ (FMInsertHelper *)insertHelper:(DBTypeName)dbTypeName
{
    FMInsertHelper *fbInsertHelper = [[[FMInsertHelper alloc] init] autorelease] ;
    db = [FMDBHelper databaseWithName:dbTypeName];
    return fbInsertHelper;
}

- (NSString *)sql :(NSDictionary *)itemDict :(DBTableName)tableName;
{

    NSMutableString *sql = [NSMutableString string];
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
        default:
            break;
    }
    
    return sql;
}

- (void)insert:(NSDictionary *)itemDict :(DBTableName)tableName;
{
    
    
    NSString * sql = [self sql:itemDict :tableName];
    
    BOOL res = [db executeUpdate:sql];
    if (!res) {
        debugLog(@"error to insert data");
    } else {
        debugLog(@"succ to insert data");
    }
}

- (void)insertData:(NSArray *)itemArray :(DBTableName)tableName;
{
    if ([db open]) {

        for (NSDictionary *itemDict in itemArray) {
            
            [self insert:itemDict:tableName];
        }
        [db close];
    }
    else {
        debugLog(@"error to db not open");
    }
}

@end
