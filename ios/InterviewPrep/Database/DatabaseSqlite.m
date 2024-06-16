//
//  DatabaseSqlite.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 21/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "DatabaseSqlite.h"
#import "tablesMacro.h"



//static sqlite3 *database = nil;
//
//static sqlite3_stmt *statement = nil;

// ALTER TABLE "main"."CourseTable" ADD COLUMN "version" VARCHAR NOT NULL  DEFAULT 0
@implementation DatabaseSqlite

-(DatabaseSqlite *)init{
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *sqliteDB = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    //dbpath = sqliteDB;
    dbpath = [[NSString alloc] initWithString:sqliteDB];
    
    if ([fileManager fileExistsAtPath:sqliteDB] == NO) {
        NSArray *parts = [DATABASE_FILE_NAME componentsSeparatedByString:@"."];
        if(parts.count != 2) {
            
            return nil;
        }
        
        NSString *sqliteDB_Old = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME_OLD];
        if ([fileManager fileExistsAtPath:sqliteDB_Old])
        {
            if([self removeDirectoryAndDatabase:sqliteDB_Old])
            {
               NSString * folder_Old = [documentsDirectory stringByAppendingPathComponent:@"PracticeApp"];
                if ([fileManager fileExistsAtPath:folder_Old])
                {
                    [self removeDirectoryAndDatabase:folder_Old];
                }
            }
        }
        
        
        
        
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:[parts objectAtIndex:0]
                                                                 ofType:[parts objectAtIndex:1]];
        if(resourcePath == nil) {
            
            return nil;
        }
        [fileManager copyItemAtPath:resourcePath toPath:sqliteDB error:&error];
        if(error != nil) {
            
        }
        //[self createTables];
    }
    else{
        

        
        
    }
    
    
    
    return self;
}

-(BOOL)removeDirectoryAndDatabase:(NSString*) fileFolderPath
{
   return [[NSFileManager defaultManager] removeItemAtPath:fileFolderPath error:nil];
}
// 1 selectQuery
// 2 insertQuery
// 3 deleteQuery
// 4 updateQuery
// 5 ALTER Query


