//
//  DataManagement.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "DataManagement.h"
#import "tablesMacro.h"
#import "FileLogger.h"
#import "XMLParserHeader.h"
#import "GlobalHeader.h"
#import "XMLReader.h"
#import "AppDelegate.h"


#define  ONEDATATEXT @"1"
#define  EMPTYDATAINT  @"0"
#define  EMPTYDATATEXT @""

@implementation DataManagement
{
    AppDelegate * appDelegate;
}


-(DataManagement *)init:(NSObject *)obj CourseCode:(NSString *)code;
{
    dataObj = [[Database alloc]init];
    languageObj = (Language *)obj;
    // courseCode = code;
    appDelegate = APP_DELEGATE;
    [self initialise];
    return self;
}



#pragma mark -    DELETE DATA API's

-(BOOL)deleteTestData
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_TESTTABLE];
    [Logger logAduro:strfmt];
    return  [dataObj deleteQuery:strfmt];
}



#pragma mark -    SET RAW DATA API's



-(BOOL)fillCourseDatabase:(XMLDictionary *)xml
{
    [Logger logAduro:@"DataManagement : Start Function fillCourseDatabase" ];
    
    [self fillCourseDataIntable:(NSMutableArray *)xml.courseArray];
    [self fillModuleDataIntable:(NSMutableArray *)xml.moduleArray];
    //[self fillAssissmentDataIntable:(NSMutableArray *)xml.assessmentArray];
    [self fillScenarioDataIntable:(NSMutableArray *)xml.scenarioArray];
    
    [self fillConceptDataIntable:(NSMutableArray *)xml.conceptArray];
    [self fillActivityDataIntable:(NSMutableArray *)xml.activityArray];
    [self fillpracticeDataIntable:(NSMutableArray *)xml.practiceArray];
    [self fillScnarioPracticeDataIntable:(NSMutableArray *)xml.scenario_practiceArray :xml.watch_scenario_practiceArray :xml.enact_scenario_practiceArray :xml.review_scenario_practiceArray];
    [self fillVocabPracticeDataIntable:(NSMutableArray *)xml.vocab_practiceArray];
    [self fillMCQPracticeDataIntable:(NSMutableArray *)xml.mcq_practiceArray];
    
    [self fillGamePracticeDataIntable:(NSMutableArray *)xml.game_practiceArray];
    [self fillSpeedReadingPracticeDataIntable:(NSMutableArray *)xml.speedReading_practiceArray];
    [self fillResourceIntable:(NSMutableArray *)xml.resourse_practiceArray];
    [self fillConversionIntable:(NSMutableArray *)xml.conversation_practiceArray];
    [self fillLearnosityIntable:(NSMutableArray *)xml.learnosity_practiceArray];
    
    [Logger logAduro:@"DataManagement : end Function fillCourseDatabase" ];
    
    return TRUE;
}

-(BOOL)fillGamePracticeDataIntable:(NSMutableArray *)scenario_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillGamePracticeDataIntable" ];
    if(scenario_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [scenario_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_SRPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillGamePracticeDataIntable" ];
    return TRUE;
}
-(BOOL)fillSpeedReadingPracticeDataIntable:(NSMutableArray *)scenario_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillGamePracticeDataIntable" ];
    if(scenario_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [scenario_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_GAMEPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillMCQPracticeDataIntable" ];
    return TRUE;
}
-(BOOL)fillResourceIntable:(NSMutableArray *)resource_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillGamePracticeDataIntable" ];
    if(resource_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [resource_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[resource_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_GAMEPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillMCQPracticeDataIntable" ];
    return TRUE;
}

-(BOOL)fillConversionIntable:(NSMutableArray *)conversation_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillGamePracticeDataIntable" ];
    if(conversation_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [conversation_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[conversation_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_GAMEPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillMCQPracticeDataIntable" ];
    return TRUE;
}

-(BOOL)fillLearnosityIntable:(NSMutableArray *)learnosity_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillGamePracticeDataIntable" ];
    if(learnosity_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [learnosity_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[learnosity_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_GAMEPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillMCQPracticeDataIntable" ];
    return TRUE;
}



-(BOOL)fillVocabWordDatabase:(XMLDictionary *)xml
{
    [Logger logAduro:@"DataManagement : Start Function fillCourseDatabase" ];
    [self fillVocabWordDataIntable:(NSMutableArray *)xml.vocab_WordArray];
    [Logger logAduro:@"DataManagement : end Function fillCourseDatabase" ];
    
    return TRUE;
}

-(void)vocabpracticeXml:(XMLDictionary *)xmlObj
{
    [self fillVocabularyDataIntable:(NSMutableArray *)xmlObj.vocabularyArr];
    
}


-(void)fillConceptPracticeXmlDatabase:(XMLDictionary *)xmlObj catType:(NSString *)catType
{
    [self fillUnitDataIntable:(NSMutableArray *)xmlObj.unitArray:catType];
    [self fillQuestionDataIntable:(NSMutableArray *)xmlObj.questionArray];
    [self fillansDataIntable:(NSMutableArray *)xmlObj.ansArray];
    [self fillSegmentDataIntable:(NSMutableArray *)xmlObj.segmenttextArray];
}




#pragma mark -    SET API's

-(BOOL)updateCoursePack:(NSArray *)coursePack
{
    for (NSDictionary *obj in coursePack) {
        NSMutableDictionary * packObj = [[NSMutableDictionary alloc]init];
        
        NSString * courseQuery = [[NSString alloc]initWithFormat:@"SELECT * from CoursePackTable WHERE coursePackCode ='%@'",[obj valueForKey:@"package_code"]];
        NSMutableArray * courseArr = [dataObj SelecteQuery:courseQuery Table:@"CourseTable"];
        
        if([courseArr count] == 0)
        {
            [packObj removeAllObjects];
            [packObj setObject:[obj valueForKey:@"duration_in_days"] forKey:@"coursePackDuration"];
            [packObj setObject:[obj valueForKey:@"is_block"] forKey:@"coursePackBlock"];
            [packObj setObject:[obj valueForKey:@"product"] forKey:@"coursePackDesc"];
            if([obj valueForKey:@"device_status"] != NULL)
                [packObj setObject:[obj valueForKey:@"device_status"] forKey:@"deviceStatus"];
            else
                [packObj setObject:@"1" forKey:@"deviceStatus"];
            
            if([obj valueForKey:@"platform_status"] != NULL)
                [packObj setObject:[obj valueForKey:@"platform_status"] forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
            else
                [packObj setObject:@"1" forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
            
            NSDate *date = [NSDate date];
            [packObj setObject:[[NSString alloc] initWithFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]] forKey:@"date"];
            
            [packObj setObject:[obj valueForKey:@"package_code"] forKey:@"coursePackCode"];
            NSString * query1 = [self insertQueryConverter:packObj :DATABASE_TABLE_COURSEPACKTABLE];
            [dataObj insertQuery:query1];
        }
        else{
            [packObj setObject:[obj valueForKey:@"duration_in_days"] forKey:@"coursePackDuration"];
            [packObj setObject:[obj valueForKey:@"is_block"] forKey:@"coursePackBlock"];
            [packObj setObject:[obj valueForKey:@"product"] forKey:@"coursePackDesc"];
            
            
            if([obj valueForKey:@"device_status"] != NULL)
                [packObj setObject:[obj valueForKey:@"device_status"] forKey:@"deviceStatus"];
            else
                [packObj setObject:@"1" forKey:@"deviceStatus"];
            
            
            if([obj valueForKey:@"platform_status"] != NULL)
                [packObj setObject:[obj valueForKey:@"platform_status"] forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
            else
                [packObj setObject:@"1" forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
            
            
            NSDate *date = [NSDate date];
            [packObj setObject:[[NSString alloc] initWithFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]] forKey:@"date"];
            
            
            NSString * query2 = [self updateQueryConverter:packObj :DATABASE_TABLE_COURSEPACKTABLE :@"coursePackCode" :[obj valueForKey:@"package_code"]];
            [dataObj updateQuery:query2];
        }
        
        
        
        
        
        
        
        
    }
    return true;
}

-(BOOL)updateCoursePackData:(NSArray *)coursepackArr 
{
    
    
    for (NSDictionary *obj in coursepackArr) {
        
        NSMutableDictionary * packObj = [[NSMutableDictionary alloc]init];
        [packObj setObject:[obj valueForKey:@"package_code"] forKey:DATABASE_COURSEPACK_COURSEPACKCODE];
        [packObj setObject:[obj valueForKey:@"product_code"] forKey:DATABASE_COURSEPACK_PRODUCTCODE];
        [packObj setObject:[obj valueForKey:@"product"] forKey:DATABASE_COURSEPACK_COURSEPACKDESCRIPTION];
        [packObj setObject:[obj valueForKey:@"duration_in_days"] forKey:DATABASE_COURSEPACK_COURSEPACKDURATION];
        [packObj setObject:@"1" forKey:DATABASE_COURSEPACK_COURSEPACKBLOCK];
        if([obj valueForKey:@"device_status"] != NULL)
            [packObj setObject:[obj valueForKey:@"device_status"] forKey:DATABASE_COURSEPACK_DEVICESTATUS];
        else
            [packObj setObject:@"1" forKey:DATABASE_COURSEPACK_DEVICESTATUS];
        
        if([obj valueForKey:@"platform_status"] != NULL)
            [packObj setObject:[obj valueForKey:@"platform_status"] forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
        else
            [packObj setObject:@"1" forKey:DATABASE_COURSEPACK_PLATFORMSTATUS];
        
        NSDate *date = [NSDate date];
        [packObj setObject:[[NSString alloc] initWithFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]] forKey:@"date"];
        
        NSArray *_coureArr = (NSArray *)[obj valueForKey:@"courses"];
        if(_coureArr != NULL && _coureArr != [NSNull null] && [_coureArr count] > 0){
            
            if([[[_coureArr objectAtIndex:0]valueForKey:@"CourseArr"] valueForKey:@"courseData"]!= NULL && [[[_coureArr objectAtIndex:0]valueForKey:@"CourseArr"]valueForKey:@"courseData"] != [NSNull null] && [[[[_coureArr objectAtIndex:0]valueForKey:@"CourseArr"]valueForKey:@"courseData"] count] > 0)
            {
                
                for (NSDictionary *courseObj in _coureArr) {
                    NSMutableDictionary * _catObj = [[NSMutableDictionary alloc]init];
                    
                    [_catObj setObject:[courseObj valueForKey:@"categoryID"] forKey:@"categoryId"];
                    [_catObj setObject:[courseObj valueForKey:@"categoryName"] forKey:@"categoryName"];
                    [_catObj setObject:[obj valueForKey:@"package_code"] forKey:@"coursePackCode"];
                    NSString * query = [self insertQueryConverter:_catObj :DATABASE_TABLE_CATEGORY];
                    [dataObj insertQuery:query];
                    NSArray *_coursesArr = (NSArray *)[[courseObj valueForKey:@"CourseArr"]valueForKey:@"courseData"];
                    for (NSDictionary *innerCourseObj in _coursesArr) {
                        NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
                        
                        [_Obj setObject:[innerCourseObj valueForKey:@"edgeID"] forKey:@"cEdgeID"];
                        [_Obj setObject:[innerCourseObj valueForKey:@"name"] forKey:@"name"];
                        [_Obj setObject:[innerCourseObj valueForKey:@"courseID"] forKey:@"data"];
                        [_Obj setObject:[innerCourseObj valueForKey:@"desc"] forKey:@"desc"];
                        if([innerCourseObj valueForKey:@"level_text"] != NULL && ![[innerCourseObj valueForKey:@"level_text"] isEqual:[NSNull null]])
                        {
                            
                            [_Obj setObject:[innerCourseObj valueForKey:DATABASE_COURSE_LEVELCEFRMAP] forKey:DATABASE_COURSE_LEVELCEFRMAP];
                            [_Obj setObject:[innerCourseObj valueForKey:DATABASE_COURSE_LEVELDESC] forKey:DATABASE_COURSE_LEVELDESC];
                            [_Obj setObject:[innerCourseObj valueForKey:DATABASE_COURSE_LEVELTEXT] forKey:DATABASE_COURSE_LEVELTEXT];
                            [_Obj setObject:[innerCourseObj valueForKey:DATABASE_COURSE_STANDERD] forKey:DATABASE_COURSE_STANDERD];
                            
                            
                        }
                        else
                        {
                            [_Obj setObject:@"-1" forKey:DATABASE_COURSE_LEVELCEFRMAP];
                            [_Obj setObject:@"-1" forKey:DATABASE_COURSE_LEVELDESC];
                            [_Obj setObject:@"-1" forKey:DATABASE_COURSE_LEVELTEXT];
                            [_Obj setObject:@"-1" forKey:DATABASE_COURSE_STANDERD];
                            
                        }
                        
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        
                        
                        
                        if([innerCourseObj valueForKey:@"version"]!= nil)
                        {
                            [_Obj setObject:[innerCourseObj valueForKey:@"version"] forKey:@"version"];
                        }
                        else
                        {
                            [_Obj setObject:@"0"forKey:@"version"];
                        }
                        
                        [_Obj setObject:[innerCourseObj valueForKey:@"imgPath"] forKey:@"imgPath"];
                        [_Obj setObject:[[NSString alloc] initWithFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]] forKey:@"writeTime"];
                        NSString * query = [self insertQueryConverter:_Obj :DATABASE_TABLE_COURSETABLE];
                        [dataObj insertQuery:query];
                        NSMutableDictionary * _mapObj = [[NSMutableDictionary alloc]init];
                        
                        [_mapObj setObject:[innerCourseObj valueForKey:@"edgeID"] forKey:@"cEdgeID"];
                        [_mapObj setObject:[obj valueForKey:@"package_code"] forKey:@"CoursePackCode"];
                        NSString * query1 = [self insertQueryConverter:_mapObj :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
                        [dataObj insertQuery:query1];
                        
                        
                        
                        
                        
                        NSMutableDictionary * _catmapObj = [[NSMutableDictionary alloc]init];
                        
                        [_catmapObj setObject:[courseObj valueForKey:@"categoryID"] forKey:@"categoryId"];
                        [_catmapObj setObject:[innerCourseObj valueForKey:@"edgeID"] forKey:@"cEdgeID"];
                        [_catmapObj setObject:[obj valueForKey:@"package_code"] forKey:@"CoursePackCode"];
                        
                        // [mapArr addObject:_mapObj];
                        
                        
                        NSString * query2 = [self insertQueryConverter:_catmapObj :DATABASE_TABLE_CATEGORYCOURSEMAPPING];
                        [dataObj insertQuery:query2];
                    }
                }
            }
            else
            {
                for (NSDictionary *courseObj in _coureArr) {
                    if((NSString *)[NSNull null] != [[courseObj valueForKey:@"CourseArr"] valueForKey:@"courseData"]){
                        NSMutableDictionary * _Obj = [[NSMutableDictionary alloc]init];
                        
                        [_Obj setObject:[courseObj valueForKey:@"edgeID"] forKey:@"cEdgeID"];
                        [_Obj setObject:[courseObj valueForKey:@"name"] forKey:@"name"];
                        [_Obj setObject:[courseObj valueForKey:@"courseID"] forKey:@"data"];
                        [_Obj setObject:[courseObj valueForKey:@"desc"] forKey:@"desc"];
                        
                        [_Obj setObject:[courseObj valueForKey:DATABASE_COURSE_LEVELCEFRMAP] forKey:DATABASE_COURSE_LEVELCEFRMAP];
                        [_Obj setObject:[courseObj valueForKey:DATABASE_COURSE_LEVELDESC] forKey:DATABASE_COURSE_LEVELDESC];
                        [_Obj setObject:[courseObj valueForKey:DATABASE_COURSE_LEVELTEXT] forKey:DATABASE_COURSE_LEVELTEXT];
                        [_Obj setObject:[courseObj valueForKey:DATABASE_COURSE_STANDERD] forKey:DATABASE_COURSE_STANDERD];
                        
                        
                        if([courseObj valueForKey:@"version"]!= nil)
                        {
                            [_Obj setObject:[courseObj valueForKey:@"version"] forKey:@"version"];
                        }
                        else
                        {
                            [_Obj setObject:@"0"forKey:@"version"];
                        }
                        
                        [_Obj setObject:[courseObj valueForKey:@"imgPath"] forKey:@"imgPath"];
                        
                        
                        
                        [_Obj setObject:[[NSString alloc] initWithFormat:@"%@",[NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]]] forKey:@"writeTime"];
                        
                        // [courseArr addObject:_Obj];
                        NSString * query = [self insertQueryConverter:_Obj :DATABASE_TABLE_COURSETABLE];
                        [dataObj insertQuery:query];
                        
                        
                        
                        NSMutableDictionary * _mapObj = [[NSMutableDictionary alloc]init];
                        
                        [_mapObj setObject:[courseObj valueForKey:@"edgeID"] forKey:@"cEdgeID"];
                        [_mapObj setObject:[obj valueForKey:@"package_code"] forKey:@"CoursePackCode"];
                        
                        // [mapArr addObject:_mapObj];
                        
                        
                        NSString * query1 = [self insertQueryConverter:_mapObj :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
                        [dataObj insertQuery:query1];
                        
                    }
                }
            }
        }
        
        
        NSString * query2 = [self insertQueryConverter:packObj :DATABASE_TABLE_COURSEPACKTABLE];
        [dataObj insertQuery:query2];
        
        //[packArr addObject:packObj];
    }
    
    
    
    return TRUE;
}

-(BOOL)updateComponant:(NSString *)edgeId
{
    NSMutableDictionary *muComponant = [[NSMutableDictionary alloc]init];
    [Logger logAduro:@"DataManagement : start Function updateComponant" ];
    if(edgeId != NULL )
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *componant = [defaults objectForKey:@"componant"];
        if(componant != NULL)
        {
            for( int i =0 ;i< [[componant allKeys] count] ; i++ )
            {
                NSString *aKey = [[componant allKeys] objectAtIndex:i];
                if(aKey != NULL)
                {
                    [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[componant valueForKey:aKey]] forKey:aKey];
                    
                }
            }
        }
        [muComponant setValue:ZERO forKey:edgeId];
        [defaults setObject:muComponant forKey:@"componant"];
        [defaults synchronize];
        
    }
    
    return TRUE;
    [Logger logAduro:@"DataManagement : End Function updateComponant" ];
    
    
}


-(BOOL)updateAllComponant:(NSArray*)data
{
    NSMutableDictionary *muComponant = [[NSMutableDictionary alloc]init];
    [Logger logAduro:@"DataManagement : start Function updateAllComponant" ];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *componant = [defaults objectForKey:@"componant"];
    if(componant != NULL)
    {
        for( int i =0 ;i< [[componant allKeys] count] ; i++ )
        {
            NSString *aKey = [[componant allKeys] objectAtIndex:i];
            if(aKey != NULL)
            {
                [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[componant valueForKey:aKey]] forKey:aKey];
                
            }
        }
    }
    for (NSDictionary * obj in data) {
        
        [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:HTML_JSON_KEY_ACTION] ] forKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:HTML_JSON_KEY_EDGEID] ]];
        
        [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:HTML_JSON_KEY_VERSION] ] forKey:[[NSString alloc]initWithFormat:@"%@",[obj valueForKey:HTML_JSON_KEY_COURSECODE] ]];
        if([obj valueForKey:HTML_JSON_KEY_CHAPTERS] != NULL && [[obj valueForKey:HTML_JSON_KEY_CHAPTERS] count] > 0  )
        {
            for (NSDictionary * _obj in [obj valueForKey:HTML_JSON_KEY_CHAPTERS]) {
                
                if([[_obj valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:THREE] )
                {
                    [self deleteScenario:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID]] deleteDirectory:TRUE deleteZip:TRUE];
                    [muComponant removeObjectForKey:[_obj valueForKey:HTML_JSON_KEY_EDGEID]];
                }
                else if([[_obj valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:TWO])
                {
                    
                    int val = [self isDownloaded:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID]]];
                    
                    if(val == 2 )
                    {
                        [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_ACTION]] forKey:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID] ]];
                    }
                    else if(val == 1)
                    {
                        [muComponant setValue:@"1" forKey:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID] ]];
                    }
                    else if(val == 0)
                    {
                        [muComponant setValue:@"0" forKey:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID] ]];
                    }
                    
                }
                else if([[_obj valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:ONE])
                {
                    
                    [muComponant setValue:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_ACTION]] forKey:[[NSString alloc]initWithFormat:@"%@",[_obj valueForKey:HTML_JSON_KEY_EDGEID] ]];
                }
                else if([[_obj valueForKey:HTML_JSON_KEY_ACTION]isEqualToString:ZERO])
                {
                    
                }
                
                
            }
        }
    }
    [defaults setObject:muComponant forKey:@"componant"];
    [defaults synchronize];
    
    
    
    return TRUE;
    [Logger logAduro:@"DataManagement : End Function updateAllComponant" ];
}

-(BOOL)setCourseCode:(NSString *)_courseCode
{
    appDelegate.courseCode = _courseCode;
    return TRUE;
}



-(BOOL)setImage:(int)isLocal
{
    NSString * query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%d' where rowid = 1;",DATABASE_TABLE_USERINFO,DATABASE_ISIMAGECAPTURE,isLocal];
    [Logger logAduro:query];
    return [dataObj updateQuery:query];
}

-(BOOL)updateUser:(NSString *)user_id :(NSString *)token :(NSString *)profilePic
{
    NSString * query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@', %@ = '%@', %@ = '%@'   where rowid = 1;",DATABASE_TABLE_USERINFO,DATABASE_USERID,user_id,DATABASE_TOKEN,token,DATABASE_PROFILEPIC,profilePic];
    [Logger logAduro:query];
    return [dataObj updateQuery:query];
}

-(BOOL)setUserInfo:(NSMutableDictionary *)userDic
{
    
    return [dataObj insertQuery:[self insertQueryConverter:[self convertParserObjToDatabaseObj:userDic table:DATABASE_TABLE_USERINFO]:DATABASE_TABLE_USERINFO]];
}




-(BOOL)setIRPullData :(NSDictionary *)IRData
{
    [Logger logAduro:@"DataManagement : strat Function insertIRData"];
    NSArray  * dataArr = [IRData valueForKey:JSON_AVGIRARRAY];
    NSString * maxIR = [IRData valueForKey:JSON_MAXIR] ;
    
    NSString *query = @"SELECT * from PullIrTable;";
    NSArray * dataArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_PULLIRTABLE];
    //NSArray * dataArr = [databaseData valueForKey:DATABASE_LOCAL_DATA];
    if([dataArray count] >0)
    {
        // update
        for (NSMutableDictionary * avgDict in dataArr) {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:avgDict table:DATABASE_TABLE_PULLIRTABLE];
            
            NSString * query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@',%@ = '%@',%@ = '%@'  WHERE %@ = '%@' ",DATABASE_TABLE_PULLIRTABLE,DATABASE_PULLIR_MAXIR,maxIR,DATABASE_PULLIR_AVGIR,[testDictionary valueForKey:DATABASE_PULLIR_AVGIR],DATABASE_PULLIR_TIME,[testDictionary valueForKey:DATABASE_PULLIR_TIME],DATABASE_PULLIR_EDGEID,[testDictionary valueForKey:DATABASE_PULLIR_EDGEID]];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
        }
    }
    else{
        
        for (NSMutableDictionary * avgDict in dataArr) {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:avgDict table:DATABASE_TABLE_PULLIRTABLE];
            [testDictionary setValue:maxIR forKey:DATABASE_PULLIR_MAXIR];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PULLIRTABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
        }
        
    }
    
    [Logger logAduro:@"DataManagement : End Function insertIRData"];
    return TRUE;
    
}

-(BOOL)setPracticeOrAssissmentData :(NSDictionary *)strData edgeId:(NSString *)edgeId :(NSString *)pack
{
    
    if(strData != NULL)
    {
        if(![UISTANDERD isEqualToString:@"PRODUCT2"]){
            NSString * textQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = '%@'",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_EDGEID,edgeId];
            [Logger logDebug:textQuery];
            [dataObj deleteQuery:textQuery];
        }
        
        
        for (NSMutableDictionary * AssissPracticeDict in [strData valueForKey:HTML_JSON_KEY_PARAM])
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:AssissPracticeDict table:DATABASE_TABLE_TESTTABLE];
            [testDictionary setValue:pack forKey:DATABASE_TEST_COURSEPACK];
            [testDictionary setValue:[strData valueForKey:HTML_JSON_KEY_EDGEID]forKey:DATABASE_TEST_EDGEID];
            [testDictionary setValue:[strData valueForKey:HTML_JSON_KEY_SCORE] forKey:DATABASE_TEST_SCORE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_TESTTABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
        }
        
        
        NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES ('%@',%@,%@,'%@','%@')",DATABASE_TABLE_ATTEMPTCOUNTER,DATABASE_ATTEMPTCOUNTER_EDGEID,DATABASE_TEST_ATTEMPT_ID,DATABASE_ATTEMPTCOUNTER_TEST_TYPE,DATABASE_ATTEMPTCOUNTER_COURSE_CODE,DATABASE_ATTEMPTCOUNTER_COURSEPACK,[strData valueForKey:@"edgeId"],[strData valueForKey:@"attempt_id"],[strData valueForKey:@"type_of_test"],[strData valueForKey:@"course_code"],[strData valueForKey:@"package_code"] ];
        [Logger logDebug:queryStr];
        [dataObj insertQuery:queryStr];
        
        
    }
    
    return TRUE;
}


-(BOOL)setTrackSyncTime:(NSString *)syncTime
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"UPDATE %@ SET %@ = %@  WHERE rowid =1 ",DATABASE_TABLE_TRACKSYNCTIME,DATABASE_TRACKSYNCTIME_TIME,syncTime ];
    [Logger logAduro:strfmt];
    return [dataObj updateQuery:strfmt];
    
}


-(BOOL)setUpdateVersion:(int)version
{
    NSString * strfmtscore = [[NSString alloc]initWithFormat:@"UPDATE  %@ SET %@ = '%d' where rowid = 1;",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_VER,version];
    return [dataObj updateQuery:strfmtscore];
}





#pragma mark -    SERVICE  API's



-(void)initialise
{
    [Logger logAduro:@"DataManagement : start Function initialise" ];
    
    NSString *query = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_CONVERSATIONTABLE];
    // NSString *query = @"SELECT * from ConversationTable;";
    NSArray * dictArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CONVERSATIONTABLE];
    if(dictArray != NULL)
    {
        self.unitCount = [dictArray count];
    }
    
    
    [Logger logAduro:@"DataManagement : end Function initialise" ];
}


-(BOOL)isCourseExist:(NSString *)course_edgeId
{
    BOOL returnVal = NO;
    
    if ([course_edgeId isEqualToString:@""]) {}
    else
    {
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@' ",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,course_edgeId];
        NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_CATLOGCONTENTTABLE];
        if([courseArr count] >0) returnVal = YES;
    }
    return returnVal;
    
}

-(BOOL)coursePackExistorNot:(NSString *)_coursePack
{
    BOOL returnVal = TRUE;
    
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSEPACKTABLE];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSEPACKTABLE];
    for (NSDictionary * obj in courseArr) {
        if([[obj valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE]isEqualToString:_coursePack]) return false;
    }
    return returnVal;
    
}




-(BOOL)DeleteCourseXmlDataFromDataFromDatabase:(NSString *)deleteCode deleteDirectory:(BOOL)isDelete
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,deleteCode];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    NSDictionary * obj =  [courseArr objectAtIndex:0];
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
    
    NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    for (NSDictionary * obj1 in catDataArray) {
        
        NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]];
        
        NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
        if(scnDataArray != NULL)
        {
            for (NSDictionary * exObj in scnDataArray) {
                
                
                
                
                if(isDelete)[self DeleteVcb_Scn_XmlDataFromDataFromDatabase:[exObj valueForKey:DATABASE_SCENARIO_EDGEID]deleteDirectory:FALSE directoryPath:nil];
                
                
                NSString * delScnQuery =[[NSString alloc]initWithFormat:@"DELETE from ScenarioTable where %@ = %@",DATABASE_SCENARIO_CEDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                
                [dataObj deleteQuery:delScnQuery]; // Clean Scenario Table
                
                
                
                
                
            }
        }
        
        
        
        NSString * delQuery =[[NSString alloc]initWithFormat:@"DELETE from CatLogContentTable where %@ = %@",DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
        
        [dataObj deleteQuery:delQuery];
        // Clean CatLogContentTable Table
        
    }
    
    [self deleteFromTrackTable:deleteCode];
    
    NSString * strfmtMain = [[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,deleteCode];
    if([dataObj deleteQuery:strfmtMain] )
    {
        NSString *courseFilePath = [ROOTFOLDERNAME stringByAppendingPathComponent:deleteCode];
        //NSString *VocabFilePath = [ROOTFOLDERNAME stringByAppendingPathComponent:VOCABLARYZIPNAME];
        
        if([self deleteFolderFiles:courseFilePath :isDelete])
        {
            return TRUE;
        }
        
        
    }
    
    //    NSString * strVocab = [[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_COURSE_CODE,deleteCode];
    //    NSString * strfmtMain = [[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,deleteCode];
    //    if( [dataObj deleteQuery:strVocab] && [dataObj deleteQuery:strfmtMain] )
    //    {
    //        NSString *courseFilePath = [ROOTFOLDERNAME stringByAppendingPathComponent:deleteCode];
    //        NSString *VocabFilePath = [ROOTFOLDERNAME stringByAppendingPathComponent:VOCABLARYZIPNAME];
    //
    //        if([self deleteFolderFiles:courseFilePath :isDelete] && [self deleteFolderFiles:VocabFilePath :TRUE])
    //        {
    //            return TRUE;
    //        }
    //
    //
    //    }
    
    
    return TRUE;
}


-(BOOL)deleteFolderFiles:(NSString *)pathstr :(BOOL)isDelete
{
    if(isDelete)
    {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:pathstr];
        NSError *error;
        [fileManager removeItemAtPath:filePath error:&error];
        return TRUE;
    }
    else
    {
        return TRUE;
    }
    return TRUE;
}

