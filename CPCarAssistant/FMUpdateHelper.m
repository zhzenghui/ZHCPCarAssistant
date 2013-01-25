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


+ (FMUpdateHelper *)updateHelper:(DBTypeName)dbTypeName;
{
    FMUpdateHelper *updateHelper = [[[FMUpdateHelper alloc] init] autorelease];
    db = [FMDBHelper databaseWithName:dbTypeName];
    return updateHelper;
}
@end
