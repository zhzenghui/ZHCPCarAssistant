//
//  FMHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//
typedef enum {
    DBTableNameMyCar=0, //我的车
    DBTableNameConsumeRecord, //养车记录
    DBTableNameMessage,
} DBTableName;

#import "FMQueryHelper.h"
#import "FMInsertHelper.h"
#import "FMUpdateHelper.h"
#import "FMDeleteHelper.h"