-(NSMutableDictionary *)executeQuery:(NSString *)query tableName:(NSString *)tablename queryType:(int)type
{
    
        sqlite3_stmt *statement;
        sqlite3 *database;
        
        NSMutableDictionary * Dictionary = [[NSMutableDictionary alloc] init];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_open([dbpath UTF8String], &database) == SQLITE_OK)
        {
            NSString *querySQL =  query;
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK)
                
            {

                [Dictionary setValue:QUERYSUCCESS forKey:QUERYRESULT];
                while(sqlite3_step(statement) == SQLITE_ROW)
                {
                 if(type == UPDATE ||type == DELETE ||type == INSERT || type == ALTER || type == CREATE )
                    {
                       
                    }
                    else
                    {
                      NSMutableDictionary * localDictionary = [[NSMutableDictionary alloc]init];
                      if([tablename isEqualToString:@"UserInfoTable"])
                        {
                           if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_LOGIN];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_LOGIN];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_USERNAME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_USERNAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_PASSWORD];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PASSWORD];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_TIME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_ISIMAGECAPTURE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ISIMAGECAPTURE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_LOGINTYPE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_LOGINTYPE];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_USERID];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_USERID];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_PROFILEPIC];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PROFILEPIC];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_TOKEN];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TOKEN];
                            }
                         }
                        
                        else if([tablename isEqualToString:@"CourseTable"])
                        {
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_COURSE_CEDGE];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_COURSE_CEDGE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_COURSE_NAME];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSE_NAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_COURSE_DATA];
                                
                            }
                            else{
                                 [localDictionary setValue:@"" forKey:DATABASE_COURSE_DATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_COURSE_DESC];
                                
                            }
                            else{
                                 [localDictionary setValue:@"" forKey:DATABASE_COURSE_DESC];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_COURSE_TIME];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSE_TIME];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_COURSE_VER];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSE_VER];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_COURSE_IMGPATH];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSE_IMGPATH];
                            }
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_COURSE_LEVELCEFRMAP];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSE_LEVELCEFRMAP];
                            }
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_COURSE_LEVELDESC];
                            }
                            else{
                                [localDictionary setValue:@"-1" forKey:DATABASE_COURSE_LEVELDESC];
                            }
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_COURSE_LEVELTEXT];
                            }
                            else{
                                [localDictionary setValue:@"-1" forKey:DATABASE_COURSE_LEVELTEXT];
                            }
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_COURSE_STANDERD];
                            }
                            else{
                                [localDictionary setValue:@"-1" forKey:DATABASE_COURSE_STANDERD];
                            }
                         }
                        else if([tablename isEqualToString:@"CatLogContentTable"])
                            
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_CATLOGCONT_EDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_CATLOGCONT_CEDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_CATLOGCONT_NAME];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_NAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_CATLOGCONT_DATA];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_DATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_CATLOGCONT_DESC];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_DESC];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_CATLOGCONT_CATTYPE];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_CATTYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_CATLOGCONT_LOCAL_IR];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_LOCAL_IR];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_CATLOGCONT_ISLOCAL_LOCK];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_ISLOCAL_LOCK];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_CATLOGCONT_ISLOCAL_COMPLETE];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_ISLOCAL_COMPLETE];
                            }
                            
                            
                            
                            
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_CATLOGCONT_TIME];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_TIME];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_CATLOGCONT_ZIPURL];
                            
                            }
                            else{
                                [localDictionary setValue:@"5242448" forKey:DATABASE_CATLOGCONT_ZIPURL];
                            }
                            
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 11) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)] forKey:DATABASE_CATLOGCONT_ZIPSIZE];
                            
                            }
                            else{
                                [localDictionary setValue:@"5242448" forKey:DATABASE_CATLOGCONT_ZIPSIZE];
                            }
                            
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 12) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)] forKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 13) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)] forKey:DATABASE_CATLOGCONT_SKILLS];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_SKILLS];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 14) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)] forKey:DATABASE_CATLOGCONT_PASS_SCORE];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_PASS_SCORE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 15) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)] forKey:DATABASE_CATLOGCONT_TOTAL_QUESTION];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_TOTAL_QUESTION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 16) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)] forKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 17) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 17)] forKey:DATABASE_CATLOGCONT_NO_SKILL_QUES];
                            
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_NO_SKILL_QUES];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 18) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 18)] forKey:DATABASE_CATLOGCONT_DURATION];
                            
                            }
                            else{
                                [localDictionary setValue:@"0" forKey:DATABASE_CATLOGCONT_DURATION];
                            }
                            
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 19) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 19)] forKey:DATABASE_CATLOGCONT_THUMBNILIMG];
                            
                            }
                            else
                            {
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_THUMBNILIMG];
                            }
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 20) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 20)] forKey:DATABASE_CATLOGCONT_ISTOPICLOCK];
                            
                            }
                            else
                            {
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_ISTOPICLOCK];
                            }
                            if((const char *) sqlite3_column_text(statement, 21) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 21)] forKey:DATABASE_CATLOGCONT_TOPIC_TYPE];
                            
                            }
                            else
                            {
                                [localDictionary setValue:@"1" forKey:DATABASE_CATLOGCONT_TOPIC_TYPE];
                            }
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 22) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 22)] forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
                            
                            }
                            else
                            {
                                [localDictionary setValue:@"" forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
                            }
                            
                            

                           }
                        else if([tablename isEqualToString:@"AssesmentTable"])
                        {
                            
                        }
                        else if([tablename isEqualToString:@"ScenarioTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_SCENARIO_EDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_SCENARIO_CEDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_SCENARIO_NAME];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_NAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_SCENARIO_DATA];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_DATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_SCENARIO_DESC];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_DESC];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_SCENARIO_ISCOMP];
                                
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_ISCOMP];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_SCENARIO_TIME];
                               
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_TIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_SCENARIO_IR];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_IR];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_SCENARIO_ZIPURL];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_ZIPURL];
                            }
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_SCENARIO_ZIPSIZE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_ZIPSIZE];
                            }
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_SCENARIO_BGCOLOR];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_BGCOLOR];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 11) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)] forKey:DATABASE_SCENARIO_DURATION];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_DURATION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 12) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)] forKey:DATABASE_SCENARIO_SKILL];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_SKILL];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 13) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)] forKey:DATABASE_SCENARIO_THUMBNAIL];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_THUMBNAIL];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 14) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)] forKey:DATABASE_SCENARIO_QUESCOUNT];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_QUESCOUNT];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 15) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)] forKey:DATABASE_SCENARIO_SCATTYPE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_SCENARIO_SCATTYPE];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 16) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)] forKey:DATABASE_SCENARIO_IS_HIDE];
                            }
                            else{
                                [localDictionary setValue:@"0" forKey:DATABASE_SCENARIO_IS_HIDE];
                            }
                            
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"ExerciseTable"])
                        {
                           
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_EXERCISE_EDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_EXERCISE_CEDGEID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_EXERCISE_CATTYPE];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_CATTYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_EXERCISE_NAME];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_NAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_EXERCISE_DATA];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_DATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_EXERCISE_DESC];
                                
                               
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_DESC];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_EXERCISE_ISCOMP];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_ISCOMP];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_EXERCISE_TIME];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_TIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
                            }
                        }
                        else if([tablename isEqualToString:@"ActiviyTable"])
                        {
                            
                        }
                        
                        else if([tablename isEqualToString:@"PracticeTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_PRACTICE_EDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_PRACTICE_CEDGEID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_PRACTICE_WATCHEDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_WATCHEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_PRACTICE_ENACTEDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_ENACTEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
                                
                               
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_PRACTICE_CATETYPE];
                                
                                
                            }
                            else{
                                 [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_CATETYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_PRACTICE_NAME];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_NAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_PRACTICE_DATA];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_DATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_PRACTICE_DESC];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_DESC];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_PRACTICE_ISCOMP];
                               
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_ISCOMP];
                            }
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                                
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_PRACTICE_TIME];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_TIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 11) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                               
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                            }
                            if((const char *) sqlite3_column_text(statement, 12) != NULL)
                            {
                                
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 13) != NULL)
                            {
                                
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
                            }
                            else{
                                [localDictionary setValue:@"0" forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
                            }
                            
                            
                            
                           
                        }
                        else if([tablename isEqualToString:@"ConversationTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_CONVERSATION_EDGEID];
                                
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_CONVERSATION_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_CONVERSATION_CEDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CONVERSATION_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_CONVERSATION_IDEALTIME];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CONVERSATION_IDEALTIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_CONVERSATION_CATTYPE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CONVERSATION_CATTYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_CONVERSATION_TIME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_CONVERSATION_TIME];
                            }
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"VocabularyTable"])
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_VOCAB_EDGEID];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCAB_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_VOCAB_WORDID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCAB_WORDID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_VOCAB_WORD];
                                
                            }
                            else{
                                 [localDictionary setValue:@"" forKey:DATABASE_VOCAB_WORD];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_VOCAB_CEDGEID];
                               
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCAB_CEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_VOCAB_ISCOMP];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCAB_ISCOMP];
                            }
                            
                            
                            
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"QuestionTable"])
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_QUESTION_EDGEID];
                                
                            }
                            else{
                                
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_QUESTION_CONUNITID];
                                
                            }
                            else{
                                
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_QUESTION_TAG];
                                
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_QUESTION_TAG];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_QUESTION_VPATH];
                                
                            }
                            else{
                                
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_QUESTION_RECVIDEOPATH];
                                
                            }
                            else{
                                
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_QUESTION_RECAUDIOPATH];
                                
                                
                            }
                            else{
                                
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_QUESTION_ISCOMP];
                            }
                            else{
                                
                            }
                            
                            
                            
                            
                            
                        }
                        
                        else if([tablename isEqualToString:@"AnswerTable"])
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_ANSWER_EDGEID];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ANSWER_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_ANSWER_CONUNITID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_ANSWER_CONUNITID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                
                            [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_ANSWER_TAG];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_ANSWER_TAG];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_ANSWER_PLAYPATH];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ANSWER_PLAYPATH];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_ANSWER_RECVIDEOPATH];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ANSWER_RECVIDEOPATH];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_ANSWER_RECAUDIOPATH];
                                
                            }
                            else{
                                  [localDictionary setValue:@"" forKey:DATABASE_ANSWER_RECAUDIOPATH];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_ANSWER_ISCOMPLETE];
                            }
                            else{
                                 [localDictionary setValue:@"" forKey:DATABASE_ANSWER_ISCOMPLETE];
                            }
                            
                            

                            
                            
                        }
                        else if([tablename isEqualToString:@"TextSegmentTable"])
                        {
                            
                            
                            
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_TEXTSEGMENT_EDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEXTSEGMENT_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_TEXTSEGMENT_TEXTID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TEXTSEGMENT_TEXTID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_TEXTSEGMENT_CLICKITEMID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TEXTSEGMENT_CLICKITEMID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                            
                             [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_TEXTSEGMENT_SIMPLETEXT];
                                
                                
                                
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_TEXTSEGMENT_SIMPLETEXT];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                            
                            
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_TEXTSEGMENT_CLICKTEXT];
                        
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEXTSEGMENT_CLICKTEXT];
                            }
            
                            
                        }
                        else if([tablename isEqualToString:@"VocabWordTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_VOCABWORD_WORDID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_WORDID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_VOCABWORD_EDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_VOCABWORD_WORD];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_WORD];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_VOCABWORD_MEANING];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_MEANING];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_VOCABWORD_PRONOUNCIATION];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_PRONOUNCIATION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_VOCABWORD_PARTOFSPEECH];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_PARTOFSPEECH];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_VOCABWORD_ETYMOLOGIES];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_ETYMOLOGIES];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_VOCABWORD_USAGE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_USAGE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_VOCABWORD_WORDAUDIOPATH];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_WORDAUDIOPATH];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH];
                            }
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_VOCABWORD_PSCORE];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_PSCORE];
                            }
                            if((const char *) sqlite3_column_text(statement, 11) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)] forKey:DATABASE_VOCABWORD_TIME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_TIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 12) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)] forKey:DATABASE_VOCABWORD_COURSE_CODE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_VOCABWORD_COURSE_CODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 13) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)] forKey:DATABASE_VOCABWORD_ISCOMP];
                            }
                            else{
                                [localDictionary setValue:@"0" forKey:DATABASE_VOCABWORD_ISCOMP];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 14) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)] forKey:DATABASE_VOCABWORD_IMAGEPATH];
                            }
                            else{
                                [localDictionary setValue:@"0" forKey:DATABASE_VOCABWORD_IMAGEPATH];
                            }
                            
                            [localDictionary setValue:@"0" forKey:DATABASE_VOCABWORD_PLAYSTAT];
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"GameTable"])
                        {
                            
                        }
                        else if([tablename isEqualToString:@"TrackingTable"])
                        {
                            
                            
                            if(sqlite3_column_text(statement, 0) == NULL)
                            {
                                [Dictionary setValue:QUERYFAILURE forKey:QUERYRESULT];
                                [Dictionary setValue:NULL forKey:DATABASE_LOCAL_DATA];
                                sqlite3_finalize(statement);
                                sqlite3_close(database);
                                return Dictionary;
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_TRACKINGTABLE_MOEDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_MOEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_TRACKINGTABLE_SCNEDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_SCNEDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_TRACKINGTABLE_EDGEID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_TRACKINGTABLE_TRACKTYPE];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_TRACKTYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_TRACKINGTABLE_USAGESCORE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_USAGESCORE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_TRACKINGTABLE_ISCOMP];
                                
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_ISCOMP];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_TRACKINGTABLE_STARTTIME];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_STARTTIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_TRACKINGTABLE_ENDTIME];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_ENDTIME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_TRACKINGTABLE_COURSE_CODE];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_COURSE_CODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_TRACKINGTABLE_COURSEPACK];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TRACKINGTABLE_COURSEPACK];
                            }

                            
                            
                            
                            
                            
                            
                            
                           
                        }
                        else if([tablename isEqualToString:@"TrackSyncTime"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                              [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_TRACKSYNCTIME_TIME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TRACKSYNCTIME_TIME];
                            }
                            
                            
                            
                            
                            
                        }
                        
                        else if([tablename isEqualToString:@"AudroApiTable"])
                        {
                            
                        }
                        
                        else if([tablename isEqualToString:@"PullIrTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_PULLIR_EDGEID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_PULLIR_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_PULLIR_AVGIR];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PULLIR_AVGIR];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_PULLIR_MAXIR];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PULLIR_MAXIR];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                               [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_PULLIR_TIME];
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_PULLIR_TIME];
                            }
                            
                            
                            
                            
                            
                            
                        }
                        
                        else if([tablename isEqualToString:@"ModuleTable"])
                        {
                            
                        }
                        
                        else if([tablename isEqualToString:@"TestTable"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_TEST_EDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_TEST_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_TEST_TESTID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_TEST_TESTID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_TEST_QUESID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_QUESID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_TEST_ANSID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_TEST_ANSID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_TEST_SCORE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_SCORE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_TEST_DATAMS];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_DATAMS];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_TEST_COURSE_CODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_COURSE_CODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_TEST_COURSEPACK];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_COURSEPACK];
                            }
                            if((const char *) sqlite3_column_text(statement, 8) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)] forKey:DATABASE_TEST_ESSASYANSWER];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_ESSASYANSWER];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 9) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)] forKey:DATABASE_TEST_AVMEDIAFILES];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_AVMEDIAFILES];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 10) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)] forKey:DATABASE_TEST_ATTEMPT_ID];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_TEST_ATTEMPT_ID];
                            }
                            
                            
                        }
                        else if([tablename isEqualToString:@"AttemptCounterTable"])
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_ATTEMPTCOUNTER_EDGEID];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_ATTEMPTCOUNTER_EDGEID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_ATTEMPTCOUNTER_ATTEMPT_ID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_ATTEMPTCOUNTER_ATTEMPT_ID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_ATTEMPTCOUNTER_TEST_TYPE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ATTEMPTCOUNTER_TEST_TYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_ATTEMPTCOUNTER_COURSE_CODE];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_ATTEMPTCOUNTER_COURSE_CODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_ATTEMPTCOUNTER_COURSEPACK];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_ATTEMPTCOUNTER_COURSEPACK];
                            }
                            
                             
                        }
                        else if([tablename isEqualToString:@"CoinsTable"])
                        {
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_COINS_COURSECODE];
                                
                            }
                            else{
                               [localDictionary setValue:@"" forKey:DATABASE_COINS_COURSECODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_COINS_TOPICID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_COINS_TOPICID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_COINS_CAHPTERID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINS_CAHPTERID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_COINS_COMPONANTID];
                                
                            }
                            else{
                              [localDictionary setValue:@"" forKey:DATABASE_COINS_COMPONANTID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_COINS_COMPONANTTYPE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINS_COMPONANTTYPE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_COINS_COMPONANTDATA];
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINS_COMPONANTDATA];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_COINS_COMPONANTDATACOINS];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINS_COMPONANTDATACOINS];
                            }
                            
                             
                        }
                        else if([tablename isEqualToString:@"CoursePackTable"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_COURSEPACK_COURSEPACKCODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_COURSEPACKCODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_COURSEPACK_COURSEPACKDURATION];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_COURSEPACKDURATION];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_COURSEPACK_COURSEPACKBLOCK];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_COURSEPACKBLOCK];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 4) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)] forKey:DATABASE_COURSEPACK_DATE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_DATE];
                            }
                            if((const char *) sqlite3_column_text(statement, 5) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)] forKey:DATABASE_COURSEPACK_DEVICESTATUS];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_DEVICESTATUS];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 6) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)] forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
                            }
                            if((const char *) sqlite3_column_text(statement, 7) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)] forKey:DATABASE_COURSEPACK_PRODUCTCODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACK_PRODUCTCODE];
                            }
                            
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"CoursePackCourseMappingTable"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_COURSEPACKCOURSEMAPPING_DATABASE_COURSE_CEDGE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COURSEPACKCOURSEMAPPING_DATABASE_COURSE_CEDGE];
                            }
                            
                            
                        }
                        else if([tablename isEqualToString:@"CategoryTable"])
                        {
                            
                            
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_CATEGORY_CATEGORYNAME];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORY_CATEGORYNAME];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_CATEGORY_CATEGORYCOURSEPACKCODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORY_CATEGORYCOURSEPACKCODE];
                            }
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_CATEGORY_CATEGORYID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORY_CATEGORYID];
                            }
                           
                            
                            
                            
                            
                        }
                        else if([tablename isEqualToString:@"CategoryCourseMappingTable"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_CATEGORYCOURSEMAPPING_CATEGORYID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORYCOURSEMAPPING_CATEGORYID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_CATEGORYCOURSEMAPPING_COURSE_CEDGE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORYCOURSEMAPPING_CATEGORYID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_CATEGORYCOURSEMAPPING_COURSEPACKCODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_CATEGORYCOURSEMAPPING_COURSEPACKCODE];
                            }
                            
                            
                        }
                        else if([tablename isEqualToString:@"CoinsUserTable"])
                        {
                            
                            if((const char *) sqlite3_column_text(statement, 0) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)] forKey:DATABASE_COINSUSER_PACKAGECODE];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINSUSER_PACKAGECODE];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 1) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)] forKey:DATABASE_COINSUSER_COMPONANTID];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINSUSER_COMPONANTID];
                            }
                            
                            if((const char *) sqlite3_column_text(statement, 2) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)] forKey:DATABASE_COINSUSER_EARNEDCOINS];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINSUSER_EARNEDCOINS];
                            }
                            
                            
                            if((const char *) sqlite3_column_text(statement, 3) != NULL)
                            {
                                [localDictionary setValue:[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)] forKey:DATABASE_COINSUSER_TOTALCOINS];
                                
                            }
                            else{
                                [localDictionary setValue:@"" forKey:DATABASE_COINSUSER_TOTALCOINS];
                            }
                            
                            
                        }
                        
                        
                        
                        
                        else if([tablename isEqualToString:@"JumbleConversationTable"])
                        {
                            
                        }
                        else
                        {
                            
                        }
                        
                        [resultArray addObject:[self getConvertIfExist:localDictionary]];
                    }
                    
                }
                
                
                
                
                sqlite3_finalize(statement);
            }
            else
            {
                [Dictionary setValue:QUERYFAILURE forKey:QUERYRESULT];
            }
            sqlite3_close(database);
        }
        else{
            [Dictionary setValue:QUERYFAILURE forKey:QUERYRESULT];
        }
        
    
        [Dictionary setValue:resultArray forKey:DATABASE_LOCAL_DATA];
       // NSLog(@"Exit the Query .");
        return Dictionary;
        
    
    
}


-(NSMutableDictionary *)getConvertIfExist:(NSMutableDictionary *)lDictionary
{
    for( int i =0 ;i< [[lDictionary allKeys] count] ; i++ )
    {
        NSString *aKey = [[lDictionary allKeys] objectAtIndex:i];
        if(aKey != NULL)
        {
            NSString * data = [[NSString alloc]initWithFormat:@"%@",[lDictionary valueForKey:aKey]];
            
            NSString *newdata = [data stringByReplacingOccurrencesOfString:@"%27" withString:@"'"];
            [lDictionary setValue:newdata forKey:aKey];
        }
    }
    return lDictionary;
}





@end