-(BOOL)DeleteVcb_Scn_XmlDataFromDataFromDatabase:(NSString *)edgeId deleteDirectory:(BOOL)isDelete directoryPath:(NSString *)scnDirPath
{
    
    
    
    
    NSString * exQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_CEDGEID,edgeId];
    
    NSArray * exArray  = [dataObj SelecteQuery:exQuery Table:DATABASE_TABLE_EXERCISETABLE];
    if(exArray != NULL)
    {
        for (NSDictionary * practiceObj in exArray)
        {
            
            NSString * pracQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_CEDGEID,[practiceObj valueForKey:DATABASE_PRACTICE_CEDGEID]];
            
            NSArray * pracArray  = [dataObj SelecteQuery:pracQuery Table:DATABASE_TABLE_PRACTICETABLE];
            if(pracArray != NULL)
            {
                for (NSDictionary * converSationObj in pracArray) {
                    
                    NSString * convserQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CONVERSATIONTABLE,DATABASE_CONVERSATION_CEDGEID,[converSationObj valueForKey:DATABASE_PRACTICE_EDGEID]];
                    
                    NSArray * conversationArray  = [dataObj SelecteQuery:convserQuery Table:DATABASE_TABLE_CONVERSATIONTABLE];
                    
                    if(conversationArray != NULL)
                    {
                        for (NSDictionary * Obj in conversationArray) {
                            
                            NSString * questQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@'",DATABASE_TABLE_QUESTION,DATABASE_QUESTION_CONUNITID,[Obj valueForKey:DATABASE_CONVERSATION_EDGEID]];
                            
                            NSArray * questArray  = [dataObj SelecteQuery:questQuery Table:DATABASE_TABLE_QUESTION];
                            if(questArray != NULL)
                            {
                                for (NSDictionary * ObjText in questArray)
                                {
                                    
                                    NSString * textQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = '%@'",DATABASE_TABLE_TEXTSEGMENT,DATABASE_TEXTSEGMENT_TEXTID,[ObjText valueForKey:DATABASE_QUESTION_EDGEID]];
                                    [dataObj deleteQuery:textQuery];
                                    
                                    NSString * deleteQuestQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = '%@'",DATABASE_TABLE_QUESTION,DATABASE_QUESTION_CONUNITID,[Obj valueForKey:DATABASE_CONVERSATION_EDGEID]];
                                    
                                    [dataObj deleteQuery:deleteQuestQuery];
                                }
                            }
                            
                            
                            
                            NSString * ansQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@'",DATABASE_TABLE_ANSWER,DATABASE_ANSWER_CONUNITID,[Obj valueForKey:DATABASE_CONVERSATION_EDGEID]];
                            
                            NSArray * AnsArray  = [dataObj SelecteQuery:ansQuery Table:DATABASE_TABLE_ANSWER];
                            if(AnsArray != NULL)
                            {
                                for (NSDictionary * ObjText1 in AnsArray) {
                                    
                                    NSString * textQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = '%@'",DATABASE_TABLE_TEXTSEGMENT,DATABASE_TEXTSEGMENT_TEXTID,[ObjText1 valueForKey:DATABASE_ANSWER_EDGEID]];
                                    
                                    [dataObj deleteQuery:textQuery];
                                    
                                    
                                    NSString * deleteAnsQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = '%@'",DATABASE_TABLE_ANSWER,DATABASE_ANSWER_CONUNITID,[Obj valueForKey:DATABASE_CONVERSATION_EDGEID]];
                                    
                                    [dataObj deleteQuery:deleteAnsQuery];
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                    NSString * delConvserQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = %@",DATABASE_TABLE_CONVERSATIONTABLE,DATABASE_CONVERSATION_CEDGEID,[converSationObj valueForKey:DATABASE_PRACTICE_EDGEID]];
                    [dataObj deleteQuery:delConvserQuery];
                    
                    
                    NSString * delVocabuQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = %@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID,[converSationObj valueForKey:DATABASE_PRACTICE_EDGEID]];
                    [dataObj deleteQuery:delVocabuQuery];
                    
                    
                    
                    
                }
                NSString * deletePracQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = %@",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_CEDGEID,[practiceObj valueForKey:DATABASE_EXERCISE_EDGEID]];
                
                [dataObj deleteQuery:deletePracQuery]; // Clean Practice  Table
            }
            
        }
        
        NSString * delExQuery =[[NSString alloc]initWithFormat:@"DELETE from %@ where %@ = %@",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_CEDGEID,edgeId];
        
        [dataObj deleteQuery:delExQuery]; // Clean Excercise  Table
    }
    
    
    
    return TRUE;
}


-(BOOL)deleteCourseCode:(NSString *)deleteCode deleteDirectory:(BOOL)isDelete
{
    return [self DeleteCourseXmlDataFromDataFromDatabase:deleteCode deleteDirectory:isDelete];
    
}


-(BOOL)deleteScenario:(NSString *)edgeId deleteDirectory:(BOOL)isDelete deleteZip:(BOOL)_isDelete
{
    
    
    NSString * dirPath = @"";
    NSString* course;
    NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,edgeId];
    NSString * fileName;
    
    NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
    if(scnDataArray != NULL && [scnDataArray count] >0  )
    {
        dirPath = [[scnDataArray objectAtIndex:0] valueForKey:DATABASE_SCENARIO_DATA];
        [self DeleteVcb_Scn_XmlDataFromDataFromDatabase:edgeId deleteDirectory:isDelete directoryPath:dirPath];
        fileName = [self getZipfileName:[edgeId intValue] :DATABASE_CATTYPE_SCENARIO];
        
    }
    else
    {
        NSString * catQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_EDGEID,edgeId];
        
        NSArray * catArray  = [dataObj SelecteQuery:catQuery Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        
        if(catArray != NULL && [catArray count] >0)
        {
            dirPath = [[catArray objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_DATA];
            fileName = [self getZipfileName:[edgeId intValue] :DATABASE_CATTYPE_ASSISMENT_XML];
            
            
        }
        
    }
    NSArray* componentArray = [dirPath componentsSeparatedByString: @"/"];
    if(componentArray != NULL && [componentArray count] > 1)
    {
        course = [componentArray objectAtIndex:1];
        
        [self deleteFolderFiles:dirPath :isDelete];
        
        NSString * zipName = [[NSString alloc]initWithFormat:@"%@",fileName];
        NSString * dataPath1 = [ROOTFOLDERNAME stringByAppendingPathComponent:course];
        dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
        dataPath1 = [dataPath1 stringByAppendingPathComponent:zipName];
        [self deleteFolderFiles:dataPath1 :_isDelete];
        
    }
    
    
    
    return TRUE;
}



#pragma mark -    LOCAL API's

-(BOOL)fillSegmentDataIntable:(NSMutableArray *)unitArray
{
    [Logger logAduro:@"DataManagement : Start Function fillUnitDataIntable" ];
    if(unitArray != NULL)
    {
        for(int unitCount = 0; unitCount < [unitArray count] ;unitCount ++)
        {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[unitArray objectAtIndex:unitCount] table:DATABASE_TABLE_TEXTSEGMENT];
            
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_TEXTSEGMENT];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillUnitDataIntable" ];
    return TRUE;
    
}

-(BOOL)fillUnitDataIntable:(NSMutableArray *)unitArray :(NSString *)catType
{
    [Logger logAduro:@"DataManagement : Start Function fillUnitDataIntable" ];
    if(unitArray != NULL)
    {
        for(int unitCount = 0; unitCount < [unitArray count] ;unitCount ++)
        {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[unitArray objectAtIndex:unitCount] table:DATABASE_TABLE_CONVERSATIONTABLE];
            [testDictionary setValue:catType forKey:DATABASE_CONVERSATION_CATTYPE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_CONVERSATIONTABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillUnitDataIntable" ];
    return TRUE;
    
}
-(BOOL)fillQuestionDataIntable:(NSMutableArray *)questionArray
{
    [Logger logAduro:@"DataManagement : Start Function fillQuestionDataIntable" ];
    if(questionArray != NULL)
    {
        for(int quesCount = 0; quesCount < [questionArray count] ;quesCount ++)
        {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[questionArray objectAtIndex:quesCount] table:DATABASE_TABLE_QUESTION];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_QUESTION];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillQuestionDataIntable" ];
    return TRUE;
    
}
-(BOOL)fillansDataIntable:(NSMutableArray *)ansArray
{
    [Logger logAduro:@"DataManagement : Start Function fillansDataIntable" ];
    if(ansArray != NULL)
    {
        for(int ansCount = 0; ansCount < [ansArray count] ;ansCount ++)
        {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[ansArray objectAtIndex:ansCount] table:DATABASE_TABLE_ANSWER];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_ANSWER];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillansDataIntable" ];
    return TRUE;
    
}
-(BOOL)fillVocabularyDataIntable:(NSMutableArray *)vocabularyArray
{
    [Logger logAduro:@"DataManagement : Start Function fillVocabularyDataIntable" ];
    if(vocabularyArray != NULL)
    {
        for(int vocabCount = 0; vocabCount < [vocabularyArray count] ;vocabCount ++)
        {
            
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[vocabularyArray objectAtIndex:vocabCount] table:DATABASE_TABLE_VOCABWORD];
            [testDictionary setValue:appDelegate.courseCode forKey:DATABASE_VOCABWORD_COURSE_CODE];
            [testDictionary setValue:@"0" forKey:DATABASE_VOCABWORD_ISCOMP];
            
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_VOCABWORD];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillVocabularyDataIntable" ];
    return TRUE;
    
}







-(NSDictionary *)getEdgeId:(NSMutableArray *)arr  parentId:(NSString *)parentUid
{
    for (NSMutableDictionary *dictionary in arr) {
        if([[dictionary valueForKey:PEDGEID] integerValue]  ==  [parentUid integerValue])
        {
            return dictionary;
        }
    }
    return NULL;
}


-(NSString *)getCurrentTime
{
    NSDate *date = [NSDate date];
    return [NSString stringWithFormat: @"%lld",[@(floor([date timeIntervalSince1970] * 1000)) longLongValue]];
}




-(BOOL)fillScnarioPracticeDataIntable:(NSMutableArray *)scenario_practiceArray :(NSMutableArray *)watchArray :(NSMutableArray *)enactArray :(NSMutableArray *)reviewArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillScnarioPracticeDataIntable" ];
    if(scenario_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [scenario_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            
            NSDictionary *watchDict = [self getEdgeId:watchArray parentId:[[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount]valueForKey:EDGEID]];
            
            NSDictionary *enactDict = [self getEdgeId:enactArray parentId:[[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount]valueForKey:EDGEID]];
            
            NSDictionary *reviewDict = [self getEdgeId:reviewArray parentId:[[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount]valueForKey:EDGEID]];
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_SCNPRACTABLE :watchDict :enactDict :reviewDict];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillScnarioPracticeDataIntable" ];
    return TRUE;
}

-(BOOL)fillVocabPracticeDataIntable:(NSMutableArray *)scenario_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillVocabPracticeDataIntable" ];
    if(scenario_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [scenario_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_VCBPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillVocabPracticeDataIntable" ];
    return TRUE;
}


-(BOOL)fillMCQPracticeDataIntable:(NSMutableArray *)scenario_practiceArray
{
    
    [Logger logAduro:@"DataManagement : Start Function fillMCQPracticeDataIntable" ];
    if(scenario_practiceArray != NULL)
    {
        for(int scenario_practiceArrayCount = 0; scenario_practiceArrayCount < [scenario_practiceArray count] ;scenario_practiceArrayCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[scenario_practiceArray objectAtIndex:scenario_practiceArrayCount] table:DATABASE_TABLE_MCQPRACTABLE];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_PRACTICETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillMCQPracticeDataIntable" ];
    return TRUE;
}






-(BOOL)fillVocabWordDataIntable:(NSMutableArray *)VocabWordArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillVocabWordDataIntable" ];
    if(VocabWordArr != NULL)
    {
        for(int vocabWordCount = 0; vocabWordCount < [VocabWordArr count] ;vocabWordCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[VocabWordArr objectAtIndex:vocabWordCount] table:DATABASE_TABLE_VOCABWORD];
            [testDictionary setValue:appDelegate.courseCode forKey:DATABASE_VOCABWORD_COURSE_CODE];
            [testDictionary setValue:@"0" forKey:DATABASE_VOCABWORD_ISCOMP];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_VOCABWORD];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillConceptDataIntable" ];
    return TRUE;
}

-(BOOL)fillConceptDataIntable:(NSMutableArray *)conceptArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillConceptDataIntable" ];
    if(conceptArr != NULL)
    {
        for(int conceptCount = 0; conceptCount < [conceptArr count] ;conceptCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[conceptArr objectAtIndex:conceptCount] table:DATABASE_TABLE_CONCEPT_N];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_EXERCISETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillConceptDataIntable" ];
    return TRUE;
}




-(BOOL)fillActivityDataIntable:(NSMutableArray *)ActivityArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillActivityDataIntable" ];
    if(ActivityArr != NULL)
    {
        for(int activityCount = 0; activityCount < [ActivityArr count] ;activityCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[ActivityArr objectAtIndex:activityCount] table:DATABASE_TABLE_ACTIVITYTABLE ];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_EXERCISETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillActivityDataIntable" ];
    return TRUE;
}




-(BOOL)fillpracticeDataIntable:(NSMutableArray *)practiceArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillpracticeDataIntable" ];
    if(practiceArr != NULL)
    {
        for(int practiceCount = 0; practiceCount < [practiceArr count] ;practiceCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[practiceArr objectAtIndex:practiceCount] table:DATABASE_TABLE_PRACTICE_N ];
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_EXERCISETABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillpracticeDataIntable" ];
    return TRUE;
}







-(BOOL)fillCourseDataIntable:(NSMutableArray *)courseArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillCourseDataIntable" ];
    if(courseArr != NULL )
    {
        for(int courseCount = 0; courseCount < [courseArr count] ;courseCount ++)
        {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[courseArr objectAtIndex:courseCount] table:DATABASE_TABLE_COURSETABLE ];
            NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"T%@",appDelegate.courseCode];
            [appDelegate setUserDefaultData:[[NSString alloc] initWithFormat:@"%@",[[courseArr objectAtIndex:courseCount] valueForKey:DURATION]] :str];
            
            NSString * courseQuery = [[NSString alloc]initWithFormat:@"SELECT * from CourseTable WHERE data ='%@'",appDelegate.courseCode];
            NSMutableArray * courseArr = [dataObj SelecteQuery:courseQuery Table:@"CourseTable"];
            if([courseArr count] == 0)
            {
                NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_COURSETABLE];
                [Logger logDebug:query];
                [dataObj insertQuery:query];
            }
            else
            {
                NSString * _LcourseCode = [testDictionary valueForKey:DATABASE_COURSE_DATA];
                [testDictionary removeObjectForKey:DATABASE_COURSE_IMGPATH];
                [testDictionary removeObjectForKey:DATABASE_COURSE_DATA];
                NSString * loacalQuery = [self updateQueryConverter:testDictionary :DATABASE_TABLE_COURSETABLE :DATABASE_COURSE_DATA:_LcourseCode];
                [dataObj updateQuery:loacalQuery];
                
            }
            
        }
    }
    [Logger logAduro:@"DataManagement : End Function fillCourseDataIntable" ];
    return TRUE;
}

-(BOOL)fillModuleDataIntable:(NSMutableArray *)moduleArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillModuleDataIntable" ];
    if(moduleArr != NULL)
    {
        NSLog(@"Assessment Data %@",moduleArr);
        
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *data in moduleArr) {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:data table:DATABASE_TABLE_CATLOGCONTENTTABLE];
            [arr addObject:testDictionary];
        }
        
        NSString * query = [self ArrayinsertQueryConverter:arr :DATABASE_TABLE_CATLOGCONTENTTABLE];
        [Logger logDebug:query];
        [dataObj insertQuery:query];
        
        
        
        //        for(int courseCount = 0; courseCount < [moduleArr count] ;courseCount ++)
        //        {
        //            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[moduleArr objectAtIndex:courseCount] table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        //            //NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_CATLOGCONTENTTABLE];
        //             NSString * query = [self ArrayinsertQueryConverter:testDictionary :DATABASE_TABLE_CATLOGCONTENTTABLE];
        //
        //            [Logger logDebug:query];
        //            [dataObj insertQuery:query];
        //
        //        }
    }
    [Logger logAduro:@"DataManagement : End Function fillModuleDataIntable" ];
    return TRUE;
    
    
    
}

-(BOOL)fillAssissmentDataIntable:(NSMutableArray *)AssissmentArr
{
    
    [Logger logAduro:@"DataManagement : Start Function fillAssissmentDataIntable" ];
    if(AssissmentArr != NULL)
    {
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *data in AssissmentArr) {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:data table:DATABASE_TABLE_ASSESSMENTTABLE];
            [arr addObject:testDictionary];
        }
        
        NSString * query = [self ArrayinsertQueryConverter:arr :DATABASE_TABLE_ASSESSMENTTABLE];
        [Logger logDebug:query];
        [dataObj insertQuery:query];
        
        
        //        for(int courseCount = 0; courseCount < [AssissmentArr count] ;courseCount ++)
        //        {
        //
        //            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[AssissmentArr objectAtIndex:courseCount] table:DATABASE_TABLE_ASSESSMENTTABLE];
        //            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_ASSESSMENTTABLE];
        //            [Logger logDebug:query];
        //            [dataObj insertQuery:query];
        //
        //        }
    }
    [Logger logAduro:@"DataManagement : End Function fillAssissmentDataIntable" ];
    return TRUE;
    
}

-(BOOL)fillScenarioDataIntable:(NSMutableArray *)ScenarioArr
{
    
    
    
    
    [Logger logAduro:@"DataManagement : Start Function fillScenarioDataIntable" ];
    if(ScenarioArr != NULL)
    {
        
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *data in ScenarioArr) {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:data table:DATABASE_TABLE_SCENARIOTABLE];
            [arr addObject:testDictionary];
        }
        
        NSString * query = [self ArrayinsertQueryConverter:arr :DATABASE_TABLE_SCENARIOTABLE];
        [Logger logDebug:query];
        [dataObj insertQuery:query];
        
        
        
        //        for(int courseCount = 0; courseCount < [ScenarioArr count] ;courseCount ++)
        //        {
        //            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:[ScenarioArr objectAtIndex:courseCount] table:DATABASE_TABLE_SCENARIOTABLE];
        //            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_SCENARIOTABLE];
        //            [Logger logDebug:query];
        //            [dataObj insertQuery:query];
        //
        //        }
    }
    [Logger logAduro:@"DataManagement : End Function fillScenarioDataIntable" ];
    return TRUE;
    
}



