//
//  DatabaseSqlite.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 21/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "tablesMacro.h"


#define DATABASE_FILE_NAME_OLD @"InterviewPrep_V1.sqlite"
#define DATABASE_FILE_NAME @"InterviewPrep_V2.sqlite"


#define SELECT 1
#define UPDATE 2
#define INSERT 3
#define DELETE 4
#define ALTER  5
#define CREATE  5



#define QUERYRESULT @"result"

#define QUERYSUCCESS @"true"
#define QUERYFAILURE @"false"


@interface DatabaseSqlite : NSObject
{
    NSString *dbpath;
}
//@property (nonatomic, strong) dispatch_queue_t databaseQueue;

-(DatabaseSqlite *)init;

-(NSMutableDictionary *)executeQuery:(NSString *)query tableName:(NSString *)tablename queryType:(int)type;
//-(NSMutableDictionary *)executeQuery:(NSString *)query tableName:(NSString *)tablename;





@end
