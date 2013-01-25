//
//  FMDBHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//



#import "FMDBHelper.h"

//static FMDatabase *db;

@implementation FMDBHelper

+ (FMDatabase *)databaseWithName:(DBTypeName)dbTypeName
{
    NSString * doc = PATH_OF_DOCUMENT;
    NSBundle  *mainBundle = PATH_OF_NSBUNDLE;

    NSString * path = [doc stringByAppendingPathComponent:@"Document.sqlite"];    
    NSString * sqlPath = [mainBundle pathForResource:@"sqlscript" ofType:@"sql"];

    switch (dbTypeName) {
        case DBTypeNameDocument:
        {
            path = [doc stringByAppendingPathComponent:@"Document.sqlite"];    
            sqlPath = [mainBundle pathForResource:@"sqlscript" ofType:@"sql"];
            break;
        }
        case DBTypeNameTmp:
        { 
            path = [doc stringByAppendingPathComponent:@"tmp.sqlite"];    
            sqlPath = [mainBundle pathForResource:@"sqlscript" ofType:@"sql"];            
            break;
        }
        default:
        {
            path = [doc stringByAppendingPathComponent:@"Document.sqlite"];    
            sqlPath = [mainBundle pathForResource:@"sqlscript" ofType:@"sql"];
            break;
        }
    }
    
    
    
    FMDatabase *_db = [FMDatabase databaseWithPath:path];

//    create table
    if ([_db open]) {
        
        NSString *sql = [[NSString alloc] initWithContentsOfFile:sqlPath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray * commands = [sql componentsSeparatedByString:@";"];
        for(NSString * cmd in commands)
        {
            BOOL res = [_db executeUpdateWithFormat:cmd];
            if (!res) {
                debugLog(@"error when creating db table %@", cmd);
            } else {
                debugLog(@"succ to creating db table");
            }
            
        }

        [_db close];
    }
    else {
        debugLog(@"error when open db");
    }
    return _db;
}



- (void)dealloc
{
    [super dealloc];
}
@end