-(NSString *) insertQueryConverter:(NSMutableDictionary *)dataDictionary :(NSString *)tblString
{
    [Logger logAduro:@"DataManagement : Start Function insertQueryConverter" ];
    NSMutableString * querry  = [[NSMutableString alloc] initWithString:@"INSERT INTO "];
    [querry appendString:tblString];
    [querry appendString:@" ( "];
    if(dataDictionary != NULL)
    {
        for( int i =0 ;i< [[dataDictionary allKeys] count] ; i++ )
        {
            NSString *aKey = [[dataDictionary allKeys] objectAtIndex:i];
            if(aKey != NULL)
            {
                [querry appendString:aKey];
                if(i != [[dataDictionary allKeys] count] -1)
                    [querry appendString:@" ,"];
                
            }
        }
        [querry appendString:@" ) "];
        
        [querry appendString:@"VALUES ("];
        for( int i =0 ;i< [[dataDictionary allKeys] count] ; i++ )
        {
            NSString *aKey = [[dataDictionary allKeys] objectAtIndex:i];
            if(aKey != NULL)
            {
                NSString * data = [[NSString alloc]initWithFormat:@"%@",[dataDictionary valueForKey:aKey]];
                NSString *newdata = [data stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
                newdata = [newdata stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
                [querry appendString:@"'"];
                [querry appendString:newdata];
                [querry appendString:@"'"];
                if(i != [[dataDictionary allKeys] count] -1)
                    [querry appendString:@" ,"];
                
            }
        }
        [querry appendString:@" )"];
        
        
    }
    
    
    [Logger logAduro:@"DataManagement : End Function insertQueryConverter" ];
    return querry;
}


-(NSString *) ArrayinsertQueryConverter:(NSMutableArray *)dataArr :(NSString *)tblString
{
    NSMutableString * querry  = [[NSMutableString alloc] initWithString:@"INSERT INTO "];
    if([dataArr count] >0)
    {
        NSMutableDictionary * dataDictionary = [dataArr objectAtIndex:0];
        [Logger logAduro:@"DataManagement : Start Function Array insertArrQueryConverter" ];
        //NSMutableString * querry  = [[NSMutableString alloc] initWithString:@"INSERT INTO "];
        [querry appendString:tblString];
        [querry appendString:@" ( "];
        if(dataDictionary != NULL)
        {
            for( int i =0 ;i< [[dataDictionary allKeys] count] ; i++ )
            {
                NSString *aKey = [[dataDictionary allKeys] objectAtIndex:i];
                if(aKey != NULL)
                {
                    [querry appendString:aKey];
                    if(i != [[dataDictionary allKeys] count] -1)
                        [querry appendString:@" ,"];
                    
                }
            }
            [querry appendString:@" ) "];
            
            [querry appendString:@"VALUES "];
            //for (NSMutableDictionary * dataDictionary in dataArr) {
            for( int j =0 ;j< [dataArr count] ; j++ ){
                NSMutableDictionary * dataDictionary = [dataArr objectAtIndex:j];
                [querry appendString:@"("];
                for( int i =0 ;i< [[dataDictionary allKeys] count] ; i++ )
                {
                    NSString *aKey = [[dataDictionary allKeys] objectAtIndex:i];
                    if(aKey != NULL)
                    {
                        NSString * data = [[NSString alloc]initWithFormat:@"%@",[dataDictionary valueForKey:aKey]];
                        NSString *newdata = [data stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
                        newdata = [newdata stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
                        [querry appendString:@"'"];
                        [querry appendString:newdata];
                        [querry appendString:@"'"];
                        if(i != [[dataDictionary allKeys] count] -1)
                            [querry appendString:@" ,"];
                        
                    }
                }
                if([dataArr count] -1 == j)
                    [querry appendString:@" )"];
                else
                    [querry appendString:@" ),"];
            }
            
            
        }
        
    }
    [Logger logAduro:@"DataManagement : End Function insertArrQueryConverter" ];
    return querry;
}


-(NSString *) updateQueryConverter:(NSMutableDictionary *)dataDictionary :(NSString *)tblString :(NSString *)whereKey :(NSString *)whereValue
{
    [Logger logAduro:@"DataManagement : Start Function updateQueryConverter" ];
    NSMutableString * querry  = [[NSMutableString alloc] initWithString:@"UPDATE "];
    [querry appendString:tblString];
    [querry appendString:@" SET "];
    if(dataDictionary != NULL)
    {
        for( int i =0 ;i< [[dataDictionary allKeys] count] ; i++ )
        {
            NSString *aKey = [[dataDictionary allKeys] objectAtIndex:i];
            if(aKey != NULL)
            {
                [querry appendString:aKey];
                
                [querry appendString:@" = "];
                NSString * data = [[NSString alloc]initWithFormat:@"%@",[dataDictionary valueForKey:aKey]];
                NSString *newdata = [data stringByReplacingOccurrencesOfString:@"'" withString:@"’"];
                newdata = [newdata stringByReplacingOccurrencesOfString:@"'" withString:@"%27"];
                [querry appendString:@"'"];
                [querry appendString:newdata];
                [querry appendString:@"'"];
                if(i != [[dataDictionary allKeys] count] -1)
                    [querry appendString:@" ,"];
                
            }
        }
        
        [querry appendFormat:@" WHERE %@= ",whereKey];
        
        [querry appendFormat:@"'%@'",whereValue];
        
        
    }
    
    
    [Logger logAduro:@"DataManagement : End Function updateQueryConverter" ];
    return querry;
}






-(NSMutableDictionary *)convertParserObjToDatabaseObj :(NSMutableDictionary *)parserDataObj table:(NSString *)tblname
{
    //[Logger logAduro:@"DataManagement : Start Function convertParserObjToDatabaseObj" ];
    NSMutableDictionary * tblObject = [[NSMutableDictionary alloc]init];
    
    if([tblname isEqualToString:DATABASE_TABLE_COURSETABLE ])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_COURSE_CEDGE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_COURSE_NAME];
        //[tblObject setValue:EMPTYDATATEXT forKey:DATABASE_COURSE_DATA];
        [tblObject setValue:[parserDataObj valueForKey:DESCRIPTION] forKey:DATABASE_COURSE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_COURSE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:VERSION] forKey:DATABASE_COURSE_VER];
        [tblObject setValue:appDelegate.courseCode forKey:DATABASE_COURSE_DATA];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_COURSE_IMGPATH] forKey:DATABASE_COURSE_IMGPATH];
        
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_USERINFO])
    {
        
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_LOGIN] forKey:DATABASE_LOGIN];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_USERNAME] forKey:DATABASE_USERNAME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PASSWORD] forKey:DATABASE_PASSWORD];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TIME] forKey:DATABASE_TIME];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_ISIMAGECAPTURE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_LOGINTYPE] forKey:DATABASE_LOGINTYPE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_USERID] forKey:DATABASE_USERID];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PROFILEPIC] forKey:DATABASE_PROFILEPIC];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TOKEN] forKey:DATABASE_TOKEN];
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_CATLOGCONTENTTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_CATLOGCONT_CEDGEID];
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_CATLOGCONT_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_CATLOGCONT_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DESCRIPTION] forKey:DATABASE_CATLOGCONT_DESC];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_CATLOGCONT_DATA];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE] forKey:DATABASE_CATLOGCONT_CATTYPE];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_CATLOGCONT_TIME];
        [tblObject setValue:[parserDataObj valueForKey:ZIPSIZE] forKey:DATABASE_CATLOGCONT_ZIPSIZE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE] forKey:DATABASE_CATLOGCONT_ASSESSMENT_TYPE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_SKILLS] forKey:DATABASE_CATLOGCONT_SKILLS];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_PASS_SCORE] forKey:DATABASE_CATLOGCONT_PASS_SCORE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_TOTAL_QUESTION] forKey:DATABASE_CATLOGCONT_TOTAL_QUESTION];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION] forKey:DATABASE_CATLOGCONT_TATAL_SHOW_QUESTION];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_NO_SKILL_QUES] forKey:DATABASE_CATLOGCONT_NO_SKILL_QUES];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_DURATION] forKey:DATABASE_CATLOGCONT_DURATION];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_THUMBNILIMG] forKey:DATABASE_CATLOGCONT_THUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK] forKey:DATABASE_CATLOGCONT_ISTOPICLOCK];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_TOPIC_TYPE] forKey:DATABASE_CATLOGCONT_TOPIC_TYPE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
        
        
        
        if([parserDataObj valueForKey:ZIPURL] != NULL)
        {
            [tblObject setValue:[parserDataObj valueForKey:ZIPURL] forKey:DATABASE_CATLOGCONT_ZIPURL];
        }
        else
        {
            [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_CATLOGCONT_ZIPURL];
        }
        
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_ASSESSMENTTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_ASSESSMENT_CEDGEID];
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_ASSESSMENT_EDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_ASSESSMENT_SCORE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_ASSESSMENT_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_ASSESSMENT_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_ASSESSMENT_DESC];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_ASSESSMENT_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_ASSESSMENT_TIME];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_SCENARIOTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_SCENARIO_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_SCENARIO_CEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:NAME]forKey:DATABASE_SCENARIO_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_SCENARIO_DATA];
        [tblObject setValue:[parserDataObj valueForKey:DESCRIPTION] forKey:DATABASE_SCENARIO_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_SCENARIO_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_SCENARIO_TIME];
        [tblObject setValue:[parserDataObj valueForKey:ZIPURL] forKey:DATABASE_SCENARIO_ZIPURL];
        
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_ZIPSIZE] forKey:DATABASE_SCENARIO_ZIPSIZE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_BGCOLOR] forKey:DATABASE_SCENARIO_BGCOLOR];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_DURATION] forKey:DATABASE_SCENARIO_DURATION];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_SKILL] forKey:DATABASE_SCENARIO_SKILL];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_THUMBNAIL] forKey:DATABASE_SCENARIO_THUMBNAIL];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_QUESCOUNT] forKey:DATABASE_SCENARIO_QUESCOUNT];
        
        [tblObject setValue:DATABASE_CATTYPE_SCENARIO forKey:DATABASE_SCENARIO_SCATTYPE];
        
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_SCENARIO_IS_HIDE] forKey:DATABASE_SCENARIO_IS_HIDE];
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_CONCEPT_N])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_EXERCISE_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_EXERCISE_CEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:NAME]forKey:DATABASE_EXERCISE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_EXERCISE_DATA];
        [tblObject setValue:[parserDataObj valueForKey:DESCRIPTION] forKey:DATABASE_EXERCISE_DESC];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE] forKey:DATABASE_EXERCISE_CATTYPE];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_EXERCISE_DISPLAYSEQUENCE] forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_EXERCISE_COMTHUMBNILIMG] forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_ACTIVITYTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_EXERCISE_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_EXERCISE_CEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:NAME]forKey:DATABASE_EXERCISE_NAME];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_EXERCISE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_EXERCISE_DESC];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE] forKey:DATABASE_EXERCISE_CATTYPE];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_TIME];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_PRACTICE_N])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_EXERCISE_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_EXERCISE_CEDGEID];
        [tblObject setValue: EMPTYDATATEXT forKey:DATABASE_EXERCISE_NAME];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_EXERCISE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_EXERCISE_DESC];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE] forKey:DATABASE_EXERCISE_CATTYPE];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_EXERCISE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_EXERCISE_DISPLAYSEQUENCE] forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_EXERCISE_COMTHUMBNILIMG] forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_VOCABWORD])
    {
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_VOCABID] forKey:DATABASE_VOCABWORD_WORDID];
        [tblObject setValue: [parserDataObj valueForKey:EDGEID] forKey:DATABASE_VOCABWORD_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:ATTRIBUTE_WORD] forKey:DATABASE_VOCABWORD_WORD];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_MEANING] forKey:DATABASE_VOCABWORD_MEANING];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_PRONOUNCIATION] forKey:DATABASE_VOCABWORD_PRONOUNCIATION];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_PARTSOFSPEECH] forKey:DATABASE_VOCABWORD_PARTOFSPEECH];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_ETYMOLOGIES] forKey:DATABASE_VOCABWORD_ETYMOLOGIES];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_USAGE] forKey:DATABASE_VOCABWORD_USAGE];
        [tblObject setValue:[parserDataObj valueForKey:ATTRIBUTE_VOCABAUDIOPATH] forKey:DATABASE_VOCABWORD_WORDAUDIOPATH];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_VOCABWORD_RECWORDAUDIOPATH];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_VOCABWORD_PSCORE];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_VOCABWORD_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_VOCABWORD_IMAGEPATH] forKey:DATABASE_VOCABWORD_IMAGEPATH];
        
        
    }
    
    
    else if ([tblname isEqualToString:DATABASE_TABLE_VCBPRACTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_PRACTICE_CEDGEID];
        [tblObject setValue: EMPTYDATATEXT forKey:DATABASE_PRACTICE_WATCHEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_ENACTEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE]  forKey:DATABASE_PRACTICE_CATETYPE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_PRACTICE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_PRACTICE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_MCQPRACTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_PRACTICE_CEDGEID];
        [tblObject setValue: EMPTYDATATEXT forKey:DATABASE_PRACTICE_WATCHEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_ENACTEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE]  forKey:DATABASE_PRACTICE_CATETYPE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_PRACTICE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_PRACTICE_DATA];
        [tblObject setValue:[parserDataObj valueForKey:DESCRIPTION] forKey:DATABASE_PRACTICE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_GAMEPRACTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_PRACTICE_CEDGEID];
        [tblObject setValue: EMPTYDATATEXT forKey:DATABASE_PRACTICE_WATCHEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_ENACTEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE]  forKey:DATABASE_PRACTICE_CATETYPE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_PRACTICE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_PRACTICE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_SRPRACTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_PRACTICE_CEDGEID];
        [tblObject setValue: EMPTYDATATEXT forKey:DATABASE_PRACTICE_WATCHEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_ENACTEDGEID];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE]  forKey:DATABASE_PRACTICE_CATETYPE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_PRACTICE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_PRACTICE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
    }
    
    else if ([tblname isEqualToString:DATABASE_TABLE_CONVERSATIONTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_CONVERSATION_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_CONVERSATION_CEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:ATTRIBUTE_IDEALTIME] forKey:DATABASE_CONVERSATION_IDEALTIME];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_CONVERSATION_CATTYPE];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_CONVERSATION_TIME];
        
    }
    
    
    else if ([tblname isEqualToString:DATABASE_TABLE_QUESTION])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_QUESTION_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_QUESTION_CONUNITID];
        [tblObject setValue: [parserDataObj valueForKey:TAG]  forKey:DATABASE_QUESTION_TAG];
        [tblObject setValue:[parserDataObj valueForKey:PLAY] forKey:DATABASE_QUESTION_VPATH];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_QUESTION_RECVIDEOPATH];
        [tblObject setValue:EMPTYDATATEXT  forKey:DATABASE_QUESTION_RECAUDIOPATH];
        [tblObject setValue: EMPTYDATAINT forKey:DATABASE_QUESTION_ISCOMP];
        
    }
    
    
    else if ([tblname isEqualToString:DATABASE_TABLE_ANSWER])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_ANSWER_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_ANSWER_CONUNITID];
        [tblObject setValue: [parserDataObj valueForKey:TAG]  forKey:DATABASE_ANSWER_TAG];
        [tblObject setValue:[parserDataObj valueForKey:PLAY] forKey:DATABASE_ANSWER_PLAYPATH];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_ANSWER_RECVIDEOPATH];
        [tblObject setValue:EMPTYDATATEXT  forKey:DATABASE_ANSWER_RECAUDIOPATH];
        [tblObject setValue: EMPTYDATAINT forKey:DATABASE_ANSWER_ISCOMPLETE];
    }
    
    
    else if ([tblname isEqualToString:DATABASE_TABLE_VOCABULARY])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_VOCAB_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:WORD] forKey:DATABASE_VOCAB_WORD];
        [tblObject setValue: [parserDataObj valueForKey:VOCABID]  forKey:DATABASE_VOCAB_WORDID];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_VOCAB_ISCOMP];
        
        
        [tblObject setValue:[parserDataObj valueForKey:PEDGEID] forKey:DATABASE_VOCAB_CEDGEID];
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_TEXTSEGMENT])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_TEXTSEGMENT_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_TEXTSEGMENT_TEXTID];
        [tblObject setValue: [parserDataObj valueForKey:SIMPLE] forKey:DATABASE_TEXTSEGMENT_SIMPLETEXT];
        [tblObject setValue:[parserDataObj valueForKey:VOCABID] forKey:DATABASE_TEXTSEGMENT_CLICKITEMID];
        [tblObject setValue:[parserDataObj valueForKey:VALUE] forKey:DATABASE_TEXTSEGMENT_CLICKTEXT];
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_PULLIRTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:JSON_EDGEID] forKey:DATABASE_PULLIR_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:JSON_AVGIR] forKey:DATABASE_PULLIR_AVGIR];
        [tblObject setValue: [parserDataObj valueForKey:JSON_MAXIR] forKey:DATABASE_PULLIR_MAXIR];
        [tblObject setValue:[self getCurrentTime] forKey:DATABASE_PULLIR_TIME];
        
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_TESTTABLE])
    {
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_TEST_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:HTML_JSON_KEY_TESTID] forKey:DATABASE_TEST_TESTID];
        [tblObject setValue: [parserDataObj valueForKey:HTML_JSON_KEY_QUESID] forKey:DATABASE_TEST_QUESID];
        [tblObject setValue:[parserDataObj valueForKey:HTML_JSON_KEY_ANSID] forKey:DATABASE_TEST_ANSID];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_TEST_SCORE];
        [tblObject setValue:[parserDataObj valueForKey:HTML_JSON_KEY_DATEMS]  forKey:DATABASE_TEST_DATAMS];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TEST_COURSEPACK]  forKey:DATABASE_TEST_COURSEPACK];
        
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TEST_ESSASYANSWER]  forKey:DATABASE_TEST_ESSASYANSWER];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TEST_AVMEDIAFILES]  forKey:DATABASE_TEST_AVMEDIAFILES];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_TEST_ATTEMPT_ID]  forKey:DATABASE_TEST_ATTEMPT_ID];
        
        [tblObject setValue:appDelegate.courseCode  forKey:DATABASE_TEST_COURSE_CODE];
        
        
        
        
    }
    else if ([tblname isEqualToString:DATABASE_TABLE_TRACKTABLE])
    {
        
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_MODULEID] forKey:DATABASE_TRACKINGTABLE_MOEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:NATIVE_JSON_KEY_SCNID] forKey:DATABASE_TRACKINGTABLE_SCNEDGEID];
        [tblObject setValue: [parserDataObj valueForKey:NATIVE_JSON_KEY_EDGEID] forKey:DATABASE_TRACKINGTABLE_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_TYPE] forKey:DATABASE_TRACKINGTABLE_TRACKTYPE];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_USAGESCORE] forKey:DATABASE_TRACKINGTABLE_USAGESCORE];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_ISCOMP]  forKey:DATABASE_TRACKINGTABLE_ISCOMP];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_STARTTIME]  forKey:DATABASE_TRACKINGTABLE_STARTTIME];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_ENDTIME]  forKey:DATABASE_TRACKINGTABLE_ENDTIME];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_COURSECODE]  forKey:DATABASE_TRACKINGTABLE_COURSE_CODE];
        [tblObject setValue:[parserDataObj valueForKey:NATIVE_JSON_KEY_COURSEPACK]  forKey:NATIVE_JSON_KEY_COURSEPACK];
        
    }
    
    
    
    [Logger logAduro:@"DataManagement : end Function convertParserObjToDatabaseObj" ];
    return tblObject;
}



-(NSMutableDictionary *)convertParserObjToDatabaseObj :(NSMutableDictionary *)parserDataObj table:(NSString *)tblname : (NSDictionary *)parserDataWatchObj :(NSDictionary *)parserDataenactObj :(NSDictionary *)parserDataReviewObj
{
    //[Logger logAduro:@"DataManagement : Start Function convertParserObjToDatabaseObj" ];
    NSMutableDictionary * tblObject = [[NSMutableDictionary alloc]init];
    
    if ([tblname isEqualToString:DATABASE_TABLE_SCNPRACTABLE])
    {
        [tblObject setValue:[parserDataObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_EDGEID];
        [tblObject setValue: [parserDataObj valueForKey:PEDGEID] forKey:DATABASE_PRACTICE_CEDGEID];
        [tblObject setValue: [parserDataWatchObj valueForKey:EDGEID]forKey:DATABASE_PRACTICE_WATCHEDGEID];
        [tblObject setValue:[parserDataenactObj valueForKey:EDGEID]forKey:DATABASE_PRACTICE_ENACTEDGEID];
        [tblObject setValue:[parserDataReviewObj valueForKey:EDGEID] forKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        [tblObject setValue:[parserDataObj valueForKey:CATTYPE]  forKey:DATABASE_PRACTICE_CATETYPE];
        [tblObject setValue:[parserDataObj valueForKey:NAME] forKey:DATABASE_PRACTICE_NAME];
        [tblObject setValue:[parserDataObj valueForKey:DATA] forKey:DATABASE_PRACTICE_DATA];
        [tblObject setValue:EMPTYDATATEXT forKey:DATABASE_PRACTICE_DESC];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_ISCOMP];
        [tblObject setValue:EMPTYDATAINT forKey:DATABASE_PRACTICE_TIME];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
        [tblObject setValue:[parserDataObj valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
        
    }
    [Logger logAduro:@"DataManagement : end Function convertParserObjToDatabaseObj" ];
    return tblObject;
}



#pragma mark -    GET API's



-(NSDictionary *)getUserInfo
{
    NSString *query = @"SELECT * from UserInfoTable where rowid = 1;";
    NSArray * dataArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_USERINFO];
    if(dataArray != NULL && [dataArray count] >0)
    {
        return [dataArray objectAtIndex:0] ;
    }
    return NULL;
}


-(NSMutableDictionary *)getCatelogData:(NSString *)course_pack Topic:(NSString *)topicId
{
    
    [Logger logAduro:@"DataManagement : start Function getCatelogData" ];
    
    NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    NSDictionary * obj  =  [courseArr objectAtIndex:0];
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable where %@ = %@",DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
    if(topicId != NULL && [topicId isEqualToString:@""]){
        
        NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        int unlocked = 0;
        if(catDataArray != NULL )
        {
            NSMutableArray * catArr = [[NSMutableArray alloc]init];
            for (int i =0; i < [catDataArray count] ; i++)
            {
                NSMutableArray * scnArray = [[NSMutableArray alloc]init];
                NSDictionary * dataDb = [catDataArray objectAtIndex:i];
                
                NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                
                NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
                
                if(scnDataArray != NULL)
                {
                    for (int j =0; j < [scnDataArray count] ; j++)
                    {
                        NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                        NSMutableDictionary * scn = [[NSMutableDictionary alloc]init];
                        
                        
                        
                        
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                        NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(DataArray != NULL && [DataArray count] > 0)
                        {
                            [scn setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            
                        }
                        else
                        {
                            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                            NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                            if(_DataArray != NULL && [_DataArray count] > 0)
                            {
                                [scn setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                                
                            }
                            else
                            {
                                [scn setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                            }
                        }
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if(appDelegate.viewMode)
                        {
                            
                            if(unlocked >= 3)
                            {
                                [scn setValue:@"1" forKey:@"isLock"];
                            }
                            else
                            {
                                [scn setValue:@"0" forKey:@"isLock"];
                                unlocked++;
                            }
                            
                            //                            NSArray *lockArr  = [defaults objectForKey:@"unlocked_chapter_list"];
                            //                            [scn setValue:@"1" forKey:@"isLock"];
                            //                            for (NSObject * eid in lockArr) {
                            //                                if([[[NSString alloc]initWithFormat:@"%@",eid]isEqualToString:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]])
                            //                                {
                            //                                    [scn setValue:@"0" forKey:@"isLock"];
                            //                                }
                            //                            }
                            
                        }
                        else
                        {
                            [scn setValue:@"0" forKey:@"isLock"];
                        }
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_NAME] forKey:HTML_JSON_KEY_NAME];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DESC] forKey:HTML_JSON_KEY_DESC];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DATA] forKey:DATABASE_SCENARIO_DATA];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPURL] forKey:DATABASE_SCENARIO_ZIPURL];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPSIZE] forKey:HTML_JSON_KEY_SIZE];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_IS_HIDE] forKey:DATABASE_SCENARIO_IS_HIDE];
                        //                            }
                        [scn setValue:DATABASE_CATTYPE_SCENARIO forKey:HTML_JSON_KEY_TYPE];
                        [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID] forKey:HTML_JSON_KEY_UID];
                        
                        
                        
                        NSDictionary *componant = [defaults objectForKey:@"componant"];
                        
                        if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] > 0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
                        {
                            [scn setValue:[componant valueForKey:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
                        }
                        else
                        {
                            [scn setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                        }
                        
                        [scnArray addObject:scn];
                    }
                    
                }
                
                
                NSMutableDictionary * Catlog = [[NSMutableDictionary alloc]init];
                //                [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_ISCOMP]forKey:HTML_JSON_KEY_ISCOMPLETE];
                //
                //                //[Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_ISLOCK]forKey:HTML_JSON_KEY_ISLOCK];
                //
                //                [Catlog setValue:EMPTYDATAINT forKey:HTML_JSON_KEY_ISLOCK];
                [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_NAME]forKey:HTML_JSON_KEY_NAME];
                
                
                
                [Catlog setValue: scnArray forKey:HTML_JSON_KEY_SCNARRAY];
                [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]forKey:HTML_JSON_KEY_TYPE];
                [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]forKey:HTML_JSON_KEY_UID];
                [Catlog setValue:[dataDb valueForKey:DATABASE_CATLOGCONT_ZIPURL] forKey:DATABASE_CATLOGCONT_ZIPURL];
                [Catlog setValue:[dataDb valueForKey:DATABASE_CATLOGCONT_ZIPSIZE] forKey:HTML_JSON_KEY_SIZE];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *componant = [defaults objectForKey:@"componant"];
                if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] > 0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
                {
                    [Catlog setValue:[componant valueForKey:[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
                }
                else
                {
                    [Catlog setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                }
                
                
                [catArr addObject:Catlog];
            }
            
            [catDic setValue:catArr forKey:HTML_JSONKEY_COURSE];
        }
    }
    else
    {
        NSMutableArray * catArr = [[NSMutableArray alloc]init];
        NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable where %@ = %@",DATABASE_CATLOGCONT_EDGEID,topicId];
        NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        if(catDataArray != NULL )
        {
            NSMutableArray * scnArray = [[NSMutableArray alloc]init];
            NSDictionary * dataDb = [catDataArray objectAtIndex:0];
            
            NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
            
            NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
            int unlocked = 0;
            if(scnDataArray != NULL)
            {
                for (int j =0; j < [scnDataArray count] ; j++)
                {
                    NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                    NSMutableDictionary * scn = [[NSMutableDictionary alloc]init];
                    
                    
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ =%@ AND %@ =%@",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_TRACKTYPE,DATABASE_CATTYPE_SCENARIO,DATABASE_TRACKINGTABLE_ISCOMP,EDGECOMPLETE];
                    NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(LDataArray != NULL && [LDataArray count] > 0)
                    {
                        [scn setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        
                    }
                    else
                    {
                        [scn setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                    }
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    if(appDelegate.viewMode)
                    {
                        if(unlocked >= 3)
                        {
                            [scn setValue:@"1" forKey:@"isLock"];
                        }
                        else
                        {
                            [scn setValue:@"0" forKey:@"isLock"];
                            unlocked++;
                        }
                        
                        //                        NSArray *lockArr  = [defaults objectForKey:@"unlocked_chapter_list"];
                        //                        [scn setValue:@"1" forKey:@"isLock"];
                        //                        for (NSObject * eid in lockArr) {
                        //                            if([[[NSString alloc]initWithFormat:@"%@",eid]isEqualToString:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]])
                        //                            {
                        //                                [scn setValue:@"0" forKey:@"isLock"];
                        //                            }
                        //                        }
                    }
                    else
                    {
                        [scn setValue:@"0" forKey:@"isLock"];
                    }
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_NAME] forKey:HTML_JSON_KEY_NAME];
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DESC] forKey:HTML_JSON_KEY_DESC];
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DATA] forKey:DATABASE_SCENARIO_DATA];
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPURL] forKey:DATABASE_SCENARIO_ZIPURL];
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPSIZE] forKey:HTML_JSON_KEY_SIZE];
                    //                            }
                    [scn setValue:DATABASE_CATTYPE_SCENARIO forKey:HTML_JSON_KEY_TYPE];
                    [scn setValue:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID] forKey:HTML_JSON_KEY_UID];
                    
                    
                    
                    NSDictionary *componant = [defaults objectForKey:@"componant"];
                    
                    if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] > 0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
                    {
                        [scn setValue:[componant valueForKey:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
                    }
                    else
                    {
                        [scn setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                    }
                    
                    [scnArray addObject:scn];
                }
                
            }
            
            
            NSMutableDictionary * Catlog = [[NSMutableDictionary alloc]init];
            //[Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_ISCOMP]forKey:HTML_JSON_KEY_ISCOMPLETE];
            
            //[Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_ISLOCK]forKey:HTML_JSON_KEY_ISLOCK];
            
            [Catlog setValue:EMPTYDATAINT forKey:HTML_JSON_KEY_ISLOCK];
            [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_NAME]forKey:HTML_JSON_KEY_NAME];
            [Catlog setValue: scnArray forKey:HTML_JSON_KEY_SCNARRAY];
            [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]forKey:HTML_JSON_KEY_TYPE];
            [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]forKey:HTML_JSON_KEY_UID];
            [Catlog setValue:[dataDb valueForKey:DATABASE_CATLOGCONT_ZIPURL] forKey:DATABASE_CATLOGCONT_ZIPURL];
            [Catlog setValue:[dataDb valueForKey:DATABASE_CATLOGCONT_ZIPSIZE] forKey:HTML_JSON_KEY_SIZE];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *componant = [defaults objectForKey:@"componant"];
            if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] > 0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
            {
                [Catlog setValue:[componant valueForKey:[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
            }
            else
            {
                [Catlog setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
            }
            
            
            [catArr addObject:Catlog];
            
            
            [catDic setValue:catArr forKey:HTML_JSONKEY_COURSE];
        }
    }
    
    [Logger logAduro:@"DataManagement : end Function getCatelogData" ];
    //        }
    //    }
    return catDic;
}


-(NSString *)getAssessmnetMCQHTMLPath:(int)EdgeId :(int)type
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where pracEdgeID =%d",DATABASE_TABLE_PRACTICETABLE,EdgeId ];
    
    NSArray * lcatDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_PRACTICETABLE];
    if(lcatDataArray != NULL)
    {
        for ( NSDictionary * dataDb  in lcatDataArray) {
            
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                 NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            // NSString* path = [documentsDirectory stringByAppendingPathComponent:
            //                   imgName ];
            
            NSString* path = [documentsDirectory stringByAppendingPathComponent:
                              [dataDb valueForKey:DATABASE_PRACTICE_DATA]];
            NSString * strfmt = [[NSString alloc]initWithFormat:@"%@.html",path];
            
            return strfmt;
            
        }
    }
    
    return @"";
}
-(NSString *)getAssessmnetMCQData:(int)EdgeId :(int)type
{
    NSString * data;
    NSMutableDictionary * Catlog = nil;
    [Logger logAduro:@"DataManagement : Strat Function getAssessmnetMCQData" ];
    
    if(type == 3)
    {
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable  where catContEdgeID =%d",EdgeId ];
        
        NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_CATLOGCONTENTTABLE];
        if(catDataArray != NULL )
        {
            for (NSDictionary *dataDb in catDataArray) {
                
                Catlog = [[NSMutableDictionary alloc]init];
                NSString * pathStr = [self getPathWithoutRoot: [dataDb valueForKey:DATABASE_PRACTICE_DATA]];
                NSError *parseError = nil;
                NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:pathStr error:&parseError];
                [Catlog setValue: xmlDictionary forKey:HTML_JSON_KEY_DATAPATH];
                
                [Catlog setValue: [dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]forKey:HTML_JSON_KEY_UID];
                [Catlog setValue: [languageObj get:@"COMPLETE" alter:@"Complete"] forKey:HTML_JSON_KEY_NAME];
                [Catlog setValue:[[NSString alloc] initWithFormat:@"%d",type]  forKey:@"isQuiz"];
                
                
            }
        }
    }
    else if(type == 21)
    {
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where pracEdgeID =%d",DATABASE_TABLE_PRACTICETABLE,EdgeId ];
        
        NSArray * lcatDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_PRACTICETABLE];
        if(lcatDataArray != NULL)
        {
            for ( NSDictionary * dataDb  in lcatDataArray) {
                
                
                
                Catlog = [[NSMutableDictionary alloc]init];
                NSString * pathStr = [self getPathWithoutRoot: [dataDb valueForKey:DATABASE_PRACTICE_DATA]];
                NSError *parseError = nil;
                NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:pathStr error:&parseError];
                [Catlog setValue: xmlDictionary forKey:HTML_JSON_KEY_DATAPATH];
                
                [Catlog setValue: [dataDb valueForKey:DATABASE_PRACTICE_EDGEID]forKey:HTML_JSON_KEY_UID];
                [Catlog setValue: [languageObj get:@"COMPLETE" alter:@"Complete"] forKey:HTML_JSON_KEY_NAME];
                [Catlog setValue:[[NSString alloc] initWithFormat:@"%d",type]  forKey:@"isQuiz"];
                //[Catlog setValue:[[NSString alloc] initWithFormat:@"%d",3]  forKey:@"isQuiz"];
            }
        }
        
    }
    
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Catlog
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        // NSLog(@"json %@", data);
    }
    
    [Logger logAduro:@"DataManagement : Exit Function getAssessmnetMCQData" ];
    return data;
}


-(NSString*)getPathWithoutRoot:(NSString *)file
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:file];
    NSError * error;
    
    
    NSString *dataFile = [NSString stringWithContentsOfFile:dataPath encoding: NSUTF8StringEncoding error:&error];
    if(error != nil)
    {
        dataFile = [NSString stringWithContentsOfFile:dataPath encoding: NSUTF16StringEncoding error:&error];
    }
    //dataPath = [dataPath stringByAppendingPathComponent:file];
    return dataFile;
}

-(NSMutableArray *)getChapterDetail:(NSInteger )data
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%li ",DATABASE_TABLE_EXERCISETABLE,(long)data];
    
    return [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
    
}


-(NSMutableDictionary *)getChapterTotalTime:(NSString* )data
{
    NSMutableDictionary * store_data =[[NSMutableDictionary alloc]init];
    double ChapterTotalTime =0;
    int coins = 0;
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,data,DATABASE_CATTYPE_CONCEPT_XML ];
    NSArray * capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
    for (int k=0; k< [capConceptDataArray count]; k++)
    {
        
        NSDictionary * datanewDb = [capConceptDataArray objectAtIndex:k];
        
        NSString * com_coins = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"coins_%@", [datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]];
        coins = coins + [com_coins intValue];
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack ];
        NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
        for (NSDictionary * obj in DataArray) {
            
            double  start =  [[obj valueForKey:DATABASE_TRACKINGTABLE_STARTTIME]longLongValue];
            double  end =  [[obj valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]longLongValue];
            
            
            if(end > 0 && start > 0 )
            {
                ChapterTotalTime = ChapterTotalTime +( end-start);
                
            }
            else if(end > 0 && start == 0)
            {
                ChapterTotalTime = ChapterTotalTime + end;
            }
            
        }
        
    }
    NSString * uidtrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,data,DATABASE_CATTYPE_PRACTICE ];
    NSArray * uIDDataArray = [dataObj SelecteQuery:uidtrfmt Table :DATABASE_TABLE_EXERCISETABLE];
    if(uIDDataArray != NULL)
    {
        NSDictionary * UIDDict = [uIDDataArray objectAtIndex:0];
        NSString * practicestrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where exEdgeID =%@",DATABASE_TABLE_PRACTICETABLE,[UIDDict valueForKey:DATABASE_EXERCISE_EDGEID]];
        NSArray * practicecapDataArray = [dataObj SelecteQuery:practicestrfmt Table :DATABASE_TABLE_PRACTICETABLE];
        for (NSDictionary * datanewDb in practicecapDataArray) {
            NSString * com_coins = [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"coins_%@", [datanewDb valueForKey:DATABASE_PRACTICE_EDGEID]]];
            coins = coins + [com_coins intValue];
            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack ];
            NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
            for (NSDictionary * obj in DataArray) {
                double  start =  [[obj valueForKey:DATABASE_TRACKINGTABLE_STARTTIME]doubleValue];
                double  end =  [[obj valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]doubleValue];
                if(end > 0 && start > 0 )
                {
                    ChapterTotalTime = ChapterTotalTime +( end-start);
                    
                }
                else if(end > 0 && start == 0)
                {
                    ChapterTotalTime = ChapterTotalTime + end;
                }
                
            }
            
        }
    }
    [store_data setValue:[[NSString alloc]initWithFormat:@"%f", ChapterTotalTime]  forKey:@"time"];
    [store_data setValue:[[NSString alloc]initWithFormat:@"%d", coins]  forKey:@"coins"];
    return store_data ;
}

