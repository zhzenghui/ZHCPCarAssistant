//
//  FMUpdateHelper.h
//  CPCarAssistant
//
//  Created by zeng on 13-1-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FMDBHelper.h"


@interface FMUpdateHelper : NSObject
+ (FMUpdateHelper *)updateHelper:(DBTypeName)dbTypeName;

@end