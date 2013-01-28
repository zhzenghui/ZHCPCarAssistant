//
//  FMDeleteHelper.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "FMDeleteHelper.h"

@implementation FMDeleteHelper

static FMDatabase *db;


+ (FMDeleteHelper *)deleteHelper:(DBTypeName)dbTypeName
{
    FMDeleteHelper *deleteHelper = [[[FMDeleteHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:dbTypeName];
    return deleteHelper;
}
@end