-(NSString *)getScenariopracticeData:(NSInteger )data :(NSInteger )type :(NSString *)coursePack
{
    NSString * rawdata;
    [Logger logAduro:@"DataManagement : Strat Function getScenariopracticeData" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%ld",DATABASE_TABLE_SCENARIOTABLE,(long)data ];
    NSMutableDictionary * scnDataDictionary;
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    if(catDataArray != NULL )
    {
        NSDictionary * dataDb = [catDataArray objectAtIndex:0];
        
        scnDataDictionary = [[NSMutableDictionary alloc]init];
        NSString * ContentId =[dataDb valueForKey:DATABASE_SCENARIO_CEDGEID];
        [scnDataDictionary setValue:ContentId forKey:HTML_JSON_KEY_UID];
        NSString * name = [dataDb valueForKey:DATABASE_CATLOGCONT_NAME];
        [scnDataDictionary setValue:name forKey:HTML_JSON_KEY_NAME];
        
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where catContEdgeID =%@",DATABASE_TABLE_CATLOGCONTENTTABLE,ContentId];
        
        NSArray * ContentDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        if(ContentDataArray != NULL)
        {
            // NSDictionary * dataDb = [ContentDataArray objectAtIndex:0];
            
            
            NSMutableArray *capArr = [[NSMutableArray alloc] init];
            [scnDataDictionary setValue:capArr forKey:HTML_JSON_KEY_CAPARRAY];
            
            NSMutableDictionary * concept = [[NSMutableDictionary alloc]init];
            NSString * scnUid = [[NSString alloc]initWithFormat:@"%ld",(long)data ];
            [concept setValue:scnUid forKey:HTML_JSON_KEY_UID];
            
            NSMutableArray *ContentArr = [[NSMutableArray alloc] init];
            
            
            
            
            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,scnUid,DATABASE_CATTYPE_CONCEPT_XML ];
            
            NSArray * capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
            if(capConceptDataArray != NULL)
            {
                for (int k=0; k< [capConceptDataArray count]; k++)
                {
                    
                    NSDictionary * datanewDb = [capConceptDataArray objectAtIndex:k];
                    NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                    
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_DESC] forKey:HTML_JSON_KEY_DESC];
                    
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        
                    }
                    else
                    {
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                        NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(_DataArray != NULL && [_DataArray count] > 0)
                        {
                            [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            
                        }
                        else
                        {
                            [innerCap setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                        }
                    }
                    
                    
                    //[innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_ISCOMP] forKey:HTML_JSON_KEY_ISCOMPLETE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_NAME] forKey:HTML_JSON_KEY_NAME];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_CATTYPE] forKey:HTML_JSON_KEY_TYPE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID] forKey:HTML_JSON_KEY_UID];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_DISPLAYSEQUENCE] forKey:HTML_JSON_KEY_SEQUENCE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_COMTHUMBNILIMG] forKey:HTML_JSON_KEY_COMP_IMAGE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_COMTHUMBNILIMG] forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
                    //[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CMS_%@",[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]];
                    //                    [innerCap setValue:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CMS_%@",[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]] forKey:HTML_JSON_KEY_SEQUENCE];
                    //
                    //                    [innerCap setValue:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]] forKey:HTML_JSON_KEY_COMP_IMAGE];
                    
                    if(![[datanewDb valueForKey:DATABASE_EXERCISE_CATTYPE]isEqualToString:@"7"])
                    {
                        [ContentArr addObject:innerCap];
                    }
                }
            }
            [concept setValue:ContentArr forKey:HTML_JSON_KEY_CONTENTARRAY];
            [concept setValue:DATABASE_CATTYPE_CONCEPT_XML forKey:HTML_JSON_KEY_CAPTYPE];
            if(concept != NULL && [[concept valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]>0)
                [capArr addObject:concept];
            
            
            
            NSMutableDictionary * activity = [[NSMutableDictionary alloc]init];
            NSString * actscnUid = [[NSString alloc]initWithFormat:@"%ld",(long)data];
            [activity setValue:actscnUid forKey:HTML_JSON_KEY_UID];
            
            
            NSMutableArray *ActivityArr = [[NSMutableArray alloc] init];
            
            
            NSString * Activitystrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,scnUid,DATABASE_CATTYPE_ACTIVITY ];
            
            NSArray * acticapDataArray = [dataObj SelecteQuery:Activitystrfmt Table :DATABASE_TABLE_EXERCISETABLE];
            if(acticapDataArray != NULL)
            {
                for (int k=0; k < [acticapDataArray count]; k++) {
                    
                    
                    NSDictionary * datanewDb = [acticapDataArray objectAtIndex:k];
                    NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_DESC] forKey:HTML_JSON_KEY_DESC];
                    
                    
                    
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]];
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        
                    }
                    else
                    {
                        [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                    }
                    
                    
                    
                    //[innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_ISCOMP] forKey:HTML_JSON_KEY_ISCOMPLETE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_NAME] forKey:HTML_JSON_KEY_NAME];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_CATTYPE] forKey:HTML_JSON_KEY_TYPE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID] forKey:HTML_JSON_KEY_UID];
                    //                    [appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CMS_%@",[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]];
                    //
                    //                    [innerCap setValue:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]]] forKey:HTML_JSON_KEY_COMP_IMAGE];
                    
                    
                    
                    [ActivityArr addObject:innerCap];
                    
                }
                
                
                
            }
            [activity setValue:ActivityArr forKey:HTML_JSON_KEY_CONTENTARRAY];
            
            
            
            //[activity setValue:[languageObj get:@"SCN_PRAC_ACTIVITY" alter:@"ACTIVITY"] forKey:HTML_JSON_KEY_NAME];
            // NSString * scnUid = [[NSString alloc]initWithFormat:@"%d",CO ];
            [activity setValue:DATABASE_CATTYPE_ACTIVITY forKey:HTML_JSON_KEY_CAPTYPE];
            if(activity != NULL && [[activity valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]>0)
                [capArr addObject:activity];
            
            NSMutableDictionary * practice = [[NSMutableDictionary alloc]init];
            NSString * pracscnUid = [[NSString alloc]initWithFormat:@"%ld",(long)data ];
            [practice setValue:pracscnUid forKey:HTML_JSON_KEY_UID];
            
            
            
            NSMutableArray *practiceArr = [[NSMutableArray alloc] init];
            NSString * uidtrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,scnUid,DATABASE_CATTYPE_PRACTICE ];
            
            NSArray * uIDDataArray = [dataObj SelecteQuery:uidtrfmt Table :DATABASE_TABLE_EXERCISETABLE];
            
            
            
            if(uIDDataArray != NULL)
            {
                
                NSDictionary * UIDDict = [uIDDataArray objectAtIndex:0];
                
                NSString * LscnUID = [UIDDict valueForKey:DATABASE_EXERCISE_EDGEID];
                
                NSString * practicestrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where exEdgeID =%@",DATABASE_TABLE_PRACTICETABLE,LscnUID];
                
                NSArray * practicecapDataArray = [dataObj SelecteQuery:practicestrfmt Table :DATABASE_TABLE_PRACTICETABLE];
                
                
                if(practicecapDataArray != NULL )
                {
                    for (int k=[practicecapDataArray count]-1; k >= 0 ; k--)
                    {
                        NSDictionary * datanewDb = [practicecapDataArray objectAtIndex:k];
                        NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_DESC] forKey:HTML_JSON_KEY_DESC];
                        
                        
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                        
                        NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(DataArray != NULL && [DataArray count] > 0)
                        {
                            [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            //                        if([[datanewDb valueForKey:DATABASE_PRACTICE_CATETYPE]isEqualToString:DATABASE_CATTYPE_VOCAB_PRACTICE_XML])
                            //                        {
                            //
                            //                            NSString * totalQ = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID]];
                            //
                            //                            NSString * totalQC = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_VOCABWORD_ISCOMP,@"1"];
                            //
                            //                            if([[dataObj SelecteQuery:totalQ Table:DATABASE_TABLE_VOCABWORD]count] ==  [[dataObj SelecteQuery:totalQC Table:DATABASE_TABLE_VOCABWORD]count] )
                            //                            {
                            //                                [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            //                            }
                            //                            else
                            //                            {
                            //                                [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            //                            }
                            //
                            //                        }
                            //                        else{
                            //                            [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            //                        }
                            
                        }
                        else
                        {
                            NSString * _strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                            
                            NSArray * _DataArray = [dataObj SelecteQuery:_strfmt Table:DATABASE_TABLE_TRACKTABLE];
                            if(_DataArray != NULL && [_DataArray count] > 0)
                            {
                                [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            }
                            else
                            {
                                [innerCap setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                            }
                        }
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_DATA] forKey:DATABASE_PRACTICE_DATA];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_NAME] forKey:HTML_JSON_KEY_NAME];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_CATETYPE] forKey:HTML_JSON_KEY_TYPE];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID] forKey:HTML_JSON_KEY_UID];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_DISPLAYSEQUENCE] forKey:HTML_JSON_KEY_SEQUENCE];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:HTML_JSON_KEY_COMP_IMAGE];
                        [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        
                        
                        
                        //                        [innerCap setValue:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CMS_%@",[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID]]] forKey:HTML_JSON_KEY_SEQUENCE];
                        //                        [innerCap setValue:[appDelegate getUserDefaultData:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID]]] forKey:HTML_JSON_KEY_COMP_IMAGE];
                        
                        [practiceArr addObject:innerCap];
                        
                    }
                    
                }
            }
            
            [practice setValue:practiceArr forKey:HTML_JSON_KEY_CONTENTARRAY];
            
            
            //[practice setValue:[languageObj get:@"SCN_PRAC_PRACTICE" alter:@"PRACTICE"] forKey:HTML_JSON_KEY_NAME];
            // NSString * scnUid = [[NSString alloc]initWithFormat:@"%d",CO ];
            [practice setValue:DATABASE_CATTYPE_PRACTICE forKey:HTML_JSON_KEY_CAPTYPE];
            if(practice != NULL && [[practice valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]>0)
                [capArr addObject:practice];
            
            
            
        }
    }
    
    
    NSError *error;
    if(scnDataDictionary != NULL)
    {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:scnDataDictionary
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            rawdata = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //NSLog(@"json %@", rawdata);
        }
        
        [Logger logAduro:@"DataManagement : Exit Function getScenariopracticeData" ];
        return rawdata;
    }
    else
    {
        return nil;
    }
}

-(NSMutableDictionary *)getScenariopracticArr:(NSInteger )data :(NSInteger )type :(NSString *)coursePack
{
    [Logger logAduro:@"DataManagement : Strat Function getScenariopracticeData" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%ld",DATABASE_TABLE_SCENARIOTABLE,(long)data];
    NSMutableDictionary * scnDataDictionary;
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    if(catDataArray != NULL )
    {
        NSDictionary * dataDb = [catDataArray objectAtIndex:0];
        scnDataDictionary = [[NSMutableDictionary alloc]init];
        NSString * ContentId =[dataDb valueForKey:DATABASE_SCENARIO_EDGEID];
        [scnDataDictionary setValue:ContentId forKey:HTML_JSON_KEY_UID];
        NSString * name = [dataDb valueForKey:DATABASE_CATLOGCONT_NAME];
        [scnDataDictionary setValue:name forKey:HTML_JSON_KEY_NAME];
        NSMutableArray *capArr = [[NSMutableArray alloc] init];
        [scnDataDictionary setValue:capArr forKey:HTML_JSON_KEY_CAPARRAY];
        
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,[[NSString alloc]initWithFormat:@"%ld",(long)data ],DATABASE_CATTYPE_CONCEPT_XML ];
        
        NSArray * capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
        if(capConceptDataArray != NULL)
        {
            for (int k=0; k< [capConceptDataArray count]; k++)
            {
                
                NSDictionary * datanewDb = [capConceptDataArray objectAtIndex:k];
                NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_DESC] forKey:HTML_JSON_KEY_DESC];
                
                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                if(DataArray != NULL && [DataArray count] > 0)
                {
                    [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                    
                }
                else
                {
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                    NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(_DataArray != NULL && [_DataArray count] > 0)
                    {
                        [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        
                    }
                    else
                    {
                        [innerCap setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                    }
                }
                
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_NAME] forKey:HTML_JSON_KEY_NAME];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_CATTYPE] forKey:HTML_JSON_KEY_TYPE];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID] forKey:HTML_JSON_KEY_UID];
                [capArr addObject:innerCap];
                
            }
        }
        
        NSMutableDictionary * activity = [[NSMutableDictionary alloc]init];
        NSString * actscnUid = [[NSString alloc]initWithFormat:@"%ld",(long)data];
        [activity setValue:actscnUid forKey:HTML_JSON_KEY_UID];
        NSString * Activitystrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,ContentId,DATABASE_CATTYPE_ACTIVITY ];
        
        NSArray * acticapDataArray = [dataObj SelecteQuery:Activitystrfmt Table :DATABASE_TABLE_EXERCISETABLE];
        if(acticapDataArray != NULL)
        {
            for (int k=0; k < [acticapDataArray count]; k++) {
                
                
                NSDictionary * datanewDb = [acticapDataArray objectAtIndex:k];
                NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_DESC] forKey:HTML_JSON_KEY_DESC];
                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID]];
                NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                if(DataArray != NULL && [DataArray count] > 0)
                {
                    [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                    
                }
                else
                {
                    [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                }
                
                
                
                //[innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_ISCOMP] forKey:HTML_JSON_KEY_ISCOMPLETE];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_NAME] forKey:HTML_JSON_KEY_NAME];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_CATTYPE] forKey:HTML_JSON_KEY_TYPE];
                [innerCap setValue:[datanewDb valueForKey:DATABASE_EXERCISE_EDGEID] forKey:HTML_JSON_KEY_UID];
                
                
                [capArr addObject:innerCap];
                
            }
            
            
            
        }
        //[activity setValue:ActivityArr forKey:HTML_JSON_KEY_CONTENTARRAY];
        
        
        
        //[activity setValue:[languageObj get:@"SCN_PRAC_ACTIVITY" alter:@"ACTIVITY"] forKey:HTML_JSON_KEY_NAME];
        // NSString * scnUid = [[NSString alloc]initWithFormat:@"%d",CO ];
        // [activity setValue:DATABASE_CATTYPE_ACTIVITY forKey:HTML_JSON_KEY_CAPTYPE];
        //if(activity != NULL && [[activity valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]>0)
        //  [capArr addObject:activity];
        
        //            NSMutableDictionary * practice = [[NSMutableDictionary alloc]init];
        //            NSString * pracscnUid = [[NSString alloc]initWithFormat:@"%ld",(long)data ];
        //            [practice setValue:pracscnUid forKey:HTML_JSON_KEY_UID];
        
        
        
        //NSMutableArray *practiceArr = [[NSMutableArray alloc] init];
        
        
        NSString * uidtrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ AND catType =%@",DATABASE_TABLE_EXERCISETABLE,ContentId,DATABASE_CATTYPE_PRACTICE ];
        
        NSArray * uIDDataArray = [dataObj SelecteQuery:uidtrfmt Table :DATABASE_TABLE_EXERCISETABLE];
        
        
        
        if(uIDDataArray != NULL)
        {
            
            NSDictionary * UIDDict = [uIDDataArray objectAtIndex:0];
            
            NSString * LscnUID = [UIDDict valueForKey:DATABASE_EXERCISE_EDGEID];
            
            NSString * practicestrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where exEdgeID =%@",DATABASE_TABLE_PRACTICETABLE,LscnUID];
            
            NSArray * practicecapDataArray = [dataObj SelecteQuery:practicestrfmt Table :DATABASE_TABLE_PRACTICETABLE];
            
            
            if(practicecapDataArray != NULL )
            {
                
                
                
                for (int k=[practicecapDataArray count]-1; k >= 0 ; k--)
                {
                    NSDictionary * datanewDb = [practicecapDataArray objectAtIndex:k];
                    NSMutableDictionary * innerCap = [[NSMutableDictionary alloc] init];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_DESC] forKey:HTML_JSON_KEY_DESC];
                    
                    
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        //                        if([[datanewDb valueForKey:DATABASE_PRACTICE_CATETYPE]isEqualToString:DATABASE_CATTYPE_VOCAB_PRACTICE_XML])
                        //                        {
                        //
                        //                            NSString * totalQ = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID]];
                        //
                        //                            NSString * totalQC = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_VOCABWORD_ISCOMP,@"1"];
                        //
                        //                            if([[dataObj SelecteQuery:totalQ Table:DATABASE_TABLE_VOCABWORD]count] ==  [[dataObj SelecteQuery:totalQC Table:DATABASE_TABLE_VOCABWORD]count] )
                        //                            {
                        //                                [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        //                            }
                        //                            else
                        //                            {
                        //                                [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        //                            }
                        //
                        //                        }
                        //                        else{
                        //                            [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        //                        }
                        
                    }
                    else
                    {
                        NSString * _strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                        
                        NSArray * _DataArray = [dataObj SelecteQuery:_strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(_DataArray != NULL && [_DataArray count] > 0)
                        {
                            [innerCap setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        }
                        else
                        {
                            [innerCap setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                        }
                    }
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_DATA] forKey:DATABASE_PRACTICE_DATA];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_NAME] forKey:HTML_JSON_KEY_NAME];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_CATETYPE] forKey:HTML_JSON_KEY_TYPE];
                    [innerCap setValue:[datanewDb valueForKey:DATABASE_PRACTICE_EDGEID] forKey:HTML_JSON_KEY_UID];
                    
                    
                    [capArr addObject:innerCap];
                    
                }
                
                
                
            }
        }
        
        //            [practice setValue:practiceArr forKey:HTML_JSON_KEY_CONTENTARRAY];
        //
        //
        //            //[practice setValue:[languageObj get:@"SCN_PRAC_PRACTICE" alter:@"PRACTICE"] forKey:HTML_JSON_KEY_NAME];
        //            // NSString * scnUid = [[NSString alloc]initWithFormat:@"%d",CO ];
        //            [practice setValue:DATABASE_CATTYPE_PRACTICE forKey:HTML_JSON_KEY_CAPTYPE];
        //            if(practice != NULL && [[practice valueForKey:HTML_JSON_KEY_CONTENTARRAY] count]>0)
        //                [capArr addObject:practice];
        
    }
    
    return scnDataDictionary;
    
    
    
    
    
    
}




-(NSArray*)getGameArr:(NSString *)uid
{
    NSString * practicestrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_EDGEID,uid];
    
    NSArray * practicecapDataArray = [dataObj SelecteQuery:practicestrfmt Table :DATABASE_TABLE_PRACTICETABLE];
    
    
    if(practicecapDataArray != NULL && [practicecapDataArray count] >0 )
    {
        NSData* data = [[[practicecapDataArray objectAtIndex:0]valueForKey:DATABASE_PRACTICE_DATA] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *e;
        return [NSJSONSerialization JSONObjectWithData:data options:0 error:&e];
        
        
        
        
    }
    return nil;
}



//-(BOOL)checkModuleDatabase:(NSInteger) EdgeId
//{
//    return [dataObj getModuleData:EdgeId];
//}


-(NSString *)getfolderPath:(int)EdgeId :(NSString *)Type
{
    NSString * strfmt;
    NSArray * capConceptDataArray;
    if([Type isEqualToString:DATABASE_CATTYPE_MODULE])
    {
        strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%ld",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_EDGEID,(long)EdgeId];
        capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_CATLOGCONTENTTABLE];
    }
    else if([Type isEqualToString:DATABASE_CATTYPE_SCENARIO])
    {
        strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%ld",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,(long)EdgeId];
        capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    }
    
    
    if(capConceptDataArray != NULL && [capConceptDataArray count] > 0)
    {
        return [[capConceptDataArray objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_DATA];
        
    }
    return @"";
}

-(NSString *)getZipfileName:(NSInteger) EdgeId : (NSString *)Type
{
    NSString * strfmt;
    NSArray * capConceptDataArray;
    if([Type isEqualToString:DATABASE_CATTYPE_MODULE] ||[Type isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML] )
    {
        strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%ld",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_EDGEID,(long)EdgeId];
        capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_CATLOGCONTENTTABLE];
    }
    else if([Type isEqualToString:DATABASE_CATTYPE_SCENARIO])
    {
        strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%ld",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,(long)EdgeId];
        capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    }
    
    if(capConceptDataArray != NULL && [capConceptDataArray count] > 0)
    {
        NSString * path =  [[capConceptDataArray objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_ZIPURL];
        NSArray* componentArray = [path componentsSeparatedByString: @"/"];
        if(componentArray != NULL && [componentArray count] > 0)
        {
            NSString* dayString = [componentArray objectAtIndex:[componentArray count] -1];
            return dayString;
        }
    }
    return @"";
}



-(NSMutableArray *) getScenarioArray: (NSString *)CatContEdgeId
{
    [Logger logAduro:@"DataManagement : Strat Function getScenarioArray" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where catContEdgeID =%@",DATABASE_TABLE_SCENARIOTABLE,CatContEdgeId];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    if(catDataArray != NULL )
    {
        [Logger logAduro:@"DataManagement : end Function getScenarioArray" ];
        return (NSMutableArray*)catDataArray;
    }
    [Logger logAduro:@"DataManagement : end Function getScenarioArray" ];
    return NULL;
}

-(NSDictionary *) getConceptXMLpath: (NSString *)EdgeId : (NSString *)catType
{
    [Logger logAduro:@"DataManagement : Strat Function getConceptArray" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ and catType =%@",DATABASE_TABLE_EXERCISETABLE,EdgeId,catType];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_EXERCISETABLE];
    if(catDataArray != NULL && [catDataArray count] > 0 )
    {
        [Logger logAduro:@"DataManagement : end Function getConceptArray" ];
        return [catDataArray objectAtIndex:0];
    }
    [Logger logAduro:@"DataManagement : end Function getConceptArray" ];
    return NULL;
}


-(NSMutableArray *) getpracticeArray: (NSString *)CatContEdgeId : (NSString *)catType
{
    [Logger logAduro:@"DataManagement : Strat Function getpracticeArray" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID =%@ and catType =%@",DATABASE_TABLE_EXERCISETABLE,CatContEdgeId,catType];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
    if(catDataArray != NULL && [catDataArray count] > 0  )
    {
        [Logger logAduro:@"DataManagement : end Function getpracticeArray" ];
        return (NSMutableArray *)catDataArray;
    }
    [Logger logAduro:@"DataManagement : end Function getpracticeArray" ];
    return NULL;
}


-(NSDictionary *) getPracticeXMLpath: (NSString *)EdgeId :(NSString *)catType
{
    [Logger logAduro:@"DataManagement : Strat Function getPracticeXMLpath" ];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where exEdgeID =%@ and catType =%@",DATABASE_TABLE_PRACTICETABLE,EdgeId,catType];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_PRACTICETABLE];
    if(catDataArray != NULL  && [catDataArray count] > 0)
    {
        [Logger logAduro:@"DataManagement : end Function getPracticeXMLpath" ];
        return [catDataArray objectAtIndex:0];
    }
    [Logger logAduro:@"DataManagement : end Function getPracticeXMLpath" ];
    return NULL;
}





-(NSMutableArray *)getVocabWordsSlider:(NSString *)pracUid
{
    [Logger logAduro:@"DataManagement : Start Function getVocabWords" ];
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID, pracUid];
    //NSMutableDictionary * mainDic = [[NSMutableDictionary alloc]init];
    
    
    return [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_VOCABWORD];
    
}


-(NSMutableArray *)getVocabWords:(NSString *)pracUid
{
    [Logger logAduro:@"DataManagement : Start Function getVocabWords" ];
    NSMutableArray * VocabWordArr = [[NSMutableArray alloc]init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID, pracUid];
    NSMutableArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_VOCABWORD];
    for (NSDictionary * vocabDict in catDataArray)
    {
        
        NSMutableDictionary * wordDict = [[NSMutableDictionary alloc]init];
        [wordDict setValue:[vocabDict valueForKey:DATABASE_VOCABWORD_EDGEID] forKey:HTML_JSON_KEY_UID];
        [wordDict setValue:[vocabDict valueForKey:DATABASE_VOCABWORD_IMAGEPATH] forKey:DATABASE_VOCABWORD_IMAGEPATH];
        [wordDict setValue:[vocabDict valueForKey:DATABASE_VOCABWORD_WORD] forKey:HTML_JSON_KEY_WORDNAME];
        [wordDict setValue:[vocabDict valueForKey:DATABASE_VOCABWORD_WORDID] forKey:HTML_JSON_KEY_WORDID];
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ ='%@' AND %@ like '%%%@%%' ",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COMPONANTID,pracUid,DATABASE_COINS_COMPONANTDATA,[vocabDict valueForKey:DATABASE_VOCAB_WORDID]];
        NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_COINSTABLE];
        if(_DataArray != NULL && [_DataArray count] > 0)
        {
            [wordDict setValue:HTML_JSON_KEY_GREEN forKey:HTML_JSON_KEY_STATUS];
        }
        else
        {
            [wordDict setValue:HTML_JSON_KEY_GRAY forKey:HTML_JSON_KEY_STATUS];
        }
        [VocabWordArr addObject:wordDict];
    }
    [Logger logAduro:@"DataManagement : End Function getVocabWords" ];
    return VocabWordArr;
}

-(BOOL)isAssessMCQData :(NSString *)edge_id
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@=%@",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_TESTID,edge_id];
    
    
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TESTTABLE];
    if(catDataArray != NULL && [catDataArray count] >0 )
    {
        return TRUE;
    }
    return FALSE;
}


-(NSMutableArray*)getAssessMCQData
{
    NSMutableArray * mainArr= [[NSMutableArray alloc]init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_ATTEMPTCOUNTER];
    NSArray * counterArr = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_ATTEMPTCOUNTER];
    
    for (NSMutableDictionary * obj  in counterArr) {
        
        
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ ",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_ATTEMPT_ID,[obj valueForKey:DATABASE_ATTEMPTCOUNTER_ATTEMPT_ID]];
        NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TESTTABLE];
        if(catDataArray != NULL)
        {
            NSMutableArray * _mainArr= [[NSMutableArray alloc]init];
            for (NSDictionary * localDic in catDataArray ) {
                
                NSMutableDictionary * nsDict =[[NSMutableDictionary alloc]init];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_ANSID] forKey:JSON_ANSUID];
                int val = [[localDic valueForKey:DATABASE_TEST_DATAMS]intValue] * 1000;
                [nsDict setValue:[[NSString alloc]initWithFormat:@"%d",val] forKey:JSON_DATAMS];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_QUESID] forKey:JSON_QUESID];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_TESTID] forKey:JSON_TESTID];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_ESSASYANSWER] forKey:DATABASE_TEST_ESSASYANSWER];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_AVMEDIAFILES] forKey:DATABASE_TEST_AVMEDIAFILES];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_COURSE_CODE] forKey:JSON_COURSE_CODE];
                [nsDict setValue:[localDic valueForKey:DATABASE_TEST_COURSEPACK] forKey:JSON_PACKAGE_CODE];
                [_mainArr addObject:nsDict];
                
                
            }
            [obj setValue:_mainArr forKey:@"ques_arr"];
            [obj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
            [obj setObject:APPVERSION forKey:JSON_APPVERSION];
            [obj setObject:@"iOS" forKey:JSON_PLATFORM];
            
        }
        [mainArr addObject:obj];
    }
    
    
    return mainArr;
}


-(NSMutableArray*)getAssessMCQDataOld
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_TESTTABLE];
    
    NSMutableArray * mainArr= [[NSMutableArray alloc]init];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TESTTABLE];
    if(catDataArray != NULL)
    {
        
        //        NSString * licence ;//=
        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        NSDictionary *licenceInfo = [defaults objectForKey:HTML_JSON_KEY_UNIQUECODE];
        //        if(licenceInfo != NULL && [licenceInfo count] >0)
        //        {
        //            licence =  [licenceInfo valueForKey:@"license_key_used"];
        //        }
        //        else
        //        {
        //            licence = @"";
        //        }
        
        for (NSDictionary * localDic in catDataArray ) {
            
            NSMutableDictionary * nsDict =[[NSMutableDictionary alloc]init];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_ANSID] forKey:JSON_ANSUID];
            int val = [[localDic valueForKey:DATABASE_TEST_DATAMS]intValue] * 1000;
            [nsDict setValue:[[NSString alloc]initWithFormat:@"%d",val] forKey:JSON_DATAMS];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_QUESID] forKey:JSON_QUESID];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_TESTID] forKey:JSON_TESTID];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_ESSASYANSWER] forKey:DATABASE_TEST_ESSASYANSWER];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_AVMEDIAFILES] forKey:DATABASE_TEST_AVMEDIAFILES];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_COURSE_CODE] forKey:JSON_COURSE_CODE];
            [nsDict setValue:[localDic valueForKey:DATABASE_TEST_COURSEPACK] forKey:JSON_PACKAGE_CODE];
            
            
            [mainArr addObject:nsDict];
            
            
        }
    }
    return mainArr;
}



-(BOOL)updateTrackComponantCompletion :(NSDictionary *)dict
{
    NSString * value = @"-1";
    if([[dict valueForKey:@"completion"] isEqualToString:@"c"]){
        value = @"1";
    }
    else if([[dict valueForKey:@"completion"] isEqualToString:@"nc"])
    {
        value = @"0";
    }
    else if([[dict valueForKey:@"completion"] isEqualToString:@"na"])
    {
        value = @"-1";
    }
    else
    {
        value = @"-1";
    }
    NSString * query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@' WHERE %@ = '%@' %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ISCOMP,value,DATABASE_TRACKINGTABLE_EDGEID,[dict valueForKey:@"edge_id"],DATABASE_TRACKINGTABLE_COURSEPACK,[dict valueForKey:@"package_code"]];
    return [dataObj updateQuery:query];
}


