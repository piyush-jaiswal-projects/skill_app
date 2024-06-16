//
//  Database.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseSqlite.h"

@interface Database : NSObject
{
    NSOperationQueue * operationQueue;
    
}
@property (atomic) DatabaseSqlite * dbObj;
-(Database *)init;


#pragma mark -    DATAQUERY API's


-(NSMutableArray *)SelecteQuery:queryString  Table:(NSString *)tableName;
-(BOOL)updateQuery:queryString;
-(BOOL)deleteQuery:queryString;
-(BOOL)insertQuery:queryString;

@end
