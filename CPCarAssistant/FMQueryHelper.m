//
//  FMQueryHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FMQueryHelper.h"
#import "FMDatabase.h"

static FMDatabase *db;

@implementation FMQueryHelper

- (IBAction)queryData:(id)sender {
    debugMethod();
    if ([db open]) {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int userId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * pass = [rs stringForColumn:@"password"];
            debugLog(@"user id = %d, name = %@, pass = %@", userId, name, pass);
        }
        [db close];
    }
}

- (NSString *)sqlTableLastID:(DBTableName)tableName
{
    NSString * table = nil;
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            table = [NSString stringWithFormat:@"consumerecord"];;
            break;
        }
        case DBTableNameMessage:
        {
            table = [NSString stringWithFormat:@"Message"];            
            break;
        }
        case DBTableNameMyCar:
        {
            table = [NSString stringWithFormat:@"MyCar"];            
            break;
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select max(id) as id from %@", table];
    return sql;
}

- (NSString *)sqlTableDataCount:(DBTableName)tableName
{
    NSString * table = nil;
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            table = [NSString stringWithFormat:@"consumerecord"];;
            break;
        }
        case DBTableNameMessage:
        {
            table = [NSString stringWithFormat:@"Message"];            
            break;
        }
        case DBTableNameMyCar:
        {
            table = [NSString stringWithFormat:@"MyCar"];            
            break;
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"select count(id) as count from %@", table];
    return sql;
}

- (NSString *)sqlTableData:(DBTableName)tableName page:(int)pageNum pagSize:(int)pageSize
{
    NSString * table = nil;
    
    switch (tableName) {
        case DBTableNameConsumeRecord:
        {
            table = [NSString stringWithFormat:@"consumerecord"];;
            break;
        }
        case DBTableNameMessage:
        {
            table = [NSString stringWithFormat:@"Message"];            
            break;
        }
        case DBTableNameMyCar:
        {
            table = [NSString stringWithFormat:@"MyCar"];            
            break;
        }
        default:
            break;
    }
    
    NSString *sql = [NSString stringWithFormat:@"Select * From %@ Order By ID desc Limit %d Offset %d;", table, pageSize, pageNum*pageSize];
    return sql;
}




- (int)queryLastID:(DBTableName)tableName
{    
    int uid ;
    if ([db open]) {
        NSString * sql = [self sqlTableLastID:tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            uid = [rs intForColumn:@"id"];
        }        
        [db close];
        
        return uid;        
    }
    return 1;
}

- (int)queryDataCount:(DBTableName)tableName
{    
    int count ;
    if ([db open]) {
        NSString * sql = [self sqlTableDataCount:tableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            count = [rs intForColumn:@"count"];
        }        
        [db close];
        
        return count;        
    }
    return 1;
}



- (NSArray *)queryRsToArray:(FMResultSet *)rs
{
    NSMutableArray *mArray = [NSMutableArray array];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    while ([rs next]) {
        
        [dict setValue:[NSNumber numberWithInt:[rs intForColumn:@"id"]] forKey:KMessageId];
        [dict setValue:[rs stringForColumn:KMessageMessage] forKey:KMessageMessage];
        [dict setValue:[rs stringForColumn:KMessageAnswer] forKey:KMessageAnswer];
        [dict setValue:[NSNumber numberWithBool:[rs boolForColumn:KMessageIsAnswer]] forKey:KMessageIsAnswer];
        [dict setValue:[rs stringForColumn:KMessageUDID] forKey:KMessageUDID];
        [dict setValue:[rs dateForColumn:KMessageUpTime] forKey:KMessageUpTime];
        
        [mArray addObject:[dict copy]];
        [dict removeAllObjects];
    }
    return mArray;
}



- (NSArray *)queryTableData:(DBTableName)tableName  page:(int)pageNum pagSize:(int)pageSize
{    
    NSArray *itemsArray;
    if ([db open]) {
        NSString * sql = [self sqlTableData:tableName page:pageNum pagSize:pageSize];
        FMResultSet * rs = [db executeQuery:sql];
        itemsArray = [self queryRsToArray:rs];
        [db close];
        return itemsArray;
    }
    
    return nil;
}

+ (FMQueryHelper *)queryHelper:(DBTypeName)dbTypeName
{
    FMQueryHelper *queryHelper = [[[FMQueryHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:dbTypeName];
    return queryHelper;
}

@end