-(NSMutableArray *)getAllTrackDataBasedOnEdgeId :(NSString *)edgeId
{
    
    NSString * strquery = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ where %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_EDGEID,edgeId]; //,DATABASE_TRACKINGTABLE_SCNEDGEID,edgeId,DATABASE_TRACKINGTABLE_MOEDGEID,edgeId  OR %@ = '%@' OR %@ = '%@')
    [Logger logAduro:strquery];
    NSArray * trackDataArray = [dataObj SelecteQuery: strquery Table:DATABASE_TABLE_TRACKTABLE];
    NSMutableArray * mainArr= [[NSMutableArray alloc]init];
    if(trackDataArray != NULL && [trackDataArray count] > 0)
    {
        for (NSDictionary * trackDataDic in trackDataArray)
        {
            
            if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ENDTIME] longLongValue] >=  [[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_STARTTIME] longLongValue])
            {
                NSMutableDictionary * nsDict =[[NSMutableDictionary alloc]init];
                
                
                [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_EDGEID] forKey:JSON_EDGEID];
                [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_STARTTIME] forKey:JSON_SATRTTIMEMS];
                [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ENDTIME] forKey:JSON_ENDTIMEMS];
                [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSE_CODE] forKey:JSON_COURSECODE];
                [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSEPACK] forKey:JSON_COURSEPACK];
                
                if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 1)
                    [nsDict setValue:@"c" forKey:JSON_ISCOMP];
                else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 0)
                    [nsDict setValue:@"nc" forKey:JSON_ISCOMP];
                else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == -1)
                    [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                else
                    [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                
                
                
                
                
                [mainArr addObject:nsDict];
            }
            
        }
        
        
    }
    
    return mainArr;
}


-(NSMutableArray *)getAllTrackData :(int)type;
{
    double syncTime = 0 ;
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@",DATABASE_TABLE_TRACKSYNCTIME];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKSYNCTIME];
    if(dataArray != NULL && [[dataArray valueForKey:DATABASE_LOCAL_DATA] count] > 0)
    {
        syncTime = [[[dataArray  objectAtIndex:0] valueForKey:DATABASE_TRACKSYNCTIME_TIME] longLongValue];
    }
    NSString * strquery = [[NSString alloc]initWithFormat:@"SELECT *FROM %@ where %@ >= %d OR %@ = 1",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ENDTIME,0,DATABASE_TRACKINGTABLE_STARTTIME];
    
    // NSString * strquery = [[NSString alloc]initWithFormat:@"SELECT *FROM %@",DATABASE_TABLE_TRACKTABLE];
    
    [Logger logAduro:strquery];
    
    
    NSArray * trackDataArray = [dataObj SelecteQuery: strquery Table:DATABASE_TABLE_TRACKTABLE];
    NSMutableArray * mainArr= [[NSMutableArray alloc]init];
    if(trackDataArray != NULL && [trackDataArray count] > 0)
    {
        for (NSDictionary * trackDataDic in trackDataArray)
        {
            
            if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ENDTIME] longLongValue] >  [[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_STARTTIME] longLongValue])
            {
                NSMutableDictionary * nsDict =[[NSMutableDictionary alloc]init];
                if(type == 0){
                    
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_EDGEID] forKey:JSON_EDGEID];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_STARTTIME] forKey:JSON_SATRTTIMEMS];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ENDTIME] forKey:JSON_ENDTIMEMS];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSE_CODE] forKey:JSON_COURSECODE];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSEPACK] forKey:JSON_COURSEPACK];
                    
                    if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 1)
                        [nsDict setValue:@"c" forKey:JSON_ISCOMP];
                    else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 0)
                        [nsDict setValue:@"nc" forKey:JSON_ISCOMP];
                    else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == -1)
                        [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                    else
                        [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                    
                    
                }
                else
                {
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_EDGEID] forKey:JSON_EDGEID];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSE_CODE] forKey:JSON_COURSECODE];
                    [nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_COURSEPACK] forKey:JSON_COURSEPACK];
                    if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 1)
                        [nsDict setValue:@"c" forKey:JSON_ISCOMP];
                    else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == 0)
                        [nsDict setValue:@"nc" forKey:JSON_ISCOMP];
                    else if([[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] == -1)
                        [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                    else
                        [nsDict setValue:@"na" forKey:JSON_ISCOMP];
                    
                }
                
                
                [mainArr addObject:nsDict];
            }
            
        }
        
        
    }
    
    return mainArr;
}

-(BOOL)setTracktableData:(NSMutableDictionary *)data
{
    
    if(data != NULL)
    {
        
        NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:data table:DATABASE_TABLE_TRACKTABLE];
        
        
        NSString * slectQuery = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_COURSEPACK]];
        NSMutableArray * arr = [dataObj SelecteQuery:slectQuery Table:DATABASE_TABLE_TRACKTABLE];
        if(arr != NULL && [arr count] == 1)
        {
            NSMutableDictionary * obj = [arr objectAtIndex:0];
            NSString * query;
            if([[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] > [[obj valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] &&  [[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]longLongValue] >2 ){
                
                query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@='%@', %@ = '%@', %@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ISCOMP,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP],DATABASE_TRACKINGTABLE_ENDTIME,[[NSString alloc] initWithFormat:@"%lld",[[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]longLongValue]],DATABASE_TRACKINGTABLE_STARTTIME,[[NSString alloc] initWithFormat:@"%lld",[[testDictionary valueForKey:DATABASE_TRACKINGTABLE_STARTTIME]longLongValue]],DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID]];
                [Logger logDebug:query];
                [dataObj updateQuery:query];
            }
            else if([[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]longLongValue] == 0 && [[testDictionary valueForKey:DATABASE_TRACKINGTABLE_STARTTIME]longLongValue] == 0 )
            {
                if([[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] > [[obj valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue])
                {
                    query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@='%@', %@ = '%@',%@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ISCOMP,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP],DATABASE_TRACKINGTABLE_STARTTIME,@"0",DATABASE_TRACKINGTABLE_ENDTIME,@"0",DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID]];
                    [Logger logDebug:query];
                    [dataObj updateQuery:query];
                }
                else
                {
                    query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@',%@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_STARTTIME,@"0",DATABASE_TRACKINGTABLE_ENDTIME,@"0",DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID]];
                    [Logger logDebug:query];
                    [dataObj updateQuery:query];
                }
                
            }
            else if([[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue] > [[obj valueForKey:DATABASE_TRACKINGTABLE_ISCOMP]intValue])
            {
                query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@='%@' WHERE %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ISCOMP,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ISCOMP],DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID]];
                [Logger logDebug:query];
                [dataObj updateQuery:query];
            }
            else if([[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]intValue] >2)
            {
                query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@',%@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ENDTIME,[[NSString alloc] initWithFormat:@"%lld",[[testDictionary valueForKey:DATABASE_TRACKINGTABLE_ENDTIME]longLongValue]],DATABASE_TRACKINGTABLE_STARTTIME,[[NSString alloc] initWithFormat:@"%lld",[[testDictionary valueForKey:DATABASE_TRACKINGTABLE_STARTTIME]longLongValue]],DATABASE_TRACKINGTABLE_EDGEID,[testDictionary valueForKey:DATABASE_TRACKINGTABLE_EDGEID]];
                [Logger logDebug:query];
                [dataObj updateQuery:query];
            }
        }
        else
        {
            NSString * query = [self insertQueryConverter:testDictionary :DATABASE_TABLE_TRACKTABLE];
            [Logger logDebug:query];
            [dataObj insertQuery:query];
        }
        
        
        
    }
    
    return TRUE;
}

-(BOOL)setTracktableDataArr:(NSMutableArray *)dataArr
{
    
    if(dataArr != NULL &&  [dataArr count] > 0)
    {
        NSMutableArray * arr = [[NSMutableArray alloc]init];
        for (NSMutableDictionary *data in dataArr) {
            NSMutableDictionary * testDictionary = [self convertParserObjToDatabaseObj:data table:DATABASE_TABLE_TRACKTABLE];
            [arr addObject:testDictionary];
        }
        
        NSString * query = [self ArrayinsertQueryConverter:arr :DATABASE_TABLE_TRACKTABLE];
        [Logger logDebug:query];
        [dataObj insertQuery:query];
    }
    
    return TRUE;
}

-(NSMutableDictionary *)getWordData:(NSString *)uid
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_WORDID,uid];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_VOCABWORD];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        return [dataArray objectAtIndex:0];
    }
    else{
        return NULL;
    }
    
}

-(NSString *)getConceptFilePath:(NSInteger)uid
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_EDGEID,(long)uid];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_EXERCISETABLE];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        return [[dataArray objectAtIndex:0] valueForKey:DATABASE_EXERCISE_DATA];
    }
    else{
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_EDGEID,(long)uid];
        NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_PRACTICETABLE];
        if(dataArray != NULL && [dataArray count] > 0)
        {
            return [[dataArray objectAtIndex:0] valueForKey:DATABASE_PRACTICE_DATA];
        }
        else
        {
            return nil;
        }
    }
    
}

-(NSMutableDictionary *)getScnpracticeData:(NSInteger)scnPracId : (NSString *)practiceType :(NSInteger)scenarioId
{
    
    
    NSMutableDictionary * PracticeDictionary = [[NSMutableDictionary alloc]init];
    if(18 == [practiceType integerValue])
    {
        [PracticeDictionary setValue:[languageObj get:@"INSTRUCTION_WATCH" alter:@"Watch"] forKey:JSON_KEY_SUBHEADING];
    }
    else if (19 == [practiceType integerValue])
    {
        [PracticeDictionary setValue:[languageObj get:@"INSTRUCTION_ENACT" alter:@"Record"] forKey:JSON_KEY_SUBHEADING];
    }
    else if (20 == [practiceType integerValue])
    {
        [PracticeDictionary setValue:[languageObj get:@"INSTRUCTION_REVIEW" alter:@"Review"] forKey:JSON_KEY_SUBHEADING];
    }
    
    NSString * strfmtScn = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,(long)scenarioId];
    NSArray * dataScnArray = [dataObj SelecteQuery:strfmtScn Table:DATABASE_TABLE_SCENARIOTABLE];
    if(dataScnArray != NULL && [dataScnArray count] > 0)
    {
        
        
        NSString *str = [[[dataScnArray objectAtIndex:0] valueForKey:DATABASE_SCENARIO_NAME] stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        
        
        
        [PracticeDictionary setValue:str forKey:JSON_KEY_HEADING];
    }
    
    
    NSMutableArray * textVideo = [[NSMutableArray alloc]init];
    [PracticeDictionary setValue:textVideo forKey:JSON_KEY_SCNPRACTEXTARRAY];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_CONVERSATIONTABLE,DATABASE_CONVERSATION_CEDGEID,(long)scnPracId];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_CONVERSATIONTABLE];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        for (NSDictionary * unitDataDictionary in dataArray)
        {
            [PracticeDictionary setValue:[unitDataDictionary valueForKey:DATABASE_CONVERSATION_IDEALTIME] forKey:JSON_KEY_IDEALTIME];
            NSString * strfmtQues = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_QUESTION,DATABASE_QUESTION_CONUNITID,[unitDataDictionary valueForKey:DATABASE_CONVERSATION_EDGEID]];
            
            NSArray * dataQuesArray = [dataObj SelecteQuery:strfmtQues Table:DATABASE_TABLE_QUESTION];
            if(dataQuesArray != NULL && [dataQuesArray count] > 0)
            {
                for (NSDictionary * questionDataDictionary in dataQuesArray)
                {
                    NSMutableDictionary * questionData = [[NSMutableDictionary alloc]init];
                    
                    [questionData setValue:[questionDataDictionary valueForKey:DATABASE_QUESTION_VPATH] forKey:JSON_KEY_SCNPRACMEDIAPATH];
                    
                    [questionData setValue:[questionDataDictionary valueForKey:DATABASE_QUESTION_EDGEID] forKey:JSON_KEY_SCNPRACEDGE];
                    
                    
                    NSString *str1 = [[self getTextfromTable:questionDataDictionary]  stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                    
                    [questionData setValue:str1 forKey:JSON_KEY_SCNPRACTEXT];
                    
                    [questionData setValue:JSON_KEY_SCNPRACQTYPE forKey:JSON_KEY_SCNPRACQATYPE];
                    
                    [textVideo addObject:questionData];
                }
                
            }
            
            
            NSString * strfmtAns = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_ANSWER,DATABASE_ANSWER_CONUNITID,[unitDataDictionary valueForKey:DATABASE_CONVERSATION_EDGEID]];
            NSArray * dataAnsArray = [dataObj SelecteQuery:strfmtAns Table:DATABASE_TABLE_ANSWER];
            if(dataAnsArray != NULL && [dataAnsArray count] > 0)
            {
                for (NSDictionary * answerDataDictionary in dataAnsArray)
                {
                    NSMutableDictionary * AnswerData = [[NSMutableDictionary alloc]init];
                    
                    [AnswerData setValue:[answerDataDictionary valueForKey:DATABASE_ANSWER_EDGEID] forKey:JSON_KEY_SCNPRACEDGE];
                    if(18 == [practiceType integerValue])
                    {
                        [AnswerData setValue:[answerDataDictionary valueForKey:DATABASE_ANSWER_PLAYPATH] forKey:JSON_KEY_SCNPRACMEDIAPATH];
                    }
                    else{
                        [AnswerData setValue:[answerDataDictionary valueForKey:DATABASE_ANSWER_RECVIDEOPATH] forKey:JSON_KEY_SCNPRACMEDIAPATH];
                    }
                    
                    
                    
                    NSString *str1 = [[self getTextfromTable:answerDataDictionary]  stringByReplacingOccurrencesOfString:@"&#38;" withString:@"&"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                    str1 = [str1 stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                    
                    
                    
                    [AnswerData setValue:str1 forKey:JSON_KEY_SCNPRACTEXT];
                    
                    [AnswerData setValue:JSON_KEY_SCNPRACATYPE forKey:JSON_KEY_SCNPRACQATYPE];
                    
                    [textVideo addObject:AnswerData];
                }
                
            }
        }
        return PracticeDictionary;
    }
    else{
        return NULL;
    }
    
    return NULL;
}
-(NSString *)getTextfromTable:(NSDictionary *) dictionary
{
    [Logger logAduro:@"DataManagement : strat Function getTextfromTable"];
    NSMutableString * text = [[NSMutableString alloc]init];
    [text appendString:@""];
    NSString * strfmtText = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_TEXTSEGMENT,DATABASE_TEXTSEGMENT_TEXTID,[dictionary valueForKey:DATABASE_TEXTSEGMENT_TEXTID]];
    NSArray * dataTextArray = [dataObj SelecteQuery:strfmtText Table:DATABASE_TABLE_TEXTSEGMENT];
    if(dataTextArray != NULL && [dataTextArray count] > 0)
    {
        
        for (NSDictionary * textDictionary in dataTextArray)
        {
            
            [text appendString:[textDictionary valueForKey:DATABASE_TEXTSEGMENT_SIMPLETEXT]];
            [text appendString:[textDictionary valueForKey:DATABASE_TEXTSEGMENT_CLICKTEXT]];
        }
        
    }
    [Logger logAduro:@"DataManagement : exit Function getTextfromTable"];
    return text ;
}

-(BOOL)setUpdatedScnariopractice:(NSMutableDictionary *)dictionary
{
    [Logger logAduro:@"DataManagement : strat Function setUpdatedScnariopractice"];
    
    
    
    if(dictionary != NULL && [[dictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY]count] >0)
    {
        NSArray * arr = [dictionary valueForKey:JSON_KEY_SCNPRACTEXTARRAY];
        for (NSDictionary *localDictionary in arr)
        {
            NSString * query;
            if([[localDictionary valueForKey:JSON_KEY_SCNPRACQATYPE] isEqualToString:JSON_KEY_SCNPRACQTYPE])
            {
                query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_QUESTION,DATABASE_QUESTION_RECVIDEOPATH,[localDictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH],DATABASE_QUESTION_EDGEID,[localDictionary valueForKey:JSON_KEY_SCNPRACEDGE]];
                
            }
            else{
                query =[[NSString alloc] initWithFormat:@"UPDATE %@  SET %@ = '%@' WHERE %@ = '%@' ",DATABASE_TABLE_ANSWER,DATABASE_ANSWER_RECVIDEOPATH,[localDictionary valueForKey:JSON_KEY_SCNPRACMEDIAPATH],DATABASE_ANSWER_EDGEID,[localDictionary valueForKey:JSON_KEY_SCNPRACEDGE]];
            }
            [Logger logDebug:query];
            [dataObj updateQuery:query];
        }
    }
    [Logger logAduro:@"DataManagement : exit Function setUpdatedScnariopractice"];
    return TRUE;
}

-(NSString *)getSecnarioInstruction:(NSInteger)scnPracId :(NSString *)coursepack
{
    [Logger logAduro:@"DataManagement : start Function getSecnarioInstruction" ];
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_EDGEID,(long)scnPracId];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_PRACTICETABLE];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        NSMutableDictionary * instruction = [[NSMutableDictionary alloc]init];
        
        NSMutableArray * instructionArray = [[NSMutableArray alloc]init];
        [instruction setValue:instructionArray forKey:HTML_JSON_KEY_INSTRUCTION];
        NSMutableDictionary * watchObseve = [[NSMutableDictionary alloc]init];
        [watchObseve setValue:[languageObj get:@"INSTRUCTION_WATCH" alter:@"Watch"] forKey:HTML_JSON_KEY_NAME];
        [watchObseve setValue:DATABASE_CATTYPE_WATCH_OBSERVE forKey:HTML_JSON_KEY_UID];
        
        NSString * watchId = [[dataArray objectAtIndex:0] valueForKey:DATABASE_PRACTICE_WATCHEDGEID];
        
        NSString * strfmtWatch = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,watchId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        NSArray * watchDataArray = [dataObj SelecteQuery:strfmtWatch Table:DATABASE_TABLE_TRACKTABLE];
        if(watchDataArray != NULL && [watchDataArray count] > 0)
        {
            [watchObseve setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
        }
        else
        {
            NSString * _strfmtWatch = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,watchId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
            NSArray * _watchDataArray = [dataObj SelecteQuery:_strfmtWatch Table:DATABASE_TABLE_TRACKTABLE];
            if(_watchDataArray != NULL && [_watchDataArray count] > 0)
            {
                [watchObseve setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                
            }
            else
            {
                [watchObseve setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
            }
        }
        
        [watchObseve setValue:watchId forKey:HTML_JSON_KEY_EDGEID];
        [instructionArray addObject:watchObseve];
        
        
        NSMutableDictionary * enact = [[NSMutableDictionary alloc]init];
        [enact setValue:[languageObj get:@"INSTRUCTION_ENACT" alter:@"Record"] forKey:HTML_JSON_KEY_NAME];
        [enact setValue:DATABASE_CATTYPE_ENACT_SCN forKey:HTML_JSON_KEY_UID];
        
        NSString * enactId = [[dataArray objectAtIndex:0] valueForKey:DATABASE_PRACTICE_ENACTEDGEID];
        
        NSString * strfmtEnact = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,enactId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        
        
        //        NSString * strfmtEnact = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ =%@ AND %@ = '%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,enactId,DATABASE_TRACKINGTABLE_TRACKTYPE,DATABASE_CATTYPE_ENACT_SCN,DATABASE_TRACKINGTABLE_ISCOMP,EDGECOMPLETE,DATABASE_COURSEPACK_COURSEPACKCODE ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        NSArray * enactDataArray = [dataObj SelecteQuery:strfmtEnact Table:DATABASE_TABLE_TRACKTABLE];
        if(enactDataArray != NULL && [enactDataArray count] > 0)
        {
            [enact setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
            
        }
        else
        {
            NSString * _strfmtEnact = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,enactId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
            NSArray * _enactDataArray = [dataObj SelecteQuery:_strfmtEnact Table:DATABASE_TABLE_TRACKTABLE];
            if(_enactDataArray != NULL && [_enactDataArray count] > 0)
            {
                [enact setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                
            }
            else
            {
                [enact setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
            }
        }
        
        [enact setValue:enactId forKey:HTML_JSON_KEY_EDGEID];
        
        //        [enact setValue:@"0" forKey:HTML_JSON_KEY_ISCOMPLETE];
        //        [enact setValue: forKey:HTML_JSON_KEY_EDGEID];
        [instructionArray addObject:enact];
        NSMutableDictionary * review = [[NSMutableDictionary alloc]init];
        [review setValue:[languageObj get:@"INSTRUCTION_REVIEW" alter:@"Review"] forKey:HTML_JSON_KEY_NAME];
        [review setValue:DATABASE_CATTYPE_REVIEW forKey:HTML_JSON_KEY_UID];
        
        NSString * reviewId = [[dataArray objectAtIndex:0] valueForKey:DATABASE_PRACTICE_REVIEW_EDGEID];
        
        //NSString * strfmtReview = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ =%@ AND %@ =%@ AND %@ = '%@'AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,reviewId,DATABASE_TRACKINGTABLE_TRACKTYPE,DATABASE_CATTYPE_REVIEW,DATABASE_TRACKINGTABLE_ISCOMP,EDGECOMPLETE,DATABASE_COURSEPACK_COURSEPACKCODE ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        
        NSString * strfmtReview = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,reviewId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        
        NSArray * reviewDataArray = [dataObj SelecteQuery:strfmtReview Table:DATABASE_TABLE_TRACKTABLE];
        if(reviewDataArray != NULL && [reviewDataArray count] > 0)
        {
            [review setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
            
        }
        else
        {
            NSString * _strfmtReview = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ ='%@' AND %@ ='%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,reviewId,DATABASE_TRACKINGTABLE_COURSEPACK ,coursepack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
            
            NSArray * _reviewDataArray = [dataObj SelecteQuery:_strfmtReview Table:DATABASE_TABLE_TRACKTABLE];
            if(_reviewDataArray != NULL && [_reviewDataArray count] > 0)
            {
                [review setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                
            }
            else
            {
                [review setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
            }
        }
        
        
        
        [review setValue:reviewId forKey:HTML_JSON_KEY_EDGEID];
        [instructionArray addObject:review];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:instruction
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //NSLog(@"json %@", rawdata);
        }
        
    }
    else{
        return NULL;
    }
    
    
    [Logger logAduro:@"DataManagement : exit Function getSecnarioInstruction" ];
    return NULL;
}
-(BOOL)setVocabWord:(NSDictionary *)vocabWordData
{
    [Logger logAduro:@"DataManagement : exit Function setVocabWord" ];
    if(vocabWordData != NULL)
    {
        NSString * strfmt = [[NSString alloc]initWithFormat:@"UPDATE %@ SET %@ = %@  WHERE %@ ='%@' ",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_PSCORE,[vocabWordData valueForKey:DATABASE_VOCABWORD_PSCORE],DATABASE_VOCABWORD_WORDID,[vocabWordData valueForKey:DATABASE_VOCABWORD_WORDID] ];
        [Logger logAduro:strfmt];
        [dataObj updateQuery:strfmt];
        
        NSString * strfmtQuery = [[NSString alloc]initWithFormat:@"UPDATE %@ SET %@ = %@  WHERE %@ ='%@' ",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_ISCOMP,[vocabWordData valueForKey:DATABASE_VOCAB_ISCOMP],DATABASE_VOCABWORD_WORDID,[vocabWordData valueForKey:DATABASE_VOCABWORD_WORDID] ];
        [Logger logAduro:strfmtQuery];
        return [dataObj updateQuery:strfmtQuery];
        
        
        
    }
    
    [Logger logAduro:@"DataManagement : exit Function setVocabWord" ];
    
    return TRUE;
}
-(int)getIdealTime:(NSInteger )conceptId
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%ld'",DATABASE_TABLE_CONVERSATIONTABLE,DATABASE_CONVERSATION_CEDGEID,(long)conceptId];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_CONVERSATIONTABLE];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        return [[[dataArray objectAtIndex:0] valueForKey:DATABASE_CONVERSATION_IDEALTIME] intValue];
    }
    else{
        return 0;
    }
}





// IR CALCULATION

-(NSMutableArray *)getCatelogDataForIr
{
    if(appDelegate.courseCode == nil ||[appDelegate.courseCode isEqualToString:@""] ) return nil;
    NSString * Lquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    
    NSArray * arr =[dataObj SelecteQuery:Lquery Table:DATABASE_TABLE_COURSETABLE];
    
    if(arr != NULL && [arr count] >0)
    {
        NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@'",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID  ,[[arr objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
        
        return [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    }
    else
    {
        return Nil;
    }
    //NSString * query = @"SELECT * from CatLogContentTable whe";
    
    
    
    
}

-(NSMutableArray *)getScnArrayForIr:(NSString *)strUid
{
    NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",strUid];
    return [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
    
    
}
-(NSInteger)getMaxScore:(NSString *)uID :(NSString *)type
{
    
    
    //@"select * from %@ where %@ =%@ AND %@ =%@ AND %@ = (SELECT max(%@) FROM %@) order by id desc limit 1"
    
    NSString * strMax = [[NSString alloc]initWithFormat:@"Select moduleID, scenarioID, edgeID, trackType,  avg(usageScore) usageScore , isComplete, startTime, endTime  from %@ WHERE %@ =%@ AND %@ =%@",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,uID,DATABASE_TRACKINGTABLE_TRACKTYPE,type];
    NSArray * dataArray = [dataObj SelecteQuery:strMax Table:DATABASE_TABLE_TRACKTABLE];
    if(dataArray != NULL && [dataArray count] > 0)
    {
        return [[[dataArray objectAtIndex:0]valueForKey:DATABASE_TRACKINGTABLE_USAGESCORE] integerValue];
    }
    return 0;
    
}


-(BOOL)setUpdateScore:(float)score :(NSString *)uid :(NSString *)table
{
    //    if([table isEqualToString:DATABASE_TABLE_SCENARIOTABLE])
    //    {
    //        NSString * strfmtQuery = [[NSString alloc]initWithFormat:@"UPDATE %@ SET %@ = %f  WHERE %@ ='%@' ",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_IR,score,DATABASE_SCENARIO_EDGEID,uid];
    //        [Logger logAduro:strfmtQuery];
    //        return [dataObj updateQuery:strfmtQuery];
    //    }
    //    else if([table isEqualToString:DATABASE_TABLE_CATLOGCONTENTTABLE])
    //    {
    ////        NSString * strfmtQuery = [[NSString alloc]initWithFormat:@"UPDATE %@ SET %@ = %f  WHERE %@ ='%@' ",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_IR,score,DATABASE_CATLOGCONT_EDGEID,uid];
    ////        [Logger logAduro:strfmtQuery];
    ////        return [dataObj updateQuery:strfmtQuery];
    //        
    //    }
    return TRUE;
}

-(NSMutableArray *)getCAPArray:(NSString *)uID :(NSString *)type
{
    NSString * newStrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@ AND %@ =%@ ",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_CEDGEID,uID ,DATABASE_EXERCISE_CATTYPE,type];
    
    return [dataObj SelecteQuery:newStrfmt Table:DATABASE_TABLE_EXERCISETABLE];
}
-(NSMutableArray *)getSCNPracArr:(NSString *)uID :(NSString *)type
{
    NSString * newStrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@ AND %@ =%@ ",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_CEDGEID,uID ,DATABASE_PRACTICE_CATETYPE,type];
    
    return [dataObj SelecteQuery:newStrfmt Table:DATABASE_TABLE_PRACTICETABLE];
}

-(NSMutableArray *)getVocabArray:(NSString *)uID
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_EDGEID, uID];
    
    // NSString * newStrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_VOCABULARY,DATABASE_VOCAB_CEDGEID,uID ];
    
    return [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_VOCABWORD];
}
-(NSDictionary *)getVocabWord:(NSString *)uID;
{
    NSString * newStrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%@",DATABASE_TABLE_VOCABWORD,DATABASE_VOCABWORD_WORDID,uID ];
    
    NSArray * dataArr =  [dataObj SelecteQuery:newStrfmt Table:DATABASE_TABLE_VOCABWORD];
    if(dataArr != NULL && [dataArr count] >0)
    {
        return [dataArr objectAtIndex:0];
    }
    return NULL;
}

-(BOOL)isShowProfile:(NSString *)coursePack{
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM TrackingTable WHERE %@='%@' AND %@='%@'",DATABASE_TRACKINGTABLE_COURSE_CODE,appDelegate.courseCode,DATABASE_TRACKINGTABLE_COURSEPACK,coursePack];
    NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
    if(LDataArray != NULL && [LDataArray count] > 0)
    {
        return TRUE;
    }
    else{
        return FALSE;
    }
    
}

-(NSString *)getDashboardData:(NSString *)coursePack
{
    [Logger logAduro:@"DataManagement : start Function getDashboardData" ];
    int AssessmentCount = 0;
    int ScenarioCount = 0;
    double yourIRScore = 0;
    int TotelTimeSpent = 0;
    int TotelScn =0;
    int completeScn =0;
    NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    NSDictionary * obj = [courseArr objectAtIndex:0];
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
    NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    if(catDataArray != NULL )
    {
        NSMutableArray * yourArr = [[NSMutableArray alloc]init];
        NSMutableArray * AvgArr = [[NSMutableArray alloc]init];
        NSMutableArray * nameArr = [[NSMutableArray alloc]init];
        for (int i =0; i < [catDataArray count] ; i++)
        {
            
            NSDictionary * dataDb = [catDataArray objectAtIndex:i];
            
            if([[dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
            {
                TotelScn++;
                
                
                if([self checkPath:[dataDb valueForKey:DATABASE_CATLOGCONT_DATA]]){
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM TrackingTable where edgeID = %@ AND %@ = '%@' group by edgeID;",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack];
                    NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(LDataArray != NULL && [LDataArray count] > 0)
                    {
                        completeScn ++;
                        double duration = [[[LDataArray objectAtIndex:0] valueForKey:@"endTime"] longLongValue] - [[[LDataArray objectAtIndex:0] valueForKey:@"startTime"] longLongValue];
                        
                        float minute =ceil(duration/60000);
                        TotelTimeSpent = TotelTimeSpent + minute;
                        
                        [yourArr addObject:[NSString stringWithFormat:@"%d", (int)ceil(minute)]];
                    }
                    else
                    {
                        [yourArr addObject:@"0"];
                    }
                }
                else
                {
                    [yourArr addObject:@"0"];
                }
                
                
                
                [nameArr addObject:[[NSString alloc]initWithFormat:@"A%d",++AssessmentCount]];
            }
            else
            {
                
                
                NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                
                NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
                if(scnDataArray != NULL)
                {
                    for (int j =0; j < [scnDataArray count] ; j++)
                    {
                        NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                        TotelScn ++;
                        if([self checkPath:[datascnDb valueForKey:DATABASE_SCENARIO_DATA]]){
                            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM TrackingTable  where edgeID = %@ AND %@ = '%@' group by edgeID;",[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack];
                            
                            NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                            if(LDataArray != NULL && [LDataArray count] > 0)
                            {
                                completeScn ++;
                                double duration = [[[LDataArray objectAtIndex:0] valueForKey:@"endTime"] longLongValue] - [[[LDataArray objectAtIndex:0] valueForKey:@"startTime"] longLongValue];
                                
                                float minute =ceil(duration/60000);
                                TotelTimeSpent = TotelTimeSpent + minute;
                                [yourArr addObject:[NSString stringWithFormat:@"%d", (int)ceil(minute)]];
                            }
                            else
                            {
                                [yourArr addObject:@"0"];
                            }
                        }
                        else{
                            [yourArr addObject:@"0"];
                        }
                        
                        
                        yourIRScore = yourIRScore + [self getAssesmentMCQScore:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]:coursePack]*5;
                        [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)yourIRScore] forKey:HTML_JSON_KEY_IRDATA];
                        [nameArr addObject:[[NSString alloc]initWithFormat:JSON_COURSE_TYPE,++ScenarioCount]];
                        
                        
                    }
                }
            }
            
        }
        [catDic setValue:yourArr forKey:HTML_JSON_KEY_YOURIR];
        [catDic setValue:AvgArr forKey:HTML_JSON_KEY_AVGIR];
        [catDic setValue:nameArr forKey:HTML_JSON_KEY_ARRAY];
        NSString *query = @"SELECT * from UserInfoTable where rowid = 1;";
        NSArray * dataArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_USERINFO];
        if(dataArray != NULL && [dataArray count] >0)
        {
            [catDic setValue:[[dataArray objectAtIndex:0]valueForKey:DATABASE_USERNAME ] forKey:HTML_JSON_KEY_NAME]  ;
        }
        else{
            [catDic setValue:@" User" forKey:HTML_JSON_KEY_NAME];
        }
        [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)ceil(yourIRScore)] forKey:HTML_JSON_KEY_IRPERCENTAGEDATA];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableString * str = [[NSMutableString alloc]initWithFormat:@"T%@",appDelegate.courseCode];
        
        
        
        
        
        NSString *Value = [defaults objectForKey:str];
        
        
        double value = 0 ;
        
        if(  Value != nil && [Value integerValue] != 0)
        {
            value =  ceil((TotelTimeSpent*100)/ [Value intValue]);
        }
        else{
            value =  ceil((TotelTimeSpent*100/40));
        }
        
        
        [catDic setValue:[[NSMutableString alloc]initWithFormat:@"%d",(int)ceil(TotelTimeSpent)] forKey:HTML_JSON_KEY_PERCENTAGE];
        
        
        
        int coins = ceil((yourIRScore/(TotelScn*5))*100);
        
        
        
        if(coins > value)
        {
            if(coins >= 0 && coins <=30 ){
                [catDic setValue:FOUR forKey:HTML_JSON_KEY_BADGENO];
            }
            else if(coins >= 31 && coins <=50){
                
                [catDic setValue:THREE forKey:HTML_JSON_KEY_BADGENO];
            }
            else if(coins >= 51 && coins <=80){
                
                [catDic setValue:TWO forKey:HTML_JSON_KEY_BADGENO];
            }
            else
            {
                [catDic setValue:ONE forKey:HTML_JSON_KEY_BADGENO];
            }
        }
        else
        {
            if(value >= 0 && value <=30 ){
                [catDic setValue:FOUR forKey:HTML_JSON_KEY_BADGENO];
            }
            else if(value >= 31 && value <=50){
                
                [catDic setValue:THREE forKey:HTML_JSON_KEY_BADGENO];
            }
            else if(value >= 51 && value <=80){
                
                [catDic setValue:TWO forKey:HTML_JSON_KEY_BADGENO];
            }
            else
            {
                [catDic setValue:ONE forKey:HTML_JSON_KEY_BADGENO];
            }
        }
        
        
        //        if(value >= 100)
        //
        //        {
        //            value = 100;
        //            [catDic setValue:[[NSMutableString alloc]initWithFormat:@"%d",100] forKey:HTML_JSON_KEY_PERCENTAGE];
        //        }
        //        else
        //        {
        //            [catDic setValue:[[NSMutableString alloc]initWithFormat:@"%d",(int)ceil(value)] forKey:HTML_JSON_KEY_PERCENTAGE];
        //        }
        
        
        
        
        
        
        
        
        
        //        if((yourIRScore +  value)/2  < 20){// <100 : 3 <500 : 2 >500 :1
        //            [catDic setValue:THREE forKey:HTML_JSON_KEY_BADGENO];
        //        }
        //        else if((yourIRScore +  value)/2 >=20 && (yourIRScore +  value)/2 < 80){
        //
        //            [catDic setValue:TWO forKey:HTML_JSON_KEY_BADGENO];
        //        }
        //        else{
        //            [catDic setValue:ONE forKey:HTML_JSON_KEY_BADGENO];
        //        }
        
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:catDic
                                                           options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                             error:&error];
        
        if (! jsonData) {
            NSLog(@"Got an error: %@", error);
        } else {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //NSLog(@"json %@", rawdata);
        }
        
    }
    
    
    return @"";
}

