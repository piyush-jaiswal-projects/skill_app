//
//  Database.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Database.h"
#import "tablesMacro.h"
#import "FileLogger.h"

@implementation Database

-(Database *)init
{
    _dbObj = [[DatabaseSqlite alloc] init];
    [self updateTableStructure];
    operationQueue = [NSOperationQueue new];
    
    return self;
}



#pragma mark -    DATAQUERY API's

-(NSArray *)SelecteQuery:queryString  Table:(NSString *)tableName
{
    NSMutableDictionary * dataDictionary = [_dbObj executeQuery:queryString tableName:tableName queryType:SELECT];
    if([[dataDictionary valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
    {
        NSMutableArray * dataArr = [dataDictionary valueForKey:DATABASE_LOCAL_DATA];
        if([dataArr count] > 0)
        {
            return dataArr;
        }
    }
    else
    {
        return NULL;
    }
  return NULL;
}
-(BOOL)updateTableStructure
{
    
    [_dbObj executeQuery:@"ALTER TABLE UserinfoTable ADD COLUMN user_id VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE UserinfoTable ADD COLUMN profile_pic VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE UserinfoTable ADD COLUMN token VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    
    
    
    
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN catContEdgeID VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN catEdgeID VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN name VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN data VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN desc VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN catType INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN ir float"  tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN isLock boolean" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN isComp boolean" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN writeTime INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN zipurl VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN zipsize VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN assessment_type VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN skills VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN passing_score VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN total_question VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN ttl_ques_to_show VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN no_of_skill_ques VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN duration  VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN thumnailImg VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN isLocked VARCHAR ( 2 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN topic_type VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CatLogContentTable ADD COLUMN remediation_edge_id VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    
    
    
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN cEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN name VARCHAR ( 100 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN data VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN desc VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN writeTime INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN version VARCHAR ( 1000 ) NOT NULL DEFAULT (0)"  tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN imgPath VARCHAR ( 512 ) DEFAULT (null)" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN level_cefr_map VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN level_description VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN level_text VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE CourseTable ADD COLUMN standard VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    
    
    
    
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN exEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN scnEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN catType INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN name VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN data VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN desc VARCHAR ( 512 )"  tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN isComp boolean" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN writeTime INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN comp_sequence VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ExerciseTable ADD COLUMN thumbnailImg VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
   
    
    
    [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN pracEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN exEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN watchEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN enactEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN reviewEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN catType INTEGER"  tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN name VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN data VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN desc VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN isComp boolean" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN writeTime INTEGER" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN comp_sequence VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN thumbnailImg VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE PracticeTable ADD COLUMN interactive_html VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    
    
    
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN scnEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN catContEdgeID VARCHAR ( 100 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN name VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN data VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN desc VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN isComp boolean"  tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN writeTime INTEGER" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN zipurl VARCHAR ( 512 ) DEFAULT (null)" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN zipsize VARCHAR ( 512 )" tableName:nil queryType:ALTER];
     [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN bgcolor VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN duration VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN chapterSkill VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN thumnailImg VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN quesCount VARCHAR ( 512 )" tableName:nil queryType:ALTER];
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN catType INTEGER" tableName:nil queryType:ALTER];
    
    [_dbObj executeQuery:@"ALTER TABLE ScenarioTable ADD COLUMN is_hide_resource INTEGER" tableName:nil queryType:ALTER];
    
    
    
    
    [_dbObj executeQuery:@"ALTER TABLE VocabWordTable ADD COLUMN vocabImagePath VARCHAR ( 1024 )" tableName:nil queryType:ALTER];
    
    
    
    

    NSDictionary * dataDictionary = [_dbObj executeQuery:@"CREATE TABLE AttemptCounterTable (attempt_id INTEGER, type_of_test  INTEGER, course_code VARCHAR(20),component_type  VARCHAR(20))" tableName:nil queryType:CREATE];
    if([[dataDictionary valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
    {
        
    }
    else
    {
        
    }
    
    NSDictionary * dataDictionary1 = [_dbObj executeQuery:@"CREATE TABLE CoinsTable (course_code VARCHAR ( 20 ), topic_edge_id  VARCHAR ( 20 ), chapter_edge_id VARCHAR(20),component_edge_id  VARCHAR(20),component_type VARCHAR(20),component_data  VARCHAR(20),user_coins  VARCHAR(20))" tableName:nil queryType:CREATE];
    
    if([[dataDictionary1 valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
    {
        
    }
    else
    {
        
        
    }
    
    
    NSDictionary * dataDictionary2 = [_dbObj executeQuery:@"CREATE TABLE CoinsUserTable (coursePackCode VARCHAR(20), component_edge_id VARCHAR(20),user_coins VARCHAR(20),total_componant_coins VARCHAR(20))" tableName:nil queryType:CREATE];
    
    if([[dataDictionary2 valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
    {
        
    }
    else
    {
        
        
    }
    
    
    
    
    
    
//     NSDictionary * dataDictionary2 = [_dbObj executeQuery:@"SHOW TABLES LIKE '%CoinsTable%'" tableName:nil queryType:SHOW];
//       if([[dataDictionary2 valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
//       {
//           
//       }
//       else
//       {
//           
//       }
//    
//    NSDictionary * dataDictionary1 = [_dbObj executeQuery:@"SHOW TABLES LIKE '%AttemptCounterTable%'" tableName:nil queryType:SHOW];
//    if([[dataDictionary1 valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS])
//    {
//        
//    }
//    else
//    {
//        
//    }
       
//    CREATE TABLE AttemptCounterTable ('test_uniqid'    VARCHAR ( 20 ),
//        `attempt_id`    INTEGER,
//        `type_of_test`    INTEGER,
//        `course_code`    VARCHAR ( 20 ),
//        `package_code`    VARCHAR ( 20 )
//    );
////
//
//
//    CREATE TABLE `CoinsTable` (
//        `course_code`    VARCHAR ( 20 ),
//        `topic_edge_id`    VARCHAR ( 20 ),
//        `chapter_edge_id`    VARCHAR ( 20 ),
//        `component_edge_id`    VARCHAR ( 20 ),
//        `component_type`    VARCHAR ( 20 ),
//        `component_data`    VARCHAR ( 20 ),
//        `user_coins`    VARCHAR ( 20 )
//    );
    
    
    
    return TRUE;
    
}
-(BOOL)updateQuery:queryString
{
    
   NSDictionary * dataDictionary = [_dbObj executeQuery:queryString tableName:nil queryType:UPDATE];
    if([[dataDictionary valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS]) return TRUE;
    else return FALSE;
     
}
-(BOOL)deleteQuery:queryString
{
    NSDictionary * dataDictionary = [_dbObj executeQuery:queryString tableName:nil queryType:DELETE];
    if([[dataDictionary valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS]) return TRUE;
    else return FALSE;
}
-(BOOL)insertQuery:queryString
{
    NSDictionary * dataDictionary = [_dbObj executeQuery:queryString tableName:nil queryType:INSERT];
    if([[dataDictionary valueForKey:QUERYRESULT] isEqualToString:QUERYSUCCESS]) return TRUE;
    else return FALSE;
}

@end
