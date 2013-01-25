//
//  DictDataToDBData.m
//  CPCarAssistant
//
//  Created by zeng on 13-1-23.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "DictDataToDBData.h"


#define KAddItems @"AddItems"
    #define KAddItems_TableName @"table"

#define KDelItems @"DelItems"
#define KUpdateItems @"UpdateItems"

#define KFile_Add_Auto @"AddFile"
#define KFile_Add_AutoSeries @"AutoSeries"
#define KFile_Add_AutoImg @"AutoImg"
#define KFile_Add_Images @"Images"



#define KFile_DelFile_Auto @"DelFile"
#define KFile_AddFile_Auto @"AddFile"


@implementation DictDataToDBData

NSDictionary *dataDict;
NSDictionary *FileDict;
//"AddItems": [
//             {
//                 "Auto": {
//                     "ID": 1, 
//                     "SeriesID": 1, 
//                     "Name": "1.5T 时尚型", 
//                     "AutoImg": "/Data/ChangChengC50/1.5T ShiShangXing/1.5T ShiShangXing.jpg", 
//                     "MSRP": 78800, 
//                     "IsTestDrive": false, 
//                     "OrderNum": 1
//                 }
//             }
//             ], 
//"DelItems": "null", 
//"UpdateItems": "null"

+ (DictDataToDBData *)dataToDbHelper
{
    DictDataToDBData *fbInsertHelper = [[[DictDataToDBData alloc] init] autorelease] ;
 
    return fbInsertHelper;
}

- (void)addItemsDBData:(NSDictionary *)dict
{
    NSDictionary *addDict = [dataDict objectForKey:KAddItems];
    NSString *table = [addDict objectForKey:KAddItems_TableName];
    
}

- (void)delItemsDBData:(NSDictionary *)dict
{
    NSDictionary *delDict = [dataDict objectForKey:KAddItems];
}

- (void)updateItemsDBData:(NSDictionary *)dict
{
    NSDictionary *updateDict = [dataDict objectForKey:KAddItems];
}


/*
 
 创建目录
 
*/
- (void)createImageDocument :(NSString *)imagePath
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:imagePath isDirectory:&isDir];
    NSString *document = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:imagePath];

    if(!(isDirExist && isDir))
    {
        NSError *error;
        BOOL bCreateDir = [fileManager createDirectoryAtPath:document withIntermediateDirectories:YES attributes:nil error:&error];  
        if(!bCreateDir){
            NSLog(@"Create Audio Directory Failed. %@", error);
        }
        NSLog(@"%@",imagePath);
    }
    
}

- (NSString *)imagesFilePath :(NSString *)fileUrl
{
    
/*
 
 fileUrl 替换  s ， range  根据最后一个／的位置 分割 字符串
 
 */
    NSString *s = fileUrl;//@"/Data/ChangChengC50/1.5T_ShiShangXing/1.5T_ShiShangXing.jpg";
    
    NSRange range = [s rangeOfString:@"/" options:NSBackwardsSearch range:NSMakeRange(0, s.length)];

    
/*
    创建的目录结构
    例如：/Data/ChangChengC50/1.5T_ShiShangXing     
*/
    NSString *documentPath = [s substringWithRange:NSMakeRange(0, range.location)];
    [self createImageDocument:documentPath];
    
//     创建的文件
    NSString *fileName = [s substringWithRange:NSMakeRange(range.location+1, s.length-range.location-1)];;
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [document stringByAppendingPathComponent:[NSString stringWithFormat: @"%@/%@", documentPath, fileName]];
    
    return path;
}

/*
 
 保存文件
 
 */
- (void)saveFile:(NSData *)data fileUrl:(NSString *)fileUrl
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
   if (data) 
    {        
        [fileManager createFileAtPath:[self imagesFilePath:fileUrl] contents:data attributes:nil];
    }
}

- (void)addFile:(NSString *)fileName
{
    NSDate *currentDate = [NSDate date];
    dispatch_queue_t myQueue = NULL;
    if (myQueue == NULL) {
        myQueue = dispatch_queue_create([[currentDate description] UTF8String], NULL);
    }

    dispatch_async(myQueue, ^(void) {
        NSLog(@"fileName:%@", fileName);
        NSString *urlString = [NSString stringWithFormat:KServerUrl,fileName];
        NSString* urlTextEscaped = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlTextEscaped];
        NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url
                                                                     cachePolicy:NSURLRequestUseProtocolCachePolicy 
                                                                 timeoutInterval:UPLOAD_TIME_OUT] autorelease];
        
        
        [request setHTTPMethod:@"GET"];
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:NULL];
        if (data) {
            [self saveFile:data fileUrl:fileName];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    });  
    
    dispatch_release(myQueue);
}

- (void)delFile:(NSArray *)delArray
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
     
    NSError *errorMessage;
    for (NSString *autoRecord in delArray) {

        bool isSuccess = [fileManager removeItemAtPath:[self imagesFilePath:autoRecord] error:&errorMessage];
        if (isSuccess) {
            debugLog(@"success fileName %@" , autoRecord);
        }
        else {
            debugLog(@"faild ! error: %@", errorMessage);        
        }
    }
}

- (void)addFiles:(NSDictionary *)FileDict
{
////下载添加文件 ＊添加下载是否成功标记，  以便失败后再次下载＊/////////////////////////////////////////////
    NSDictionary *addAutoDict = [FileDict objectForKey:KFile_AddFile_Auto];
    if (addAutoDict) {     
//        NSLog(@"addDict:%@", [addAutoDict allValues]);
        for (NSString *autoRecord in [addAutoDict allValues]) {
//            [self  addFile:autoRecord];
        }
    }
    else {
        debugLog(@"no add file");
    }
    
////删除本地文件 /////////////////////////////////////////////////////////////////////////////////    
    NSDictionary *delDict = [FileDict objectForKey:KFile_DelFile_Auto];
    if (delDict) {
//        NSLog(@"delDict:%@", [delDict allValues]);
        [self  delFile:[delDict allValues]];
    }
    else {
        debugLog(@"no del file");
    }
}


@end