-(NSMutableDictionary *)getDashboardDataWithType
{
    
    int TotelScn =0;
    int TotelTopic =0;
    int completeScn =0;
    int completeTopic =0;
    int total_coin = 0;
    NSMutableArray * TopicArr = [[NSMutableArray alloc]init];
    NSMutableArray * TopicCoinArr = [[NSMutableArray alloc]init];
    
    
    
    NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    NSDictionary * obj = [courseArr objectAtIndex:0];
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
    NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    for (NSDictionary * dataDb in catDataArray) {
        NSMutableArray * ChapterCoinArr = [[NSMutableArray alloc]init];
        NSMutableArray * ChapterArr = [[NSMutableArray alloc]init];
        if([[dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
        {
            TotelTopic++;
            NSMutableDictionary * topicDict = [[NSMutableDictionary alloc]init];
            [topicDict setValue:[[NSString alloc]initWithFormat:@"L%d",TotelTopic] forKey:@"topic_name"];
            NSDictionary * time_coins_data  = [self getChapterTotalTime:[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
            double duration = [[time_coins_data valueForKey:@"time"]doubleValue];
            int coins = [[time_coins_data valueForKey:@"coins"]intValue];
            total_coin = total_coin+coins;
            [topicDict setValue:[time_coins_data valueForKey:@"coins"] forKey:@"coin"];
            float minute =ceil(duration/60000);
            [topicDict setValue:[NSString stringWithFormat:@"%d", (int)ceil(minute)] forKey:@"time"];
            
            strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
            
            NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
            if(DataArray != NULL && [DataArray count] > 0)
            {
                completeTopic++;
                
            }
            
            [topicDict setValue:ChapterArr forKey:@"chapter_Array"];
            [topicDict setValue:ChapterCoinArr forKey:@"chapter_coin_Array"];
            [topicDict setValue:[NSString stringWithFormat:@"%d",TotelScn] forKey:@"chapter_count"];
            [topicDict setValue:[NSString stringWithFormat:@"%d", completeScn] forKey:@"chapter_complete_count"];
            [topicDict setValue:[NSString stringWithFormat:@"%d", total_coin] forKey:@"total_coins"];
            
            
            [TopicArr addObject:topicDict];
            [TopicArr addObject:topicDict];
        }
        else
        {
            TotelTopic++;
            NSMutableDictionary * topicDict = [[NSMutableDictionary alloc]init];
            [topicDict setValue:[[NSString alloc]initWithFormat:@"L%d",TotelTopic] forKey:@"topic_name"];
            
            int l_coins =0;
            //[topicDict setValue:@"0" forKey:@"coin"];
            
            strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
            
            NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
            if(DataArray != NULL && [DataArray count] > 0)
            {
                completeTopic++;
                
            }
            int _topicTimeCount = 0;
            NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
            
            NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
            if(scnDataArray != NULL)
            {
                for (int j =0; j < [scnDataArray count] ; j++)
                {
                    
                    NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                    TotelScn ++;
                    NSMutableDictionary * chapDict = [[NSMutableDictionary alloc]init];
                    [chapDict setValue:[[NSString alloc]initWithFormat:@"C%d",TotelTopic] forKey:@"chapter_name"];
                    [chapDict setValue:@"0" forKey:@"coin"];
                    NSDictionary * time_coins_data  = [self getChapterTotalTime:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]];
                    
                    
                    double duration = [[time_coins_data valueForKey:@"time"]doubleValue];
                    int coins = [[time_coins_data valueForKey:@"coins"]intValue];
                    l_coins = l_coins+coins;
                    
                    
                    
                    float minute =ceil(duration/60000);
                    _topicTimeCount = _topicTimeCount+minute;
                    [topicDict setValue:[NSString stringWithFormat:@"%d", (int)ceil(minute)] forKey:@"time"];
                    
                    strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        completeScn++;
                        
                    }
                    
                    
                    [ChapterArr addObject:chapDict];
                    
                }
            }
            [topicDict setValue:[NSString stringWithFormat:@"%d", (int)ceil(_topicTimeCount)] forKey:@"time"];
            [topicDict setValue:[NSString stringWithFormat:@"%d",l_coins] forKey:@"coin"];
            total_coin = total_coin+l_coins;
            
            
            
            
            
            
            [topicDict setValue:ChapterArr forKey:@"chapter_Array"];
            [topicDict setValue:ChapterCoinArr forKey:@"chapter_coin_Array"];
            [topicDict setValue:[NSString stringWithFormat:@"%d",TotelScn] forKey:@"chapter_count"];
            [topicDict setValue:[NSString stringWithFormat:@"%d", completeScn] forKey:@"chapter_complete_count"];
            [topicDict setValue:[NSString stringWithFormat:@"%d", total_coin] forKey:@"total_coins"];
            [TopicArr addObject:topicDict];
        }
        
    }
    [catDic setValue:TopicArr forKey:@"topic_Array"];
    [catDic setValue:TopicCoinArr forKey:@"topic_coin_Array"];
    [catDic setValue:[NSString stringWithFormat:@"%d",TotelTopic] forKey:@"topic_count"];
    [catDic setValue:[NSString stringWithFormat:@"%d", completeTopic] forKey:@"topic_complete_count"];
    [catDic setValue:[NSString stringWithFormat:@"%d", total_coin] forKey:@"total_coins"];
    
    
    
    
    
    
    
    int value = 0;
    if(value >= 0 && value <=30 ){
        [catDic setValue:FOUR forKey:HTML_JSON_KEY_BADGENO];
    }
    else if(value >= 31 && value <=50){
        
        [catDic setValue:THREE forKey:HTML_JSON_KEY_BADGENO];
    }
    else if(value >= 51 && value <=80){
        
        [catDic setValue:TWO forKey:HTML_JSON_KEY_BADGENO];
    }
    else
    {
        [catDic setValue:ONE forKey:HTML_JSON_KEY_BADGENO];
    }
    
    return catDic;
}



-(NSDictionary *)getCurrentSession :(NSString *)str
{
    
    
    NSString * strScn = [[NSString alloc]initWithFormat:@"Select * from %@ WHERE %@ =%@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,str];
    NSArray * datascnArray = [dataObj SelecteQuery:strScn Table:DATABASE_TABLE_SCENARIOTABLE];
    if(datascnArray != NULL && [datascnArray count] > 0)
    {
        return [datascnArray objectAtIndex:0];
    }
    
    
    return NULL;
}

-(NSMutableDictionary *)getPracticeMCQList
{
    
    //NSString * data=@"";
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%d",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_CATETYPE,21 ];
    NSMutableDictionary * mcqData ;
    NSMutableArray * mcqDataArr ;
    NSMutableArray * lcatDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_PRACTICETABLE];
    if(lcatDataArray != NULL)
    {
        NSLog(@"%@",lcatDataArray);
        mcqData = [[NSMutableDictionary alloc]init];
        mcqDataArr = [[NSMutableArray alloc]init];
        int j =0;
        for (NSDictionary * obj in lcatDataArray )
        {
            NSMutableDictionary * lclObj= [[NSMutableDictionary alloc]init];
            [lclObj setValue:[obj valueForKey:DATABASE_PRACTICE_NAME] forKey:JSON_PRACTICENAME];
            [lclObj setValue:[obj valueForKey:DATABASE_PRACTICE_DESC] forKey:HTML_JSON_KEY_DESC];
            
            
            NSString * strfmtscore = [[NSString alloc]initWithFormat:@"SELECT * from %@  where  %@=%@ ORDER BY %@ DESC",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID, [obj valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TRACKINGTABLE_STARTTIME];
            
            NSArray * trackDataArray = [dataObj SelecteQuery:strfmtscore Table :DATABASE_TABLE_TRACKTABLE];
            if(trackDataArray != NULL && [trackDataArray count] >0 )
            {
                [lclObj setValue:[[trackDataArray objectAtIndex:0] valueForKey:DATABASE_TRACKINGTABLE_USAGESCORE] forKey:HTML_JSON_KEY_SCORE];
            }
            else{
                [lclObj setValue:@"0" forKey:HTML_JSON_KEY_SCORE];
            }
            
            
            //[lclObj setValue:@"0" forKey:HTML_JSON_KEY_SCORE];
            [lclObj setValue:[obj valueForKey:DATABASE_PRACTICE_EDGEID] forKey:HTML_JSON_KEY_UID];
            [lclObj setValue:[obj valueForKey:DATABASE_PRACTICE_CATETYPE] forKey:JSON_KEY_TYPE];
            
            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where  %@=%@",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_EDGEID, [obj valueForKey:DATABASE_PRACTICE_CEDGEID]];
            
            NSArray * capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_EXERCISETABLE];
            if(capConceptDataArray != NULL && [capConceptDataArray count] >0 )
            {
                [lclObj setValue:[[capConceptDataArray objectAtIndex:0] valueForKey:DATABASE_EXERCISE_CEDGEID] forKey:JSON_KEY_SCNUID];
            }
            
            [mcqDataArr addObject:lclObj];
            
        }
        
        
        
        [mcqData setValue:mcqDataArr forKey:JSON_MCQ];
    }
    
    [Logger logAduro:@"DataManagement : Exit Function getAssessmnetMCQData" ];
    return mcqData;
    
    
}
-(NSString *)getLastpracticeTextUid
{
    NSString * strfmtscore = [[NSString alloc]initWithFormat:@"SELECT * from %@  where  %@=%@ ORDER BY %@ DESC",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_TRACKTYPE, DATABASE_CATTYPE_MCQ_PRACTICE_XML,DATABASE_TRACKINGTABLE_EDGEID];
    
    NSArray * trackDataArray = [dataObj SelecteQuery:strfmtscore Table :DATABASE_TABLE_TRACKTABLE];
    if(trackDataArray != NULL && [trackDataArray count] >0 )
    {
        return [[trackDataArray objectAtIndex:0] valueForKey:DATABASE_TRACKINGTABLE_EDGEID];
    }
    return @"";
}


-(int)getCourseVersion :(NSString *)LcourseCode
{
    NSString *query = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,LcourseCode];
    
    NSArray * dataArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_COURSETABLE];
    if( dataArray != NULL && [dataArray count] >0)
    {
        int ver =[[[dataArray objectAtIndex:0] valueForKey:DATABASE_COURSE_VER] intValue];
        return ver;
    }
    else
    {
        return 0;
    }
    return 0;
}




-(NSString *)getCourseXml
{
    
    NSString * data = @"";
    NSMutableString * path = [[NSMutableString alloc]initWithFormat:@"%@/%@/%@/course.xml",ROOTFOLDERNAME,appDelegate.courseCode,COURSEZIPFOLDERNAME];
    NSString * pathStr = [self getPathWithoutRoot:path ];
    
    NSMutableDictionary * dict = [[NSMutableDictionary alloc]init];
    [dict setValue:pathStr forKey:@"path"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        // NSLog(@"json %@", data);
    }
    
    [Logger logAduro:@"DataManagement : Exit Function getCourseXml" ];
    return data;
}


-(NSDictionary *)getTopicDataOnly : (NSString *)topicId
{
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE, DATABASE_CATLOGCONT_EDGEID,topicId];
    return [[dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE] objectAtIndex:0];
    
    
}

-(NSDictionary *)getTopicData : (NSString *)topicId : (NSString *)courseEdgeId :(NSString *)chapterId :(NSString *)assessment_type
{
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ ='1' AND NOT assessment_type = '1'",DATABASE_TABLE_CATLOGCONTENTTABLE, DATABASE_CATLOGCONT_CEDGEID,courseEdgeId,DATABASE_CATLOGCONT_TOPIC_TYPE ];
    NSMutableArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    int counter = 1;
    for (NSMutableDictionary * obj  in catDataArray) {
        if([[obj valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4)
            [obj setValue:[[NSString alloc]initWithFormat:@"%d",counter++] forKey:HTML_JSON_KEY_TOPIC_COUNTER];
        if([[obj valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [topicId intValue] && ([assessment_type isEqualToString:@"chapter"] ||[assessment_type isEqualToString:@""]))
        {
            NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE, DATABASE_SCENARIO_CEDGEID,topicId];
            NSMutableArray * scnArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_SCENARIOTABLE];
            for (NSMutableDictionary * scnObj  in scnArray) {
                if([[scnObj valueForKey:DATABASE_SCENARIO_EDGEID]intValue] == [chapterId intValue])
                {    [scnObj setValue:[obj valueForKey:DATABASE_CATLOGCONT_NAME] forKey:@"topicName"];
                    [obj setValue:scnObj forKey:@"scnArr"];
                    return obj;
                }
            }
            
            if([scnArray count]>0){
                [[scnArray objectAtIndex:0] setValue:[obj valueForKey:DATABASE_CATLOGCONT_NAME] forKey:@"topicName"];
                [obj setValue:[scnArray objectAtIndex:0] forKey:@"scnArr"];
                return obj;
            }
            else
            {
                return obj;
            }
        }
        else if([[obj valueForKey:DATABASE_CATLOGCONT_EDGEID]intValue] == [topicId intValue] && [assessment_type isEqualToString:@"assessment"])
        {
            return obj;
        }
    }
    if([catDataArray count]>0)
    {
        NSMutableDictionary *_obj =  [catDataArray objectAtIndex:0];
        [_obj setValue:[[NSString alloc]initWithFormat:@"%d",1] forKey:HTML_JSON_KEY_TOPIC_COUNTER];
        NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE, DATABASE_SCENARIO_CEDGEID,[_obj valueForKey:DATABASE_CATLOGCONT_EDGEID]];
        NSMutableArray * scnArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_SCENARIOTABLE];
        if([scnArray count]>0){
            [[scnArray objectAtIndex:0] setValue:[_obj valueForKey:DATABASE_CATLOGCONT_NAME] forKey:@"topicName"];
            [_obj setValue:[scnArray objectAtIndex:0] forKey:@"scnArr"];
            return _obj;
        }
        else
        {
            return _obj;
        }
        
    }
    else
    {
        return nil;
    }
    
    
}

-(NSMutableArray *)getAllTopicData
{
    NSMutableArray * catDataArray = nil;
    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND  %@ ='1' AND NOT assessment_type = '1'",DATABASE_TABLE_CATLOGCONTENTTABLE, DATABASE_CATLOGCONT_CEDGEID,[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE],DATABASE_CATLOGCONT_TOPIC_TYPE];
    
    catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    int i =0;
    int topicCounter =0;
    int nextunlockitem = -1;
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSMutableDictionary * obj1 in catDataArray) {
        i ++;
        if([[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4)
        {
            topicCounter ++;
            [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",topicCounter] forKey:HTML_JSON_KEY_TOPIC_COUNTER];
        }
        else
        {
            [obj1 setValue:@"" forKey:HTML_JSON_KEY_TOPIC_COUNTER];
            
        }
        
        
        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
        
        NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
        if(DataArray != NULL && [DataArray count] > 0)
        {
            [obj1 setValue:EDGECOMPLETE forKey:DATABASE_CATLOGCONT_ISCOMP];
            [obj1 setValue:@"100" forKey:HTML_JSON_KEY_IRDATA];
            nextunlockitem ++;
            
        }
        else
        {
            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
            NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
            if(_DataArray != NULL && [_DataArray count] > 0)
            {
                [obj1 setValue:EDGENOTCOMPLETE forKey:DATABASE_CATLOGCONT_ISCOMP];
            }
            else
            {
                [obj1 setValue:EDGENOTSTARTED forKey:DATABASE_CATLOGCONT_ISCOMP];
            }
            
            int completionFlag = 2;
            
            NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_SCENARIO_IS_HIDE, @"0"];
            NSMutableArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
            int chapComCounter = 0;
            
            
            if(scnDataArray != NULL && [scnDataArray count] >0 )
            {
                for (int j =0; j < [scnDataArray count] ; j++)
                {
                    bool val = true;
                    NSMutableDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        // [innerCap setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        val = false;
                        chapComCounter ++;
                    }
                    else
                    {
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                        NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(_DataArray != NULL && [_DataArray count] > 0)
                        {
                            if(completionFlag == 2 || completionFlag == 0 )
                                completionFlag = 1;
                            
                        }
                        else
                        {
                            if(completionFlag == 2 && val )
                                completionFlag = 0;
                            else
                            {
                                completionFlag = 1;
                                val = true;
                            }
                        }
                        
                    }
                    
                }
                //                    NSMutableDictionary * data = [[NSMutableDictionary alloc]init];
                //                    [data setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:NATIVE_JSON_KEY_MODULEID];
                //                    [data setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:NATIVE_JSON_KEY_SCNID];
                //                    [data setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:NATIVE_JSON_KEY_EDGEID];
                //                    [data setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE] forKey:NATIVE_JSON_KEY_TYPE];
                //                    [data setValue:EDGEZEROSCORE forKey:NATIVE_JSON_KEY_USAGESCORE];
                //
                //                    [data setValue:@"1" forKey:NATIVE_JSON_KEY_STARTTIME];
                //                    [data setValue:@"2" forKey:NATIVE_JSON_KEY_ENDTIME];
                //                    [data setValue:appDelegate.courseCode forKey:NATIVE_JSON_KEY_COURSECODE];
                //                    [data setValue:appDelegate.coursePack forKey:NATIVE_JSON_KEY_COURSEPACK];
                if(completionFlag == 2)
                {
                    [obj1 setValue:EDGECOMPLETE forKey:DATABASE_CATLOGCONT_ISCOMP];
                    [obj1 setValue:@"100" forKey:HTML_JSON_KEY_IRDATA];
                    nextunlockitem ++;
                    //[data setValue:EDGECOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",[scnDataArray count]] forKey:DATABASE_CATLOGCONT_TOTALCHAPTERS];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",chapComCounter] forKey:DATABASE_CATLOGCONT_COMPCHAPTERS];
                }
                else if(completionFlag == 1)
                {
                    [obj1 setValue:EDGENOTCOMPLETE forKey:DATABASE_CATLOGCONT_ISCOMP];
                    int _percentage = (chapComCounter*100/[scnDataArray count]);
                    
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",_percentage] forKey:HTML_JSON_KEY_IRDATA];
                    //[data setValue:EDGENOTCOMPLETE forKey:NATIVE_JSON_KEY_ISCOMP];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",[scnDataArray count]] forKey:DATABASE_CATLOGCONT_TOTALCHAPTERS];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",chapComCounter] forKey:DATABASE_CATLOGCONT_COMPCHAPTERS];
                    
                    
                    
                }
                else
                {
                    [obj1 setValue:EDGENOTSTARTED forKey:DATABASE_CATLOGCONT_ISCOMP];
                    [obj1 setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",[scnDataArray count]] forKey:DATABASE_CATLOGCONT_TOTALCHAPTERS];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",chapComCounter] forKey:DATABASE_CATLOGCONT_COMPCHAPTERS];
                    //[data setValue:EDGENOTSTARTED forKey:NATIVE_JSON_KEY_ISCOMP];
                    
                }
                
                //[arr addObject:data];
                //                        [self setTracktableData:data];
                
            }
            else
            {
                if([[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE]intValue] == 4)
                {
                    [obj1 setValue:EDGENOTSTARTED forKey:DATABASE_CATLOGCONT_ISCOMP];
                    [obj1 setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",0] forKey:DATABASE_CATLOGCONT_TOTALCHAPTERS];
                    [obj1 setValue:[[NSString alloc]initWithFormat:@"%d",0] forKey:DATABASE_CATLOGCONT_COMPCHAPTERS];
                }
                else
                {
                    [obj1 setValue:EDGENOTSTARTED forKey:DATABASE_CATLOGCONT_ISCOMP];
                    [obj1 setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
                }
                
            }
            
            
            
        }
        if(i == 1 &&  [[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] == -1)
        {
            [obj1 setValue:EDGENOTCOMPLETE forKey:DATABASE_CATLOGCONT_ISCOMP];
        }
        if(i > 1 &&  [[obj1 valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] > -1 )
        {
            NSMutableDictionary * obj = [catDataArray objectAtIndex:(i-1)];
            if([[obj valueForKey:DATABASE_CATLOGCONT_ISCOMP]intValue] != 1 ){
                [obj1 setValue:EDGENOTSTARTED forKey:DATABASE_CATLOGCONT_ISCOMP];
            }
        }
        else
        {
            
        }
        
    }
    return catDataArray;
}



-(NSArray *)getChaptersDataWithSkill:(NSString *)coursePack Topic :(NSString *)topicId :(NSString *)skillId
{
    NSString * scnquery;
    if(skillId == NULL || [skillId isEqualToString:@""])
    {
        scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,topicId];
    }
    else
    {
        scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,topicId, DATABASE_SCENARIO_SKILL,skillId];
    }
    NSMutableArray * scnDataArray =  [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
    if(scnDataArray != NULL)
    {
        for (int j =0; j < [scnDataArray count] ; j++)
        {
            NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ ='%@' AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
            NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
            if(DataArray != NULL && [DataArray count] > 0)
            {
                [datascnDb setValue:EDGECOMPLETE forKey:DATABASE_SCENARIO_ISCOMP];
                
            }
            else
            {
                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                if(_DataArray != NULL && [_DataArray count] > 0)
                {
                    [datascnDb setValue:EDGENOTCOMPLETE forKey:DATABASE_SCENARIO_ISCOMP];
                    
                }
                else
                {
                    [datascnDb setValue:EDGENOTSTARTED forKey:DATABASE_SCENARIO_ISCOMP];
                }
            }
            
            if([[datascnDb valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] == [EDGECOMPLETE intValue])
            {
                [datascnDb setValue:@"100" forKey:HTML_JSON_KEY_IRDATA];
            }
            else if([[datascnDb valueForKey:DATABASE_SCENARIO_ISCOMP]intValue] == [EDGENOTCOMPLETE intValue])
            {
                [datascnDb setValue:@"50" forKey:HTML_JSON_KEY_IRDATA];
            }
            else
            {
                [datascnDb setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
            }
            
            
            NSDictionary *componant = [defaults objectForKey:@"componant"];
            if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] >0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
            {
                
                [datascnDb setValue:[componant valueForKey:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
            }
            else
            {
                
                [datascnDb setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
            }
        }
    }
    
    return scnDataArray;
    
    
}

-(NSMutableDictionary *)getGameDashboardData:(NSString *)coursePack Topic :(NSString *)topicId 
{
    
    NSMutableDictionary * scnArrDictionary = [[NSMutableDictionary alloc]init];
    NSMutableArray * scnArray = [[NSMutableArray alloc ]init];
    [scnArrDictionary setValue:scnArray forKey:@"scnArray"];
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@='%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    if([courseArr count]>0)
    {
        /*if(topicId != NULL && [topicId isEqualToString:@""]){*/
        NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE, DATABASE_CATLOGCONT_CEDGEID,[[courseArr objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
        int counter = 0;
        int unlocked = 0;
        NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        int topicCounter = 0;
        for (NSDictionary * obj1 in catDataArray) {
            
            topicCounter ++;
            NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]];
            
            NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
            if(scnDataArray != NULL)
            {
                for (int j =0; j < [scnDataArray count] ; j++)
                {
                    NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                    NSMutableDictionary * scnDictionary = [[NSMutableDictionary alloc]init];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID] forKey:HTML_JSON_KEY_UID];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_IS_HIDE] forKey:DATABASE_SCENARIO_IS_HIDE];
                    //double score = [self getAssesmentMCQScore:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]:coursePack];
                    //int val = ((score*100));
                    [scnDictionary setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
                    [scnDictionary setValue:DATABASE_CATTYPE_SCENARIO forKey:HTML_JSON_KEY_TYPE];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    if(appDelegate.viewMode)
                    {
                        if(unlocked >= 3)
                        {
                            [scnDictionary setValue:@"1" forKey:@"isLock"];
                        }
                        else
                        {
                            [scnDictionary setValue:@"0" forKey:@"isLock"];
                            unlocked++;
                        }
                        //                        [scnDictionary setValue:@"1" forKey:@"isLock"];
                        //
                        //                        NSArray *lockArr  = [defaults objectForKey:@"unlocked_chapter_list"];
                        //                        for (NSObject * eid in lockArr) {
                        //                            if([[[NSString alloc]initWithFormat:@"%@",eid]isEqualToString:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]])
                        //                            {
                        //                                [scnDictionary setValue:@"0" forKey:@"isLock"];
                        //                            }
                        //                        }
                    }
                    else
                    {
                        [scnDictionary setValue:@"0" forKey:@"isLock"];
                    }
                    
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        [scnDictionary setValue:EDGECOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                        
                    }
                    else
                    {
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                        NSArray * _DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(_DataArray != NULL && [_DataArray count] > 0)
                        {
                            [scnDictionary setValue:EDGENOTCOMPLETE forKey:HTML_JSON_KEY_ISCOMPLETE];
                            
                        }
                        else
                        {
                            [scnDictionary setValue:EDGENOTSTARTED forKey:HTML_JSON_KEY_ISCOMPLETE];
                        }
                    }
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPURL] forKey:HTML_JSON_KEY_ZIPURL];
                    [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_NAME] forKey:HTML_JSON_KEY_TOPIC_NAME];
                    [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_DESC] forKey:HTML_JSON_KEY_TOPIC_DESC];
                    [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:HTML_JSON_KEY_TOPIC_EDGEID];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DESC] forKey:HTML_JSON_KEY_DESC];
                    
                    [scnDictionary setValue:[[NSString alloc]initWithFormat:@"%d",topicCounter] forKey:HTML_JSON_KEY_TOPIC_COUNTER];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_NAME] forKey:HTML_JSON_KEY_NAME];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_DESC] forKey:HTML_JSON_KEY_DESC];
                    [scnDictionary setValue:[datascnDb valueForKey:DATABASE_SCENARIO_ZIPSIZE] forKey:HTML_JSON_KEY_SIZE];
                    
                    NSDictionary *componant = [defaults objectForKey:@"componant"];
                    if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] >0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
                    {
                        
                        [scnDictionary setValue:[componant valueForKey:[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
                    }
                    else
                    {
                        
                        [scnDictionary setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                    }
                    
                    
                    
                    
                    if([[scnDictionary valueForKey:HTML_JSON_KEY_ISCOMPLETE]intValue] == 1)
                    {
                        [scnDictionary setValue:@"100" forKey:HTML_JSON_KEY_IRDATA];
                    }
                    else if([[scnDictionary valueForKey:HTML_JSON_KEY_ISCOMPLETE]intValue] == 0)
                    {
                        [scnDictionary setValue:@"50" forKey:HTML_JSON_KEY_IRDATA];
                    }
                    else
                    {
                        [scnDictionary setValue:@"0" forKey:HTML_JSON_KEY_IRDATA];
                    }
                    
                    
                    if(topicId != NULL && [topicId integerValue] <=0 ){
                        [scnArray addObject:scnDictionary];
                    }
                    else
                    {
                        if(topicId != NULL && [[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]integerValue] == [topicId integerValue])
                        {
                            [scnArray addObject:scnDictionary];
                        }
                    }
                }
            }
            else if (scnDataArray == NULL && [[obj1 valueForKey:DATABASE_CATLOGCONT_CATTYPE]integerValue] == 3 )
            {
                
                
                NSMutableDictionary * scnDictionary = [[NSMutableDictionary alloc]init];
                [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID] forKey:HTML_JSON_KEY_UID];
                [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_NAME] forKey:HTML_JSON_KEY_NAME];
                
                double score = [self getAssesmentMCQScore:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]:coursePack];
                int val = ((score*100));
                [scnDictionary setValue:[[NSString alloc] initWithFormat:@"%d",val] forKey:HTML_JSON_KEY_IRDATA];
                [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_DESC] forKey:HTML_JSON_KEY_DESC];
                [scnDictionary setValue:DATABASE_CATTYPE_ASSISMENT_XML forKey:HTML_JSON_KEY_TYPE];
                [scnDictionary setValue:@"" forKey:HTML_JSON_KEY_TOPIC_NAME];
                [scnDictionary setValue:[obj1 valueForKey:DATABASE_CATLOGCONT_ZIPURL] forKey:HTML_JSON_KEY_ZIPURL];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *componant = [defaults objectForKey:@"componant"];
                if(componant != NULL && [[componant valueForKey:appDelegate.courseCode] intValue] >0 && [[componant valueForKey:appDelegate.courseCode] intValue] == [self getCourseVersion:appDelegate.courseCode]  )
                {
                    
                    [scnDictionary setValue:[componant valueForKey:[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]] forKey:HTML_JSON_KEY_ACTION];
                }
                else
                {
                    [scnDictionary setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                }
                
                if(topicId != NULL && [topicId integerValue] <= 0){
                    [scnArray addObject:scnDictionary];
                }
                else
                {
                    if(topicId != NULL && [[obj1 valueForKey:DATABASE_CATLOGCONT_EDGEID]integerValue] == [topicId integerValue])
                    {
                        [scnArray addObject:scnDictionary];
                    }
                }
            }
        }
    }
    
    return scnArrDictionary;
}



