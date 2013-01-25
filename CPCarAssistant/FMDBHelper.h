//
//  FMDBHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

typedef enum {
DBTypeNameDocument =0,
DBTypeNameTmp,
} DBTypeName;

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMHelper.h"


@interface FMDBHelper : NSObject
{

}

+ (FMDatabase *)databaseWithName:(DBTypeName)dbTypeName;


@end