-(NSString *)getScenarioName:(int)scnUid
{
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where %@ =%d",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,scnUid ];
    
    NSArray * capConceptDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_SCENARIOTABLE];
    NSLog(@"%@",capConceptDataArray);
    if(capConceptDataArray != NULL)
    {
        //        for (int k=0; k< [capConceptDataArray count]; k++)
        //        {
        return [[capConceptDataArray objectAtIndex:0]valueForKey:DATABASE_SCENARIO_NAME];
        // }
    }
    
    return  @"";
}

-(NSString *)getCurrentCoursepack
{
    NSString * strPatfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSEPACKTABLE ];
    NSArray * coursePackArr = [dataObj SelecteQuery:strPatfmt Table :DATABASE_TABLE_COURSEPACKTABLE];
    
    
    
    if([CLASS_NAME  isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"] || [CLASS_NAME  isEqualToString:@"cuponline"] || [CLASS_NAME  isEqualToString:@"cambridge"]|| [CLASS_NAME  isEqualToString:@"ace"] || [CLASS_NAME  isEqualToString:@"quizky"] || [CLASS_NAME  isEqualToString:@"kannanprep"] || [CLASS_NAME  isEqualToString:@"cam_capable"])
    {
        if(coursePackArr!= NULL &&  [coursePackArr count] > 1 )
        {
            return [[coursePackArr objectAtIndex:[coursePackArr count]-1]valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
        }
        else if(coursePackArr!= NULL &&  [coursePackArr count] >0)
        {
            return [[coursePackArr objectAtIndex:0]valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        if(coursePackArr!= NULL &&  [coursePackArr count] >0)
        {
            return [[coursePackArr objectAtIndex:0]valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE];
        }
        else
        {
            return nil;
        }
    }
    
}

-(BOOL)isPreregisteredUser
{
    
    NSString * strPatfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSEPACKTABLE ];
    NSArray * coursePackArr = [dataObj SelecteQuery:strPatfmt Table :DATABASE_TABLE_COURSEPACKTABLE];
    
    if([CLASS_NAME  isEqualToString:@"wiley"] || [CLASS_NAME  isEqualToString:@"awards"] || [CLASS_NAME  isEqualToString:@"cuponline"] || [CLASS_NAME  isEqualToString:@"cambridge"] || [CLASS_NAME  isEqualToString:@"ace"]|| [CLASS_NAME  isEqualToString:@"quizky"] || [CLASS_NAME  isEqualToString:@"kannanprep"] || [CLASS_NAME  isEqualToString:@"cam_capable"])
    {
        if(coursePackArr != NULL && [coursePackArr count] > 1)
        {
            return TRUE;
        }
        else
        {
            return FALSE;
        }
    }
    else
    {
        return FALSE;
    }
    
    
}



-(NSArray *)getAllCourseCode
{
    NSMutableArray * overallArr = [[NSMutableArray alloc]init];
    
    
    NSMutableDictionary * categoryDic = [[NSMutableDictionary alloc] init];
    [categoryDic setValue:@"" forKey:@"Category"];
    [overallArr addObject:categoryDic];
    
    NSMutableArray * innerArr = [[NSMutableArray alloc]init];
    [categoryDic setValue:innerArr forKey:@"CouArr"];
    
    NSString * strPatfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSEPACKTABLE ];
    NSArray * coursePackArr = [dataObj SelecteQuery:strPatfmt Table :DATABASE_TABLE_COURSEPACKTABLE];
    
    
    NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE,DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE,[[coursePackArr objectAtIndex:coursePackArr.count-1] valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE] ];
    
    
    NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
    
    
    
    
    for(int i = 0 ; i< courseMapArr.count ; i++  )
    {
        NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
        NSArray * courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
        
        
        NSDictionary * obj = [courseArr objectAtIndex:0];
        int TotelScn =0;
        int completeScn =0;
        NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
        [innerArr addObject:catDic];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_NAME] forKey:DATABASE_COURSE_NAME];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_CEDGE] forKey:DATABASE_COURSE_CEDGE];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_DESC] forKey:DATABASE_COURSE_DESC];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:DATABASE_COURSE_DATA];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_IMGPATH] forKey:DATABASE_COURSE_IMGPATH];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *componant = [defaults objectForKey:@"componant"];
        
        if(componant != NULL && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] intValue] > 0  && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] integerValue] > [[obj valueForKey:DATABASE_COURSE_VER] integerValue] && [[obj valueForKey:DATABASE_COURSE_VER] integerValue]  >0)
        {
            
            [catDic setValue:[componant valueForKey:[obj valueForKey:DATABASE_COURSE_CEDGE]] forKey:HTML_JSON_KEY_ACTION];
        }
        else
        {
            
            [catDic setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
        }
        
        NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable where %@ = %@",DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
        NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        if(catDataArray != NULL )
        {
            for (int i =0; i < [catDataArray count] ; i++)
            {
                
                NSDictionary * dataDb = [catDataArray objectAtIndex:i];
                
                if([[dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
                {
                    TotelScn++;
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM TrackingTable where edgeID = %@ AND %@ = '%@' group by edgeID;",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,[[coursePackArr objectAtIndex:coursePackArr.count-1] valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE]];
                    NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(LDataArray != NULL && [LDataArray count] > 0)
                    {
                        completeScn ++;
                        
                        
                    }
                    
                }
                else
                {
                    
                    
                    NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from ScenarioTable where catContEdgeID  = %@",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                    
                    NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
                    if(scnDataArray != NULL)
                    {
                        for (int j =0; j < [scnDataArray count] ; j++)
                        {
                            
                            
                            
                            
                            NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                            TotelScn ++;
                            NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM TrackingTable where edgeID = %@ AND %@ = '%@' group by edgeID; ",[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,[[coursePackArr objectAtIndex:coursePackArr.count-1] valueForKey:DATABASE_COURSEPACK_COURSEPACKCODE]];
                            
                            NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                            if(LDataArray != NULL && [LDataArray count] > 0)
                            {
                                completeScn ++;
                                
                            }
                            
                        }
                    }
                }
                
            }
            
            if(TotelScn != 0)
                [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)((completeScn*100)/TotelScn)] forKey:HTML_JSON_KEY_PERCENTAGE];
            else
                [catDic setValue:@"0" forKey:HTML_JSON_KEY_PERCENTAGE];
        }
    }
    return overallArr;
}

-(NSArray *)getAllCourseCodeWithPack :(NSString *)pack_code :(NSString *)user_level
{
    NSMutableArray * overallArr = [[NSMutableArray alloc]init];
    NSString * strCatfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_CATEGORY,DATABASE_CATEGORY_CATEGORYCOURSEPACKCODE,pack_code];
    NSArray * CatArr = [dataObj SelecteQuery:strCatfmt Table :DATABASE_TABLE_CATEGORY];
    if([CatArr count] > 0)
    {
        for (NSDictionary *catgoryObj in CatArr) {
            
            NSMutableDictionary * categoryDic = [[NSMutableDictionary alloc] init];
            [categoryDic setValue:[catgoryObj valueForKey:@"categoryId"] forKey:DATABASE_CATEGORY_CATEGORYID];
            [categoryDic setValue:[catgoryObj valueForKey:@"categoryName"] forKey:DATABASE_CATEGORY_CATEGORYNAME];
            
            [overallArr addObject:categoryDic];
            
            NSMutableArray * innerArr = [[NSMutableArray alloc]init];
            [categoryDic setValue:innerArr forKey:@"CouArr"];
            NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_CATEGORYCOURSEMAPPING,DATABASE_CATEGORYCOURSEMAPPING_CATEGORYID,[catgoryObj valueForKey:@"categoryId"],DATABASE_CATEGORYCOURSEMAPPING_COURSEPACKCODE,pack_code];
            
            
            NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_CATEGORYCOURSEMAPPING];
            
            for(int i = 0 ; i< courseMapArr.count ; i++  )
            {
                NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
                NSArray * courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
                
                
                NSDictionary * obj = [courseArr objectAtIndex:0];
                int TotelScn =0;
                int completeScn =0;
                int TotelTopic =0;
                int completeTopic =0;
                NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
                
                NSString * course_level = [obj valueForKey:DATABASE_COURSE_LEVELTEXT];
                if([user_level isEqualToString:@"-1"])
                {
                    [innerArr addObject:catDic];
                }
                else if([course_level isEqualToString:user_level] )
                {
                    [innerArr addObject:catDic];
                }
                
                
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_NAME] forKey:DATABASE_COURSE_NAME];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_CEDGE] forKey:DATABASE_COURSE_CEDGE];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_DESC] forKey:DATABASE_COURSE_DESC];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:DATABASE_COURSE_DATA];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_IMGPATH] forKey:DATABASE_COURSE_IMGPATH];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_LEVELTEXT] forKey:DATABASE_COURSE_LEVELTEXT];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_LEVELDESC] forKey:DATABASE_COURSE_LEVELDESC];
                [catDic setValue:[obj valueForKey:DATABASE_COURSE_LEVELCEFRMAP] forKey:DATABASE_COURSE_LEVELCEFRMAP];
                //[catDic setValue:[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE] forKey:DATABASE_COURSEPACK_COURSEPACKCODE];
                
                NSArray *status = [appDelegate getUserDefaultData:@"courses_status"];
                if(status != NULL && [status count] >0 )
                {
                    for (NSDictionary *obj  in status) {
                        if([[obj valueForKey:@"course_code"]isEqualToString:[catDic valueForKey:DATABASE_COURSE_DATA]]){
                            if([[obj valueForKey:@"status"]integerValue] == 1)
                            {
                                [catDic setValue:ONE forKey:HTML_JSON_KEY_STATUS];
                            }
                            else
                            {
                                [catDic setValue:ZERO forKey:HTML_JSON_KEY_STATUS];
                            }
                            break;
                        }
                    }
                }
                else
                {
                    
                    [catDic setValue:ONE forKey:HTML_JSON_KEY_STATUS];
                }
                
                
                
                // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSDictionary *componant = [appDelegate getUserDefaultData:@"componant"];
                if(componant != NULL && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] intValue] > 0  && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] integerValue] > [[obj valueForKey:DATABASE_COURSE_VER] integerValue] && [[obj valueForKey:DATABASE_COURSE_VER] integerValue] > 0 )
                {
                    
                    [catDic setValue:[componant valueForKey:[obj valueForKey:DATABASE_COURSE_CEDGE]] forKey:HTML_JSON_KEY_ACTION];
                }
                else
                {
                    
                    [catDic setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
                }
                
                
                if([CLASS_NAME isEqualToString:@"wiley"])
                {
                    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                    NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                    if(DataArray != NULL && [DataArray count] > 0)
                    {
                        [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)100] forKey:HTML_JSON_KEY_PERCENTAGE];
                        
                    }
                    else
                    {
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"0"];
                        NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(DataArray != NULL && [DataArray count] > 0)
                        {
                            [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)50] forKey:HTML_JSON_KEY_PERCENTAGE];
                            
                        }
                        else
                        {
                            [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)0] forKey:HTML_JSON_KEY_PERCENTAGE];
                        }
                    }
                    
                }
                else
                {
                    
                    
                    
                    NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
                    NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
                    if(catDataArray != NULL )
                    {
                        for (int i =0; i < [catDataArray count] ; i++)
                        {
                            
                            NSDictionary * dataDb = [catDataArray objectAtIndex:i];
                            
                            if([[dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
                            {
                                TotelTopic ++;
                                TotelScn++;
                                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM %@ where edgeID = %@ AND %@ = '%@' group by edgeID;",DATABASE_TABLE_TRACKTABLE,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,pack_code];
                                NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                                if(LDataArray != NULL && [LDataArray count] > 0)
                                {
                                    completeScn ++;
                                    completeTopic++;
                                    
                                    
                                }
                                
                            }
                            else
                            {
                                TotelTopic ++;
                                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ =%@ AND %@ = '%@' AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_EDGEID,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,appDelegate.coursePack,DATABASE_TRACKINGTABLE_ISCOMP,@"1"];
                                
                                NSArray * DataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                                if(DataArray != NULL && [DataArray count] > 0)
                                {
                                    completeTopic++;
                                    
                                }
                                
                                
                                
                                NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@  = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                                
                                NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
                                if(scnDataArray != NULL)
                                {
                                    for (int j =0; j < [scnDataArray count] ; j++)
                                    {
                                        
                                        
                                        
                                        
                                        NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                                        TotelScn ++;
                                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM %@ where edgeID = %@ AND %@ = '%@' group by edgeID;",DATABASE_TABLE_TRACKTABLE,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,pack_code];
                                        
                                        NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                                        if(LDataArray != NULL && [LDataArray count] > 0)
                                        {
                                            completeScn ++;
                                            
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        if(TotelScn != 0)
                            [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)((completeScn*100)/TotelScn)] forKey:HTML_JSON_KEY_PERCENTAGE];
                        else
                            [catDic setValue:@"0" forKey:HTML_JSON_KEY_PERCENTAGE];
                        
                        if(TotelTopic != 0)
                            [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)((completeTopic*100)/TotelTopic)] forKey:HTML_JSON_KEY_TOPIC_PERCENTAGE];
                        else
                            [catDic setValue:@"0" forKey:HTML_JSON_KEY_TOPIC_PERCENTAGE];
                        
                        
                    }
                }
                
            }
            
            
            
        }
        
        
        
        
        
    }
    else{
        NSMutableDictionary * categoryDic = [[NSMutableDictionary alloc] init];
        [categoryDic setValue:@"" forKey:@"Category"];
        [overallArr addObject:categoryDic];
        NSMutableArray * innerArr = [[NSMutableArray alloc]init];
        [categoryDic setValue:innerArr forKey:@"CouArr"];
        NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE,DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE,pack_code];
        NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
        for(int i = 0 ; i< courseMapArr.count ; i++  )
        {
            NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
            NSArray * courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
            
            
            NSDictionary * obj = [courseArr objectAtIndex:0];
            int TotelScn =0;
            int completeScn =0;
            NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
            NSString * course_level = [obj valueForKey:DATABASE_COURSE_LEVELTEXT];
            if([course_level isEqualToString:user_level])
                [innerArr addObject:catDic];
            [catDic setValue:[obj valueForKey:DATABASE_COURSE_NAME] forKey:DATABASE_COURSE_NAME];
            [catDic setValue:[obj valueForKey:DATABASE_COURSE_CEDGE] forKey:DATABASE_COURSE_CEDGE];
            [catDic setValue:[obj valueForKey:DATABASE_COURSE_DESC] forKey:DATABASE_COURSE_DESC];
            [catDic setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:DATABASE_COURSE_DATA];
            [catDic setValue:[obj valueForKey:DATABASE_COURSE_IMGPATH] forKey:DATABASE_COURSE_IMGPATH];
            [catDic setValue:[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE] forKey:DATABASE_COURSEPACK_COURSEPACKCODE];
            
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSArray *status = [defaults objectForKey:@"courses_status"];
            
            if(status != NULL && [status count] >0 )
            {
                for (NSDictionary *obj  in status) {
                    if([[obj valueForKey:@"course_code"]isEqualToString:[catDic valueForKey:DATABASE_COURSE_DATA]]){
                        if([[obj valueForKey:@"status"]integerValue] == 1)
                        {
                            [catDic setValue:ONE forKey:HTML_JSON_KEY_STATUS];
                        }
                        else
                        {
                            [catDic setValue:ZERO forKey:HTML_JSON_KEY_STATUS];
                        }
                        break;
                    }
                }
            }
            else
            {
                
                [catDic setValue:ONE forKey:HTML_JSON_KEY_STATUS];
            }
            
            
            
            
            NSDictionary *componant = [defaults objectForKey:@"componant"];
            
            if(componant != NULL && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] intValue] > 0  && [[componant valueForKey:[obj valueForKey:DATABASE_COURSE_DATA]] integerValue] > [[obj valueForKey:DATABASE_COURSE_VER] integerValue] && [[obj valueForKey:DATABASE_COURSE_VER] integerValue]  >0 )
            {
                [catDic setValue:[componant valueForKey:[obj valueForKey:DATABASE_COURSE_CEDGE]] forKey:HTML_JSON_KEY_ACTION];
            }
            else
            {
                
                [catDic setValue:ZERO forKey:HTML_JSON_KEY_ACTION];
            }
            
            NSString * query =[[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable where %@ = %@",DATABASE_CATLOGCONT_CEDGEID,[obj valueForKey:DATABASE_COURSE_CEDGE]];
            NSArray * catDataArray  = [dataObj SelecteQuery:query Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
            if(catDataArray != NULL )
            {
                for (int i =0; i < [catDataArray count] ; i++)
                {
                    
                    NSDictionary * dataDb = [catDataArray objectAtIndex:i];
                    
                    if([[dataDb valueForKey:DATABASE_CATLOGCONT_CATTYPE]isEqualToString:DATABASE_CATTYPE_ASSISMENT_XML])
                    {
                        TotelScn++;
                        NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM TrackingTable where edgeID = %@ %@ = '%@' group by edgeID;",[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,pack_code];
                        NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                        if(LDataArray != NULL && [LDataArray count] > 0)
                        {
                            completeScn ++;
                            
                            
                        }
                        
                    }
                    else
                    {
                        
                        
                        NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@  = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[dataDb valueForKey:DATABASE_CATLOGCONT_EDGEID]];
                        
                        NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
                        if(scnDataArray != NULL)
                        {
                            for (int j =0; j < [scnDataArray count] ; j++)
                            {
                                
                                
                                
                                
                                NSDictionary * datascnDb = [scnDataArray objectAtIndex:j];
                                TotelScn ++;
                                NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT moduleID, scenarioID, edgeID,trackType,usageScore,isComplete,sum(startTime), sum(endTime) FROM %@ where edgeID = %@ AND %@ = '%@' group by edgeID;",DATABASE_TABLE_TRACKTABLE,[datascnDb valueForKey:DATABASE_SCENARIO_EDGEID],DATABASE_TRACKINGTABLE_COURSEPACK,pack_code];
                                
                                NSArray *LDataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
                                if(LDataArray != NULL && [LDataArray count] > 0)
                                {
                                    completeScn ++;
                                    
                                }
                                
                            }
                        }
                    }
                    
                }
                
                if(TotelScn != 0)
                    [catDic setValue:[[NSString alloc]initWithFormat:@"%d",(int)((completeScn*100)/TotelScn)] forKey:HTML_JSON_KEY_PERCENTAGE];
                else
                    [catDic setValue:@"0" forKey:HTML_JSON_KEY_PERCENTAGE];
                
                
            }
            
        }
    }
    
    return overallArr;
}



-(BOOL) deleteFromTrackTable:(NSString *)_courseCode
{
    NSString * strfmtMain = [[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_COURSE_CODE,_courseCode];
    if( [dataObj deleteQuery:strfmtMain]) return TRUE;
    return false;
}

-(NSString *)getCurrentCourseId
{
    NSString * strfmtMain = [[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    
    NSArray * catDataArray  = [dataObj SelecteQuery:strfmtMain Table:DATABASE_TABLE_COURSETABLE];
    if(catDataArray != NULL )
    {
        return [[NSString alloc]initWithFormat:@"%@",[[catDataArray objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
    }
    return @"";
}

-(NSMutableArray *)getCourseArr
{
    
    
    NSMutableArray * innerArr = [[NSMutableArray alloc]init];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSETABLE];
    NSArray * courseArr = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_COURSETABLE];
    //for (NSDictionary * obj in courseArr) {
    for(int i = (int)courseArr.count -1; i >= 0 ; i--  )
    {
        
        NSDictionary * obj = [courseArr objectAtIndex:i];
        NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
        if([[obj valueForKey:DATABASE_COURSE_VER]intValue] > 0 )
            [innerArr addObject:catDic];
        
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:JSON_COURSECODE];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_VER] forKey:DATABASE_COURSE_VER];
        
    }
    
    return innerArr;
}

-(NSString *)getCourseName
{
    NSString * strfmtscore = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@';",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,appDelegate.courseCode];
    return [[[dataObj SelecteQuery:strfmtscore Table:DATABASE_TABLE_COURSETABLE] objectAtIndex:0]valueForKey:DATABASE_COURSE_NAME];
}

-(double)getAssesmentMCQScore:(NSString *)edgeid :(NSString *)coursePack
{
    
    
    NSString * exQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_CEDGEID,edgeid];
    
    NSArray * exArray  = [dataObj SelecteQuery:exQuery Table:DATABASE_TABLE_EXERCISETABLE];
    if(exArray != NULL)
    {
        for (NSDictionary * practiceObj in exArray)
        {
            
            NSString * pracQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = %@ ",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_CEDGEID,[practiceObj valueForKey:DATABASE_PRACTICE_CEDGEID],DATABASE_PRACTICE_CATETYPE,@"21"];
            
            NSArray * pracArray  = [dataObj SelecteQuery:pracQuery Table:DATABASE_TABLE_PRACTICETABLE];
            if(pracArray != NULL && [pracArray count] > 0)
            {
                for (NSDictionary * mcqObj in pracArray)
                {
                    NSString * mcqQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = '%@'",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_TESTID,[mcqObj valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TEST_COURSEPACK,coursePack];
                    
                    NSInteger value = [[dataObj SelecteQuery:mcqQuery Table:DATABASE_TABLE_TESTTABLE] count];
                    if(value > 0)
                    {
                        
                        NSString * mcqQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = %@ AND %@ = '%@'",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_TESTID,[mcqObj valueForKey:DATABASE_PRACTICE_EDGEID],DATABASE_TEST_ANSID,@"1",DATABASE_TEST_COURSEPACK,coursePack];
                        
                        
                        
                        
                        double _score =  [[dataObj SelecteQuery:mcqQuery Table:DATABASE_TABLE_TESTTABLE] count];
                        double mainScore =_score/value;
                        return mainScore;
                    }
                    else
                    {
                        double score =0;
                        double total =0;
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        NSArray * arr = (NSArray *)[defaults valueForKey:@"tracking"];
                        if(arr != NULL && [arr count] > 0)
                        {
                            for ( NSDictionary *obj  in arr) {
                                if([[obj valueForKey:@"test_uniqid"]isEqualToString:[mcqObj valueForKey:DATABASE_PRACTICE_EDGEID]] && [[obj valueForKey:@"package_code"]isEqualToString:coursePack] )
                                {
                                    total++;
                                }
                                if([[obj valueForKey:@"test_uniqid"]isEqualToString:[mcqObj valueForKey:DATABASE_PRACTICE_EDGEID]] && [[obj valueForKey:@"ans_uniqid"]isEqualToString:@"1"] && [[obj valueForKey:@"package_code"]isEqualToString:coursePack] )
                                {
                                    score++;
                                }
                            }
                            if(total >0){
                                double _score =  score/total;
                                return _score;
                            }
                            else{
                                return 0;
                            }
                        }
                        
                    }
                    
                    
                }
                
                
                
                
            }
            
        }
        
        
    }
    else{
        
        {
            NSString * mcqQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_TESTID,edgeid];
            
            NSInteger value = [[dataObj SelecteQuery:mcqQuery Table:DATABASE_TABLE_TESTTABLE] count];
            if(value > 0)
            {
                
                NSString * mcqQuery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@ AND %@ = %@ ",DATABASE_TABLE_TESTTABLE,DATABASE_TEST_TESTID,edgeid,DATABASE_TEST_ANSID,@"1"];
                
                
                
                
                double _score =  [[dataObj SelecteQuery:mcqQuery Table:DATABASE_TABLE_TESTTABLE] count];
                double mainScore =_score/value;
                return mainScore;
            }
            else
            {
                double score =0;
                double total =0;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                NSArray * arr = (NSArray *)[defaults valueForKey:@"tracking"];
                if(arr != NULL && [arr count] > 0)
                {
                    for ( NSDictionary *obj  in arr) {
                        if([[obj valueForKey:@"test_uniqid"]isEqualToString:edgeid] && [[obj valueForKey:@"package_code"]isEqualToString:coursePack] )
                        {
                            total++;
                        }
                        if([[obj valueForKey:@"test_uniqid"]isEqualToString:edgeid] && [[obj valueForKey:@"ans_uniqid"]isEqualToString:@"1"] && [[obj valueForKey:@"package_code"]isEqualToString:coursePack] )
                        {
                            score++;
                        }
                    }
                    if(total >0){
                        double _score =  score/total;
                        return _score;
                    }
                    else{
                        return 0;
                    }
                }
                
            }
            
            
        }
        
        
        
    }
    
    return 0;
}





// 0 no change
// 1 new
// update





-(int)isDownloaded:(NSString *)edgeId
{
    if(edgeId == NULL || [edgeId isEqualToString:@""])
    {
        return 0;
    }
    else
    {
        NSString * selQuery = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@'",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_EDGEID,edgeId];
        NSArray * arrCat =  [dataObj SelecteQuery:selQuery Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
        if(arrCat != NULL && [arrCat count] > 0)
        {
            NSString * filePath = [[arrCat objectAtIndex:0] valueForKey:DATABASE_CATLOGCONT_DATA];
            NSLog(@"%@",filePath);
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:filePath];
            //dataPath = [dataPath stringByAppendingPathComponent:filePath];
            dataPath =[dataPath stringByReplacingOccurrencesOfString:@" " withString:@""];
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:dataPath] == NO )
            {
                return 0;
            }
            else
            {
                return 2;
            }
        }
        else
        {
            
            NSString * selscnQuery = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@'",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,edgeId];
            NSArray * arrScn =  [dataObj SelecteQuery:selscnQuery Table:DATABASE_TABLE_SCENARIOTABLE];
            if(arrScn != NULL && [arrScn count] > 0 )
            {
                NSString * selQuery = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ ='%@'",DATABASE_TABLE_EXERCISETABLE,DATABASE_EXERCISE_CEDGEID,edgeId];
                NSArray * arrExcer =  [dataObj SelecteQuery:selQuery Table:DATABASE_TABLE_EXERCISETABLE];
                if(arrExcer != NULL)
                {
                    return 2;
                    
                }
                else
                {
                    return 0;
                }
                
                
            }
            else
            {
                return 0;
            }
            
        }
        
        
    }
    
    
    return 0;
}

-(BOOL)deleteAllTrackingData
{
    double syncTime = 0 ;
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * FROM %@",DATABASE_TABLE_TRACKSYNCTIME];
    NSArray * dataArray = [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKSYNCTIME];
    if(dataArray != NULL && [[dataArray valueForKey:DATABASE_LOCAL_DATA] count] > 0)
    {
        syncTime = [[[dataArray  objectAtIndex:0] valueForKey:DATABASE_TRACKSYNCTIME_TIME] longLongValue];
    }
    // NSString * strquery = [[NSString alloc]initWithFormat:@"DELETE FROM %@ where %@ < %f",DATABASE_TABLE_TRACKTABLE,DATABASE_TRACKINGTABLE_ENDTIME,syncTime];
    
    NSString * strquery = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_TRACKTABLE];
    
    [Logger logAduro:strquery];
    return [dataObj deleteQuery:strquery];
}


- (BOOL)checkPath :(NSString * )path
{
    
    //NSString *folderName = @"YourFolderName";
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [documentPaths objectAtIndex:0];
    documentsDirectoryPath = [documentsDirectoryPath stringByAppendingPathComponent:path];
    
    // if folder doesn't exist, create it
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (! [fileManager fileExistsAtPath:documentsDirectoryPath isDirectory:&isDir]) {
        return FALSE;
        
    }
    return TRUE;
}

-(NSMutableArray *)getAllCoursePack
{
    NSString * strPatfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@",DATABASE_TABLE_COURSEPACKTABLE ];
    return [dataObj SelecteQuery:strPatfmt Table :DATABASE_TABLE_COURSEPACKTABLE];
    
}

-(NSDictionary *)getAssessmentObject:(NSString *)edgeId
{
    
    
    [Logger logAduro:@"DataManagement : Strat Function getAssessmentObject" ];
    
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from CatLogContentTable  where catContEdgeID =%@",edgeId ];
    
    NSArray * catDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_CATLOGCONTENTTABLE];
    if(catDataArray != NULL )
    {
        for (NSDictionary *dataDb in catDataArray) {
            
            NSString * pathStr = [self getPathWithoutRoot: [dataDb valueForKey:DATABASE_PRACTICE_DATA]];
            NSError *parseError = nil;
            NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:pathStr error:&parseError];
            
            
            return xmlDictionary;
            
        }
    }
    return nil;
}

-(NSDictionary *)getMCQObject:(NSString *)edgeId
{
    [Logger logAduro:@"DataManagement : Strat Function getMCQObject" ];
    
    
    
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where pracEdgeID =%@",DATABASE_TABLE_PRACTICETABLE,edgeId ];
    
    NSArray * lcatDataArray = [dataObj SelecteQuery:strfmt Table :DATABASE_TABLE_PRACTICETABLE];
    if(lcatDataArray != NULL)
    {
        for ( NSDictionary * dataDb  in lcatDataArray) {
            
            
            NSString * pathStr = [self getPathWithoutRoot: [dataDb valueForKey:DATABASE_PRACTICE_DATA]];
            NSError *parseError = nil;
            NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:pathStr error:&parseError];
            
            
            return xmlDictionary;
        }
    }
    return nil;
}




-(NSDictionary*)getChapterMCQ:(int)scnUid
{
    NSMutableArray *practiceArr = [[NSMutableArray alloc] init];
    NSString * uidtrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where scnEdgeID ='%d' AND catType =%@",DATABASE_TABLE_EXERCISETABLE,scnUid,DATABASE_CATTYPE_PRACTICE ];
    NSArray * uIDDataArray = [dataObj SelecteQuery:uidtrfmt Table :DATABASE_TABLE_EXERCISETABLE];
    if(uIDDataArray != NULL)
    {
        NSDictionary * UIDDict = [uIDDataArray objectAtIndex:0];
        
        NSString * LscnUID = [UIDDict valueForKey:DATABASE_EXERCISE_EDGEID];
        
        NSString * practicestrfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@  where exEdgeID =%@ AND catType =%@",DATABASE_TABLE_PRACTICETABLE,LscnUID,@"21"];
        
        NSArray * practicecapDataArray = [dataObj SelecteQuery:practicestrfmt Table :DATABASE_TABLE_PRACTICETABLE];
        
        
        if(practicecapDataArray != NULL && [practicecapDataArray count] == 1 )
        {
            return (NSDictionary* )[practicecapDataArray objectAtIndex:0];
        }
        
    }
    return nil;
}

-(NSMutableArray *)getWeekSpentData
{
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *d = [dateFormatter stringFromDate:today];
    NSDate *rightNow= [dateFormatter dateFromString:d];
    long  current  =   [rightNow timeIntervalSince1970];
    NSString * strfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE startTime >=  %ld AND %@ = '%@'",DATABASE_TABLE_TRACKTABLE,current,DATABASE_TRACKINGTABLE_COURSE_CODE,appDelegate.courseCode];
    return [dataObj SelecteQuery:strfmt Table:DATABASE_TABLE_TRACKTABLE];
}


-(NSDictionary *)getChapterData :(NSString *)edgeId
{
    NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_EDGEID,edgeId];
    NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
    if([scnDataArray count] > 0)
    {
        return [scnDataArray objectAtIndex:0];
    }
    return nil;
}



-(void)cleanUserDatabase
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_TESTTABLE];
    [Logger logAduro:strfmt];
    [dataObj deleteQuery:strfmt];
    
    NSString * strfmt1 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_TRACKSYNCTIME];
    [Logger logAduro:strfmt1];
    [dataObj deleteQuery:strfmt1];
    
    NSString * strfmt2 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_TRACKTABLE];
    [Logger logAduro:strfmt2];
    [dataObj deleteQuery:strfmt2];
    
    NSString * strfmt3 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_USERINFO];
    [Logger logAduro:strfmt3];
    [dataObj deleteQuery:strfmt3];
    
    NSString * strfmt5 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
    [Logger logAduro:strfmt5];
    [dataObj deleteQuery:strfmt5];
    
    NSString * strfmt6 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_CATEGORYCOURSEMAPPING];
    [Logger logAduro:strfmt6];
    [dataObj deleteQuery:strfmt6];
    NSString * strfmt7 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_CATEGORY];
    [Logger logAduro:strfmt7];
    [dataObj deleteQuery:strfmt7];
    
    NSString * strfmt8 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_CATEGORY_CATEGORYCOURSEPACKCODE];
    [Logger logAduro:strfmt8];
    [dataObj deleteQuery:strfmt8];
    
    NSString * strfmt9 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COURSEPACKTABLE];
    [Logger logAduro:strfmt9];
    [dataObj deleteQuery:strfmt9];
    
    NSString * strfmt4 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COURSETABLE];
    [Logger logAduro:strfmt4];
    [dataObj deleteQuery:strfmt4];
    
    NSString * strfmt10 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_CATLOGCONTENTTABLE];
    [Logger logAduro:strfmt10];
    [dataObj deleteQuery:strfmt10];
    
    NSString * strfmt11 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_SCENARIOTABLE];
    [Logger logAduro:strfmt11];
    [dataObj deleteQuery:strfmt11];
    
    NSString * strfmt12 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COINSTABLE];
    [Logger logAduro:strfmt12];
    [dataObj deleteQuery:strfmt12];
    
    
    NSString * strfmt13 = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COINSUSERTABLE];
    [Logger logAduro:strfmt13];
    [dataObj deleteQuery:strfmt13];
    
    
}
-(int)getAttemptCounter
{
    NSString * strfmt7 = [[NSString alloc]initWithFormat:@"SELECT * FROM %@",DATABASE_TABLE_ATTEMPTCOUNTER];
    [Logger logAduro:strfmt7];
    NSArray * arr = [dataObj SelecteQuery:strfmt7 Table:DATABASE_TABLE_ATTEMPTCOUNTER];
    if(arr != NULL)
        return [arr count];
    else
        return 0;
}

-(NSDictionary *)getGSELevel :(NSString *)code
{
    
    NSMutableArray * levelArray = [[NSMutableArray alloc]init];
    
    NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE,DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE,appDelegate.coursePack];
    NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
    
    for(int i = 0 ; i< courseMapArr.count ; i++  )
    {
        NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
        NSArray * local_courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
        
        if([[[local_courseArr objectAtIndex:0] valueForKey:DATABASE_COURSE_DATA] isEqualToString:code])
        {
            return [local_courseArr objectAtIndex:0];
        }
        else if([[[local_courseArr objectAtIndex:0] valueForKey:DATABASE_COURSE_LEVELTEXT] isEqualToString:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]])
        {
            return [local_courseArr objectAtIndex:0];
        }
        
    }
    
    NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:0] valueForKey:DATABASE_COURSE_CEDGE]];
    NSArray * local_courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
    if([local_courseArr count] >0)
        return [local_courseArr objectAtIndex:0];
    else
        return nil;
    
    
    
    //    NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@",DATABASE_TABLE_COURSETABLE];
    //    [Logger logDebug:queryStr];
    //    NSArray * arr = [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_COURSETABLE];
    //    for (NSDictionary * obj in arr) {
    //        if([[obj valueForKey:DATABASE_COURSE_DATA] isEqualToString:code])
    //        {
    //            return obj;
    //        }
    //    }
    //
    //    for (NSDictionary * obj in arr) {
    //        if([[obj valueForKey:DATABASE_COURSE_LEVELTEXT] isEqualToString:[[NSString alloc]initWithFormat:@"%@",appDelegate.GSE_level]])
    //        {
    //            return obj;
    //        }
    //    }
    //
    //    if([arr count] > 0)
    //        return [arr objectAtIndex:0];
    //    else
    //        return nil;
}

-(NSDictionary *)getQuizOrAssementData:(NSString *)uid :(int)CatType
{
    NSArray * arr;
    if(CatType == 3)
    {
        NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_EDGEID,uid];
        [Logger logDebug:queryStr];
        arr = [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    }
    else
    {
        NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@ where %@ = %@",DATABASE_TABLE_PRACTICETABLE,DATABASE_PRACTICE_EDGEID,uid];
        [Logger logDebug:queryStr];
        arr = [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    }
    if([arr count]>0)
        return [arr objectAtIndex:0];
    else
        return nil;
}

-(NSArray *)getCourseData:(NSString *)courseCode
{
    NSString *query = [[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_DATA,courseCode];
    NSMutableArray *  innerArr  = [[NSMutableArray alloc]init];
    NSArray * dataArray = [dataObj SelecteQuery:query Table:DATABASE_TABLE_COURSETABLE];
    for (NSDictionary * obj in dataArray) {
        
        
        NSMutableDictionary * catDic = [[NSMutableDictionary alloc] init];
        [innerArr addObject:catDic];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_NAME] forKey:DATABASE_COURSE_NAME];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_CEDGE] forKey:DATABASE_COURSE_CEDGE];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_DESC] forKey:DATABASE_COURSE_DESC];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_DATA] forKey:DATABASE_COURSE_DATA];
        [catDic setValue:[obj valueForKey:DATABASE_COURSE_IMGPATH] forKey:DATABASE_COURSE_IMGPATH];
    }
    return innerArr;
}





#pragma mark -    COINS Related Functions


-(BOOL)insertIndividualCoins:(NSDictionary *) obj
{
    NSMutableString * queryselectStr = [[NSMutableString alloc]initWithFormat:@"SELECT * from %@ WHERE %@='%@' AND %@ like '%%%@%%'; AND %@='%@'",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COMPONANTID,[obj valueForKey:DATABASE_COINS_COMPONANTID],DATABASE_COINS_COMPONANTDATA,[obj valueForKey:DATABASE_COINS_COMPONANTDATA],DATABASE_COINS_COMPONANTDATACOINS,@"1"];
    [Logger logDebug:queryselectStr];
    NSArray * arr = [dataObj SelecteQuery:queryselectStr Table:DATABASE_TABLE_COINSTABLE];
    if(arr != NULL && [arr count]>0)
    {
        return FALSE;
    }
    else
    {
        
        NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@')",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COURSECODE,DATABASE_COINS_TOPICID,DATABASE_COINS_CAHPTERID,DATABASE_COINS_COMPONANTID,DATABASE_COINS_COMPONANTTYPE,DATABASE_COINS_COMPONANTDATA,DATABASE_COINS_COMPONANTDATACOINS,[obj valueForKey:DATABASE_COINS_COURSECODE],[obj valueForKey:DATABASE_COINS_TOPICID],[obj valueForKey:DATABASE_COINS_CAHPTERID],[obj valueForKey:DATABASE_COINS_COMPONANTID],[obj valueForKey:DATABASE_COINS_COMPONANTTYPE],[obj valueForKey:DATABASE_COINS_COMPONANTDATA],[obj valueForKey:DATABASE_COINS_COMPONANTDATACOINS]];
        
        [Logger logDebug:queryStr];
        [dataObj insertQuery:queryStr];
        [self ComponantupdateCoins:[obj valueForKey:DATABASE_COINS_COMPONANTID]];
        return TRUE;
    }
}



-(BOOL)insertCoins:(NSArray *)dataArr
{
    for (NSDictionary * obj in dataArr) {
        
        NSMutableString * queryselectStr = [[NSMutableString alloc]initWithFormat:@"SELECT * from %@ WHERE %@='%@' AND %@ like '%%%@%%'; AND %@='%@'",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COMPONANTID,[obj valueForKey:DATABASE_COINS_COMPONANTID],DATABASE_COINS_COMPONANTDATA,[obj valueForKey:DATABASE_COINS_COMPONANTDATA],DATABASE_COINS_COMPONANTDATACOINS,@"1"];
        [Logger logDebug:queryselectStr];
        NSArray * arr = [dataObj SelecteQuery:queryselectStr Table:DATABASE_TABLE_COINSTABLE];
        if(arr != NULL && [arr count]>0)
        {
        }
        else
        {
            NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"INSERT INTO %@ (%@,%@,%@,%@,%@,%@,%@) VALUES ('%@','%@','%@','%@','%@','%@','%@')",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COURSECODE,DATABASE_COINS_TOPICID,DATABASE_COINS_CAHPTERID,DATABASE_COINS_COMPONANTID,DATABASE_COINS_COMPONANTTYPE,DATABASE_COINS_COMPONANTDATA,DATABASE_COINS_COMPONANTDATACOINS,[obj valueForKey:DATABASE_COINS_COURSECODE],[obj valueForKey:DATABASE_COINS_TOPICID],[obj valueForKey:DATABASE_COINS_CAHPTERID],[obj valueForKey:DATABASE_COINS_COMPONANTID],[obj valueForKey:DATABASE_COINS_COMPONANTTYPE],[obj valueForKey:DATABASE_COINS_COMPONANTDATA],[obj valueForKey:DATABASE_COINS_COMPONANTDATACOINS]];
            
            [Logger logDebug:queryStr];
            [dataObj insertQuery:queryStr];
        }
    }
    if([dataArr count] > 0)
        [self ComponantupdateCoins:[[dataArr objectAtIndex:0] valueForKey:DATABASE_COINS_COMPONANTID]];
    return TRUE;
}

-(NSArray*)getCoinsArr
{
    NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@",DATABASE_TABLE_COINSTABLE];
    [Logger logDebug:queryStr];
    return  [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_COINSTABLE];
}



-(BOOL)deleteCoinsData
{
    NSString * strfmt = [[NSString alloc]initWithFormat:@"DELETE FROM %@",DATABASE_TABLE_COINSTABLE];
    [Logger logAduro:strfmt];
    return  [dataObj deleteQuery:strfmt];
}

-(void)updateUserCoins:(NSDictionary *) obj
{
    NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"INSERT INTO %@(%@,%@,%@,%@) VALUES ('%@',%@,%@,'%@')",DATABASE_TABLE_COINSUSERTABLE,DATABASE_COINSUSER_PACKAGECODE,DATABASE_COINSUSER_COMPONANTID,DATABASE_COINSUSER_EARNEDCOINS,DATABASE_COINSUSER_TOTALCOINS,appDelegate.coursePack,[obj valueForKey:@"edgeId"],[obj valueForKey:@"total_earned_coins"],[obj valueForKey:@"total_coins_avail"]];
    [Logger logDebug:queryStr];
    [dataObj insertQuery:queryStr];
    
    [self insertCoins:[obj valueForKey:@"coins_detail"]];
    
}

-(NSArray *)getComponantCoins:(NSString *)edge_id
{
    NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@ where %@='%@'",DATABASE_TABLE_COINSUSERTABLE,DATABASE_COINSUSER_COMPONANTID,edge_id];
    [Logger logDebug:queryStr];
    return  [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_COINSUSERTABLE];
}

-(void)ComponantupdateCoins:(NSString *)edge_id
{
    NSMutableString * queryStr = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@ where %@='%@'",DATABASE_TABLE_COINSTABLE,DATABASE_COINS_COMPONANTID,edge_id];
    [Logger logDebug:queryStr];
    NSArray * arr =  [dataObj SelecteQuery:queryStr Table:DATABASE_TABLE_COINSTABLE];
    NSMutableString * query = [[NSMutableString alloc]initWithFormat:@"UPDATE %@ SET %@='%@' where %@='%@'",DATABASE_TABLE_COINSUSERTABLE,DATABASE_COINSUSER_EARNEDCOINS,[[NSString alloc]initWithFormat:@"%d",[arr count]],DATABASE_COINSUSER_COMPONANTID,edge_id];
    [Logger logDebug:query];
    [dataObj updateQuery:query];
    
    NSMutableString * queryCoins = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM %@ where %@='%@'",DATABASE_TABLE_COINSUSERTABLE,DATABASE_COINSUSER_COMPONANTID,edge_id];
    [Logger logDebug:queryCoins];
    NSArray * arrCoins =   [dataObj SelecteQuery:queryCoins Table:DATABASE_TABLE_COINSUSERTABLE];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"broadCasttotalcoins" object:arrCoins userInfo:nil];
}


-(NSMutableArray *)getAllDownloadedCoursesWithChapter:(NSString *)contentPack
{
    NSMutableArray * courseArr = [[NSMutableArray alloc]init];
    
    NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE,DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE,contentPack];
    NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
    
    for(int i = 0 ; i< courseMapArr.count ; i++  )
    {
        NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
        NSArray * local_courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
        
        NSMutableDictionary * courseObj = [local_courseArr objectAtIndex:0];
        
        NSMutableArray * chapArr = [self getAllDownloadedChaptersBasedCourse:[courseObj  valueForKey:DATABASE_COURSE_CEDGE] :[courseObj  valueForKey:DATABASE_COURSE_DATA]];
        if(chapArr != NULL && [chapArr count] > 0)
        {
            [courseObj setObject:chapArr forKey:@"DownloadedChapters"];
            [courseArr addObject:courseObj ];
        }
    }
    
    
    return courseArr;
}

-(NSMutableArray *)getAllDownloadedChaptersBasedCourse :(NSString *)course_id :(NSString *) courseCode
{
    NSMutableArray * chaptersArr = [[NSMutableArray alloc]init];
    NSString * topicquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,course_id];
    NSArray * topicDataArray  = [dataObj SelecteQuery:topicquery Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    if(topicDataArray != NULL && [topicDataArray count] > 0)
    {
        for (NSDictionary * obj  in topicDataArray) {
            if([[obj valueForKey:DATABASE_CATLOGCONT_CATTYPE] intValue] == 3){
                NSString * zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[obj valueForKey:DATABASE_CATLOGCONT_EDGEID] intValue] :[obj valueForKey:DATABASE_SCENARIO_SCATTYPE]]];
                if([appDelegate checkZipPath:zipName])
                {
                    [chaptersArr addObject:obj];
                }
            }
            else
            {
                NSMutableArray * arr = [self  getAllDownloadedChaptersBasedTopic:[obj valueForKey:DATABASE_CATLOGCONT_EDGEID] :courseCode];
                [chaptersArr addObjectsFromArray:arr];
                
            }
            
        }
    }
    return chaptersArr;
}

-(NSMutableArray *)getAllDownloadedChaptersBasedTopic :(NSString *)topicId :(NSString *) courseCode
{
    
    NSMutableArray * chaptersArr = [[NSMutableArray alloc]init];
    NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,topicId];
    
    NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
    if(scnDataArray != NULL && [scnDataArray count] > 0)
    {
        for (NSDictionary * obj  in scnDataArray) {
            NSString * zipName = [[NSString alloc]initWithFormat:@"%@",[appDelegate.engineObj getZipfileName:[[obj valueForKey:DATABASE_SCENARIO_EDGEID] intValue] :[obj valueForKey:DATABASE_SCENARIO_SCATTYPE]]];
            if([appDelegate checkZipPath:zipName :courseCode])
            {
                [chaptersArr addObject:obj];
            }
        }
    }
    
    return chaptersArr;
}

-(NSMutableArray *)getChapterAndAssessmentList
{
    
    NSMutableArray * chaptersArr = [[NSMutableArray alloc]init];
    NSString * topicquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_CATLOGCONTENTTABLE,DATABASE_CATLOGCONT_CEDGEID,[appDelegate.workingCourseObj valueForKey:DATABASE_COURSE_CEDGE]];
    NSArray * topicDataArray  = [dataObj SelecteQuery:topicquery Table:DATABASE_TABLE_CATLOGCONTENTTABLE];
    for (NSDictionary * obj  in topicDataArray) {
        if([[obj valueForKey:DATABASE_CATLOGCONT_CATTYPE] intValue] == 3){
            [chaptersArr addObject:obj];
        }
        else
        {
            NSString * scnquery =[[NSString alloc]initWithFormat:@"SELECT * from %@ where %@ = %@",DATABASE_TABLE_SCENARIOTABLE,DATABASE_SCENARIO_CEDGEID,[obj valueForKey:DATABASE_CATLOGCONT_EDGEID]];
            NSArray * scnDataArray  = [dataObj SelecteQuery:scnquery Table:DATABASE_TABLE_SCENARIOTABLE];
            for (NSDictionary * _obj  in scnDataArray) {
                [chaptersArr addObject:_obj];
                
            }
            
        }
        
    }
    return chaptersArr;
    
}





-(NSMutableArray *)getlevelArrayFromCourses :(NSString * )contentPack
{
    NSMutableArray * levelArray = [[NSMutableArray alloc]init];
    
    NSString * strmapfmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE,DATABASE_COURSEPACKCOURSEMAPPING_COURSEPACKCODE,contentPack];
    NSArray * courseMapArr = [dataObj SelecteQuery:strmapfmt Table :DATABASE_TABLE_COURSEPACKCOURSEMAPPINGTABLE];
    
    for(int i = 0 ; i< courseMapArr.count ; i++  )
    {
        NSString * strCoursefmt = [[NSString alloc]initWithFormat:@"SELECT * from %@ WHERE %@ = '%@'",DATABASE_TABLE_COURSETABLE,DATABASE_COURSE_CEDGE,[[courseMapArr objectAtIndex:i] valueForKey:DATABASE_COURSE_CEDGE]];
        NSArray * local_courseArr = [dataObj SelecteQuery:strCoursefmt Table :DATABASE_TABLE_COURSETABLE];
        
        NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
        [obj setValue:[[local_courseArr objectAtIndex:0]valueForKey:DATABASE_COURSE_LEVELTEXT] forKey:@"level"];
        [obj setValue:[[local_courseArr objectAtIndex:0]valueForKey:DATABASE_COURSE_LEVELDESC] forKey:@"levelDesc"];
        [obj setValue:[[local_courseArr objectAtIndex:0]valueForKey:DATABASE_COURSE_LEVELCEFRMAP] forKey:@"CEFR"];
//        [obj setValue:[[local_courseArr objectAtIndex:0]valueForKey:DATABASE_COURSE_NAME] forKey:@"courseName"];
        
        if ([levelArray containsObject:obj])
        {
            
        }
        else{
            [levelArray addObject:obj];
        }
        
    }
    
    return levelArray;
}

-(BOOL)updateUserProfile:(NSString *)name :(NSString *)password
{
    if(name.length > 0 && password.length > 5 )
    {
        NSMutableString * query = [[NSMutableString alloc]initWithFormat:@"UPDATE %@ SET %@='%@', %@ = '%@' where rowid = 1",DATABASE_TABLE_USERINFO,DATABASE_PASSWORD,password,DATABASE_USERNAME,name];
        [Logger logDebug:query];
        return [dataObj updateQuery:query];
    }
    else if (name.length > 0 && password.length == 0)
    {
        NSMutableString * query = [[NSMutableString alloc]initWithFormat:@"UPDATE %@ SET %@='%@' where rowid = 1",DATABASE_TABLE_USERINFO,DATABASE_USERNAME,name];
        [Logger logDebug:query];
        return [dataObj updateQuery:query];
    }
    else if (name.length == 0 && password.length >5 )
    {
        NSMutableString * query = [[NSMutableString alloc]initWithFormat:@"UPDATE %@ SET %@='%@' where rowid = 1",DATABASE_TABLE_USERINFO,DATABASE_PASSWORD,password];
        [Logger logDebug:query];
        return [dataObj updateQuery:query];
    }
    else
    {
        return TRUE;
    }
}

@end











