//
//  XMLDictionary.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 20/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "XMLDictionary.h"
#import "XMLParserHeader.h"
#import "tablesMacro.h"
#import "GlobalHeader.h"






@implementation XMLDictionary


-(XMLDictionary * )init :(NSString *)Code
{
    self = [super init];
    CourseCode = Code;
    return self;
}

-(BOOL)parseVocabXML
{
    self.vocab_WordArray = [[NSMutableArray alloc]init];
    CouterID=0;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath = [dataPath stringByAppendingPathComponent:CourseCode];
    dataPath = [dataPath stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    
    dataPath = [dataPath stringByAppendingPathComponent:VOCABLARYFOLDERNAME];
    dataPath = [dataPath stringByAppendingPathComponent:VOCABLARYWORDFOLDERNAME];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSArray *fileList = [manager contentsOfDirectoryAtPath:dataPath error:nil];
    for (NSString *tString in fileList) {
        if ([tString hasSuffix:@".xml"]) {
            NSString * filePath =   [dataPath stringByAppendingPathComponent:tString];
            NSData *xmlData = [NSData dataWithContentsOfFile:filePath];
            xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
            [xmlParser setDelegate:self];
            [xmlParser parse];
            
        }
    }
    return true;
}

-(BOOL)parseXML:(NSString *)xmlpath
{
    CouterID=0;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:xmlpath] == NO) {
        return FALSE;
    }
    else{
        NSData *xmlData = [NSData dataWithContentsOfFile:xmlpath];
        self.courseArray = [[NSMutableArray alloc]init];
        self.catlogArray= [[NSMutableArray alloc]init];
        self.assessmentArray= [[NSMutableArray alloc]init];
        self.moduleArray= [[NSMutableArray alloc]init];
        self.scenarioArray= [[NSMutableArray alloc]init];
        self.conceptArray= [[NSMutableArray alloc]init];
        self.activityArray= [[NSMutableArray alloc]init];
        self.practiceArray= [[NSMutableArray alloc]init];
        self.scenario_practiceArray = [[NSMutableArray alloc]init];
        self.vocab_practiceArray = [[NSMutableArray alloc]init];
        self.mcq_practiceArray= [[NSMutableArray alloc]init];
        self.game_practiceArray= [[NSMutableArray alloc]init];
        self.speedReading_practiceArray= [[NSMutableArray alloc]init];
        self.watch_scenario_practiceArray= [[NSMutableArray alloc]init];
        self.enact_scenario_practiceArray= [[NSMutableArray alloc]init];
        self.review_scenario_practiceArray= [[NSMutableArray alloc]init];
        level =0;
        
        xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
        [xmlParser setDelegate:self];
        [xmlParser parse];
    }
    return TRUE;
}





-(BOOL)parseCourseJSON : (NSDictionary *) jsonData
{
    if(jsonData != NULL)
    {
        
        self.courseArray = [[NSMutableArray alloc]init];
        self.catlogArray= [[NSMutableArray alloc]init];
        self.assessmentArray= [[NSMutableArray alloc]init];
        self.moduleArray= [[NSMutableArray alloc]init];
        self.scenarioArray= [[NSMutableArray alloc]init];
        NSDictionary * _courseDict = [jsonData valueForKey:COURSE];
        if(_courseDict!= NULL)
        {
            courseDict = [[NSMutableDictionary alloc]init];
            [courseDict setValue:[_courseDict valueForKey:NAME] forKey:NAME];
            [courseDict setValue:[_courseDict valueForKey:EDGEID] forKey:EDGEID];
            [courseDict setValue:[_courseDict valueForKey:DESCRIPTION] forKey:DESCRIPTION];
            [courseDict setValue:[_courseDict valueForKey:DURATION] forKey:DURATION];
            [courseDict setValue:[_courseDict valueForKey:VERSION] forKey:VERSION];
            [courseDict setValue:[_courseDict valueForKey:IMGPATH] forKey:IMGPATH];
            
            
            NSDictionary * _catelog = [_courseDict valueForKey:CATELOG];
            if(_catelog != NULL)
            {
                catlogDict = [[NSMutableDictionary alloc]init];
                [catlogDict setValue:[courseDict valueForKey:EDGEID] forKey:PEDGEID];
                [catlogDict setValue:[_catelog valueForKey:EDGEID] forKey:EDGEID];
                NSArray * _catCompo = [_catelog valueForKey:CATCOMPONANT];
                for (NSDictionary * _object in _catCompo) {
                    if(_object != NULL)
                    {
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        moduleDict = [[NSMutableDictionary alloc]init];
                        if([[_object valueForKey:CATCOMPONANTTYPE]isEqualToString:ASSISSMENT]) [moduleDict setValue:DATABASE_CATTYPE_ASSISMENT_XML forKey:CATTYPE];
                        else if([[_object valueForKey:CATCOMPONANTTYPE]isEqualToString:MODULE])[moduleDict setValue:DATABASE_CATTYPE_MODULE forKey:CATTYPE];
                        
                        
                        [moduleDict setValue:[_object valueForKey:EDGEID] forKey:EDGEID];
                        [moduleDict setValue:[courseDict valueForKey:EDGEID] forKey:PEDGEID];
                        [moduleDict setValue:[_object valueForKey:NAME] forKey:NAME];
                        [moduleDict setValue:[_object valueForKey:DATA] forKey:DATA];
                        [moduleDict setValue:[_object valueForKey:THUMBNILIMG] forKey:DATABASE_CATLOGCONT_THUMBNILIMG];
                        
                        if([_object valueForKey:DESCRIPTION] != NULL && ![[_object valueForKey:DESCRIPTION] isEqual:[NSNull null]] &&  ![[_object valueForKey:DESCRIPTION] isEqualToString:@""]){
                            
                            [moduleDict setValue:[_object valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                        }
                        else
                        {
                            [moduleDict setValue:@"" forKey:DESCRIPTION];
                        }
                        if([_object valueForKey:DATABASE_CATLOGCONT_TOPIC_TYPE] != NULL && ![[_object valueForKey:DATABASE_CATLOGCONT_TOPIC_TYPE] isEqual:[NSNull null]] &&  ![[_object valueForKey:DATABASE_CATLOGCONT_TOPIC_TYPE] isEqualToString:@""]){
                            
                            [moduleDict setValue:[_object valueForKey:DATABASE_CATLOGCONT_TOPIC_TYPE] forKey:DATABASE_CATLOGCONT_TOPIC_TYPE];
                        }
                        else
                        {
                            [moduleDict setValue:@"1" forKey:DATABASE_CATLOGCONT_TOPIC_TYPE];
                        }
                        
                        if([_object valueForKey:DURATION] != NULL && ![[_object valueForKey:DURATION] isEqual:[NSNull null]]){
                            
                            [moduleDict setValue:[_object valueForKey:DURATION] forKey:DATABASE_CATLOGCONT_DURATION];
                        }
                        else
                        {
                            [moduleDict setValue:@"0" forKey:DATABASE_CATLOGCONT_DURATION];
                        }
                        
                        
                        if([_object valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK] != NULL  && ![[_object valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK] isEqual:[NSNull null]] &&  [[_object valueForKey:DATABASE_CATLOGCONT_ISTOPICLOCK]boolValue]){
                            [moduleDict setValue:@"1" forKey:DATABASE_CATLOGCONT_ISTOPICLOCK];
                        }
                        else
                        {
                            [moduleDict setValue:@"0" forKey:DATABASE_CATLOGCONT_ISTOPICLOCK];
                        }
                        
                        
                        if([_object valueForKey:ZIPURL] != NULL && ![[_object valueForKey:ZIPURL] isEqual:[NSNull null]] &&  ![[_object valueForKey:ZIPURL] isEqualToString:@""]){
                            
                            [moduleDict setValue:[_object valueForKey:ZIPURL] forKey:ZIPURL];
                        }
                        else
                        {
                            [moduleDict setValue:@"" forKey:ZIPURL];
                        }
                        
                        if([_object valueForKey:ASSESSMENT_TYPE] != NULL && ![[_object valueForKey:ASSESSMENT_TYPE] isEqual:[NSNull null]] ){
                            [defaults setObject:[_object valueForKey:ASSESSMENT_TYPE] forKey:[[NSString alloc]initWithFormat:@"asmt_type_%@",[_object valueForKey:EDGEID]]];
                            
                            [moduleDict setValue:[_object valueForKey:ASSESSMENT_TYPE] forKey:ASSESSMENT_TYPE];
                        }
                        else
                        {
                            [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"asmt_type_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"0" forKey:ASSESSMENT_TYPE];
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        if([_object valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] != NULL && ![[_object valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] isEqual:[NSNull null]] && [[_object valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID]intValue] > 0){
                            [moduleDict setValue:[_object valueForKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID] forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
                        }
                        else
                        {
                            [moduleDict setValue:@"0" forKey:DATABASE_CATLOGCONT_REMEDIATIONEDGEID];
                        }
                        
                        
                        
                        
                        
                        if([_object valueForKey:ZIPSIZE] != NULL && ![[_object valueForKey:ZIPSIZE] isEqual:[NSNull null]] && ![[[NSString alloc]initWithFormat:@"%ld",[_object valueForKey:ZIPSIZE]]isEqualToString:@"0"] ){
                            [defaults setObject:[_object valueForKey:ZIPSIZE] forKey:[[NSString alloc]initWithFormat:@"zipsize_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:[_object valueForKey:ZIPSIZE] forKey:ZIPSIZE];
                        }
                        else
                        {
                            [defaults setObject:@"5242448" forKey:[[NSString alloc]initWithFormat:@"zipsize_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"5242448" forKey:ZIPSIZE];
                        }
                        
                        
                        
                        //#define ASSESSMENT_TYPE @"assessment_type"
                        //#define ASSESSMENT_SKILLS @"skills"
                        //#define ASSESSMENT_PASS_SCORE @"passing_score"
                        //#define ASSESSMENT_TOTAL_QUESTION @"total_question"
                        //#define ASSESSMENT_TATAL_SHOW_QUESTION @"ttl_ques_to_show"
                        //#define ASSESSMENT_NO_SKILL_QUES @"no_of_skill_ques"
                        
                        
                        
                        
                        
                        
                        
                        if([_object valueForKey:ASSESSMENT_PASS_SCORE] != NULL && ![[_object valueForKey:ASSESSMENT_PASS_SCORE] isEqual:[NSNull null]] )
                        {
                            
                            [defaults setObject:[_object valueForKey:ASSESSMENT_PASS_SCORE] forKey:[[NSString alloc]initWithFormat:@"pass_mark_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:[_object valueForKey:ASSESSMENT_PASS_SCORE] forKey:ASSESSMENT_PASS_SCORE];
                        }
                        else
                        {
                            [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"pass_mark_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"0" forKey:ASSESSMENT_PASS_SCORE];
                        }
                        
                        
                        
                        
                        if([_object valueForKey:ASSESSMENT_SKILLS] != NULL && ![[_object valueForKey:ASSESSMENT_SKILLS] isEqual:[NSNull null]]  ){
                            
                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[_object valueForKey:ASSESSMENT_SKILLS] options:NSJSONWritingPrettyPrinted error:nil];
                            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            [defaults setObject:jsonString forKey:[[NSString alloc]initWithFormat:@"skill_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:jsonString forKey:ASSESSMENT_SKILLS];
                            //[moduleDict setValue:@"" forKey:ASSESSMENT_SKILLS];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"skill_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"" forKey:ASSESSMENT_SKILLS];
                        }
                        
                        
                        
                        if([_object valueForKey:ASSESSMENT_TOTAL_QUESTION] != NULL  && ![[_object valueForKey:ASSESSMENT_TOTAL_QUESTION] isEqual:[NSNull null]])
                        {
                            [defaults setObject:(id)[_object valueForKey:ASSESSMENT_TOTAL_QUESTION] forKey:[[NSString alloc]initWithFormat:@"total_question_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:[_object valueForKey:ASSESSMENT_TOTAL_QUESTION] forKey:ASSESSMENT_TOTAL_QUESTION];
                        }
                        else
                        {
                            [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"total_question_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"0"  forKey:ASSESSMENT_TOTAL_QUESTION];
                        }
                        
                        
                        
                        if([_object valueForKey:ASSESSMENT_TATAL_SHOW_QUESTION] != NULL &&  ![[_object valueForKey:ASSESSMENT_TATAL_SHOW_QUESTION] isEqual:[NSNull null]] )
                        {
                            [defaults setObject:[_object valueForKey:ASSESSMENT_TATAL_SHOW_QUESTION] forKey:[[NSString alloc]initWithFormat:@"total_show_question_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:[_object valueForKey:ASSESSMENT_TATAL_SHOW_QUESTION] forKey:ASSESSMENT_TATAL_SHOW_QUESTION];
                        }
                        else
                        {
                            [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"total_show_question_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"0" forKey:ASSESSMENT_TATAL_SHOW_QUESTION];
                        }
                        
                        
                        
                        if([_object valueForKey:ASSESSMENT_NO_SKILL_QUES] != NULL && ![[_object valueForKey:ASSESSMENT_NO_SKILL_QUES] isEqual:[NSNull null]]  ){
                            [defaults setObject:[_object valueForKey:ASSESSMENT_NO_SKILL_QUES] forKey:[[NSString alloc]initWithFormat:@"map_ques_%@",[_object valueForKey:EDGEID]]];
                            //[moduleDict setValue:@"" forKey:ASSESSMENT_NO_SKILL_QUES];
                            [moduleDict setValue:[_object valueForKey:ASSESSMENT_NO_SKILL_QUES] forKey:ASSESSMENT_NO_SKILL_QUES];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"map_ques_%@",[_object valueForKey:EDGEID]]];
                            [moduleDict setValue:@"" forKey:ASSESSMENT_NO_SKILL_QUES];
                        }
                        [defaults synchronize];
                        
                        NSArray * _scnArr = [_object valueForKey:SCHENARIO];
                        for (NSDictionary * _scnObject in _scnArr) {
                            if(_scnObject != NULL)
                            {
                                scenarioDict = [[NSMutableDictionary alloc]init];
                                [scenarioDict setValue:[moduleDict valueForKey:EDGEID] forKey:PEDGEID];
                                [scenarioDict setValue:[_scnObject valueForKey:EDGEID] forKey:EDGEID];
                                
                                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                if([_scnObject valueForKey:ZIPSIZE] != NULL && ![[[NSString alloc]initWithFormat:@"%ld",[_scnObject valueForKey:ZIPSIZE]]isEqualToString:@"0"] ){
                                    [defaults setObject:[_scnObject valueForKey:ZIPSIZE] forKey:[[NSString alloc]initWithFormat:@"zipsize_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:ZIPSIZE] forKey:DATABASE_SCENARIO_ZIPSIZE];
                                    
                                    
                                }
                                else
                                {
                                    [defaults setObject:@"5242448" forKey:[[NSString alloc]initWithFormat:@"zipsize_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"5242448" forKey:DATABASE_SCENARIO_ZIPSIZE];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:@"bgcolor"] != NULL && ![[[NSString alloc]initWithFormat:@"%@",[_scnObject valueForKey:@"bgcolor"]]isEqualToString:@""] ){
                                    [defaults setObject:[_scnObject valueForKey:@"bgcolor"] forKey:[[NSString alloc]initWithFormat:@"bgcolor_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:@"bgcolor"] forKey:DATABASE_SCENARIO_BGCOLOR];
                                    
                                }
                                else
                                {
                                    [defaults setObject:@"#f5f5f5" forKey:[[NSString alloc]initWithFormat:@"bgcolor_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"#f5f5f5" forKey:DATABASE_SCENARIO_BGCOLOR];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:DURATION] != NULL && ![[_scnObject valueForKey:DURATION] isEqual:[NSNull null]]){
                                    [defaults setObject:[_scnObject valueForKey:DURATION] forKey:[[NSString alloc]initWithFormat:@"C_Duration_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:DURATION] forKey:DATABASE_SCENARIO_DURATION];
                                }
                                else
                                {
                                    [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"C_Duration_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"0" forKey:DATABASE_SCENARIO_DURATION];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:CHAPSKILL] != NULL && ![[_scnObject valueForKey:CHAPSKILL] isEqual:[NSNull null]])
                                {
                                    [defaults setObject:[_scnObject valueForKey:CHAPSKILL] forKey:[[NSString alloc]initWithFormat:@"C_Skill_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:CHAPSKILL] forKey:DATABASE_SCENARIO_SKILL];
                                    
                                }
                                else
                                {
                                    [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"C_Skill_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"" forKey:DATABASE_SCENARIO_SKILL];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:THUMBNILIMG] != NULL && ![[_scnObject valueForKey:THUMBNILIMG] isEqual:[NSNull null]])
                                {
                                    [defaults setObject:[_scnObject valueForKey:THUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"C_Thumbnil_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:THUMBNILIMG] forKey:DATABASE_SCENARIO_THUMBNAIL];
                                }
                                else
                                {
                                    [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"C_Thumbnil_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"" forKey:DATABASE_SCENARIO_THUMBNAIL];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:QUESCOUNT] != NULL && ![[_scnObject valueForKey:QUESCOUNT] isEqual:[NSNull null]]){
                                    
                                    [defaults setObject:[_scnObject valueForKey:QUESCOUNT] forKey:[[NSString alloc]initWithFormat:@"C_QuesCount_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:[_scnObject valueForKey:QUESCOUNT] forKey:DATABASE_SCENARIO_QUESCOUNT];
                                    
                                }
                                else
                                {
                                    [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"C_QuesCount_%@",[_scnObject valueForKey:EDGEID]]];
                                    [scenarioDict setValue:@"0" forKey:DATABASE_SCENARIO_QUESCOUNT];
                                }
                                
                                
                                
                                if([_scnObject valueForKey:DATABASE_SCENARIO_IS_HIDE] != NULL && ![[_scnObject valueForKey:DATABASE_SCENARIO_IS_HIDE] isEqual:[NSNull null]]){
                                    [scenarioDict setValue:[_scnObject valueForKey:DATABASE_SCENARIO_IS_HIDE] forKey:DATABASE_SCENARIO_IS_HIDE];
                                    
                                }
                                else
                                {
                                    [scenarioDict setValue:@"0" forKey:DATABASE_SCENARIO_IS_HIDE];
                                }
                                
                                //                                if([_scnObject valueForKey:CHAPSKILL] != NULL && ![[_scnObject valueForKey:CHAPSKILL] isEqual:[NSNull null]])
                                //                                {
                                //                                    [defaults setObject:[_scnObject valueForKey:CHAPSKILL] forKey:[[NSString alloc]initWithFormat:@"C_ChapSkill_%@",[_scnObject valueForKey:EDGEID]]];
                                //                                }
                                //                                else
                                //                                {
                                //                                    [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"C_ChapSkill_%@",[_scnObject valueForKey:EDGEID]]];
                                //                                }
                                
                                
                                
                                
                                
                                
                                [defaults synchronize];
                                [scenarioDict setValue:[_scnObject valueForKey:DATA] forKey:DATA];
                                [scenarioDict setValue:[_scnObject valueForKey:ZIPURL] forKey:ZIPURL];
                                [scenarioDict setValue:[_scnObject valueForKey:NAME] forKey:NAME];
                                
                                [scenarioDict setValue:[_scnObject valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                                
                                
                                [self.scenarioArray addObject:scenarioDict];
                                scenarioDict = NULL;
                                
                            }
                        }
                        [self.moduleArray addObject:moduleDict];
                        moduleDict = NULL;
                        
                        
                    }
                }
                
                
                [self.catlogArray addObject:catlogDict];
                catlogDict = NULL;
                
                
                
            }
            
            [self.courseArray addObject:courseDict];
            courseDict = NULL;
            
        }
    }
    
    return TRUE;
}





-(BOOL)parseScenarioJSON : (NSDictionary *) jsonData
{
    int local_sequence = 0;
    if(jsonData != NULL)
    {
        
        self.conceptArray= [[NSMutableArray alloc]init];
        self.activityArray= [[NSMutableArray alloc]init];
        self.practiceArray= [[NSMutableArray alloc]init];
        self.scenario_practiceArray = [[NSMutableArray alloc]init];
        self.watch_scenario_practiceArray= [[NSMutableArray alloc]init];
        self.enact_scenario_practiceArray= [[NSMutableArray alloc]init];
        self.review_scenario_practiceArray= [[NSMutableArray alloc]init];
        self.vocab_practiceArray = [[NSMutableArray alloc]init];
        self.mcq_practiceArray= [[NSMutableArray alloc]init];
        self.game_practiceArray= [[NSMutableArray alloc]init];
        self.speedReading_practiceArray = [[NSMutableArray alloc]init];
        self.resourse_practiceArray = [[NSMutableArray alloc]init];
        self.conversation_practiceArray = [[NSMutableArray alloc]init];
        self.learnosity_practiceArray = [[NSMutableArray alloc]init];
        
        
        
        
        NSDictionary * _scnComponant = [jsonData valueForKey:SCNCOMPONANT];
        if(_scnComponant != NULL && [_scnComponant isKindOfClass:[NSDictionary class]])
        {
            NSArray  * _conceptArr;
            if([_scnComponant valueForKey:CONCEPT] != NULL && ![[_scnComponant valueForKey:CONCEPT] isEqual:[NSNull null]] &&  [[_scnComponant valueForKey:CONCEPT] isKindOfClass:[NSArray class]]){
                _conceptArr = [_scnComponant valueForKey:CONCEPT];
            }else if([_scnComponant valueForKey:CONCEPT] != NULL && ![[_scnComponant valueForKey:CONCEPT]  isEqual:[NSNull null]] && [[_scnComponant valueForKey:CONCEPT]  isKindOfClass:[NSDictionary class]]){
                _conceptArr = [[NSArray alloc]initWithObjects:[_scnComponant valueForKey:CONCEPT], nil];
            }else{
                _conceptArr = [[NSArray alloc]init];
            }
            
            
            if(_conceptArr != NULL && [_conceptArr count] >0 )
            {
                for (NSDictionary * _concept in _conceptArr) {
                    
                    
                    conceptDict = [[NSMutableDictionary alloc]init];
                    [conceptDict setValue:[jsonData valueForKey:EDGEID] forKey:PEDGEID];
                    [conceptDict setValue:[_concept valueForKey:EDGEID] forKey:EDGEID];
                    [conceptDict setValue:[_concept valueForKey:NAME] forKey:NAME];
                    [conceptDict setValue:[_concept valueForKey:DATA] forKey:DATA];
                    [conceptDict setValue:DATABASE_CATTYPE_CONCEPT_XML forKey:CATTYPE];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    if([_concept valueForKey:DISPLAYSEQUENCE] != NULL && ![[_concept valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]]){
                        [defaults setObject:[_concept valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_concept valueForKey:EDGEID]]];
                        [conceptDict setValue:[_concept valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
                    }
                    
                    else
                    {
                        [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_concept valueForKey:EDGEID]]];
                        [conceptDict setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_EXERCISE_DISPLAYSEQUENCE];
                    }
                    
                    if([_concept valueForKey:COMTHUMBNILIMG] != NULL && ![[_concept valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                    {
                        [defaults setObject:[_concept valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_concept valueForKey:EDGEID]]];
                        [conceptDict setValue:[_concept valueForKey:COMTHUMBNILIMG] forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
                    }
                    else
                    {
                        [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_concept valueForKey:EDGEID]]];
                        [conceptDict setValue:@"" forKey:DATABASE_EXERCISE_COMTHUMBNILIMG];
                    }
                    
                    [defaults synchronize];
                    
                    
                    
                    
                    [self.conceptArray addObject:conceptDict];
                    conceptDict = NULL;
                }
                
            }
            NSDictionary * _activity = [_scnComponant valueForKey:ACTIVITY];
            if(_activity != NULL)
            {
                activityDict = [[NSMutableDictionary alloc]init];
                [activityDict setValue:[jsonData valueForKey:EDGEID] forKey:PEDGEID];
                [activityDict setValue:[_activity valueForKey:EDGEID] forKey:EDGEID];
                [activityDict setValue:[_activity valueForKey:NAME] forKey:NAME];
                [activityDict setValue:[_activity valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                [activityDict setValue:DATABASE_CATTYPE_ACTIVITY forKey:CATTYPE];
                
                
                [self.activityArray addObject:activityDict];
                activityDict = NULL;
                
            }
            
            
            NSDictionary * _practice = [_scnComponant valueForKey:PRACTICE];
            if(_practice != NULL)
            {
                practiceDict = [[NSMutableDictionary alloc]init];
                [practiceDict setValue:[jsonData valueForKey:EDGEID] forKey:PEDGEID];
                [practiceDict setValue:[_practice valueForKey:EDGEID] forKey:EDGEID];
                [practiceDict setValue:DATABASE_CATTYPE_PRACTICE forKey:CATTYPE];
                
                
                
                
                NSArray * scnPracticeArr ;
                if([_practice valueForKey:SCENARIOPRACTICE] != NULL && ![[_practice valueForKey:SCENARIOPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:SCENARIOPRACTICE] isKindOfClass:[NSArray class]]){
                    scnPracticeArr  = [_practice valueForKey:SCENARIOPRACTICE];
                }else if([_practice valueForKey:SCENARIOPRACTICE] != NULL && ![[_practice valueForKey:SCENARIOPRACTICE] isEqual:[NSNull null]] && [[_practice valueForKey:SCENARIOPRACTICE] isKindOfClass:[NSDictionary class]]){
                    scnPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:SCENARIOPRACTICE], nil];
                }else{
                    scnPracticeArr = [[NSArray alloc]init];
                }
                if(scnPracticeArr != NULL && [scnPracticeArr count] >0 )
                {
                    for (NSDictionary * _scnPractice in scnPracticeArr) {
                        
                        scenario_practiceDict = [[NSMutableDictionary alloc]init];
                        [scenario_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [scenario_practiceDict setValue:DATABASE_CATTYPE_SCN_PRACTICE_XML forKey:CATTYPE];
                        
                        [scenario_practiceDict setValue:[_scnPractice valueForKey:NAME] forKey:NAME];
                        [scenario_practiceDict setValue:[_scnPractice valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                        [scenario_practiceDict setValue:[_scnPractice valueForKey:DATA] forKey:DATA];
                        [scenario_practiceDict setValue:[_scnPractice valueForKey:EDGEID] forKey:EDGEID];
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_scnPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_scnPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]]){
                            
                            [defaults setObject:[_scnPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_scnPractice valueForKey:EDGEID]]];
                            [scenario_practiceDict setValue:[_scnPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                            
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_scnPractice valueForKey:EDGEID]]];
                            
                            [scenario_practiceDict setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        
                        if([_scnPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_scnPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]]){
                            [defaults setObject:[_scnPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_scnPractice valueForKey:EDGEID]]];
                            [scenario_practiceDict setValue:[_scnPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_scnPractice valueForKey:EDGEID]]];
                            [scenario_practiceDict setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        // [scenario_practiceDict setValue:[_scnPractice valueForKey:EDGEID] forKey:PEDGEID];
                        CurrentDictionary = SCENARIOPRACTICE_NO;
                        NSDictionary * _watch = [_scnPractice valueForKey:WATCH];
                        if(_watch != NULL)
                        {
                            
                            
                            watch_scenario_practiceDict = [[NSMutableDictionary alloc]init];
                            [watch_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                            [watch_scenario_practiceDict setValue:[_watch valueForKey:EDGEID] forKey:EDGEID];
                            
                            [self.watch_scenario_practiceArray addObject:watch_scenario_practiceDict];
                            watch_scenario_practiceDict = NULL;
                            
                        }
                        
                        
                        
                        NSDictionary * _enact = [_scnPractice valueForKey:ENACT];
                        if(_enact != NULL)
                        {
                            
                            enact_scenario_practiceDict = [[NSMutableDictionary alloc]init];
                            [enact_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                            [enact_scenario_practiceDict setValue:[_enact valueForKey:EDGEID] forKey:EDGEID];
                            
                            [self.enact_scenario_practiceArray addObject:enact_scenario_practiceDict];
                            enact_scenario_practiceDict = NULL;
                        }
                        NSDictionary * _review = [_scnPractice valueForKey:REVIEW];
                        if(_review != NULL)
                        {
                            
                            
                            review_scenario_practiceDict = [[NSMutableDictionary alloc]init];
                            [review_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                            [review_scenario_practiceDict setValue:[_review valueForKey:EDGEID] forKey:EDGEID];
                            
                            [self.review_scenario_practiceArray addObject:review_scenario_practiceDict];
                            review_scenario_practiceDict = NULL;
                        }
                        
                        
                        
                        
                        
                        
                        [self.scenario_practiceArray addObject:scenario_practiceDict];
                        scenario_practiceDict = NULL;
                    }
                }
                
                
                NSArray  * vcbPracticeArr;
                
                if([_practice valueForKey:VOCABPRACTICE] != NULL && ![[_practice valueForKey:VOCABPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:VOCABPRACTICE] isKindOfClass:[NSArray class]]){
                    vcbPracticeArr = [_practice valueForKey:VOCABPRACTICE];
                }else if([_practice valueForKey:VOCABPRACTICE] != NULL && ![[_practice valueForKey:VOCABPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:VOCABPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    vcbPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:VOCABPRACTICE], nil];
                }else{
                    vcbPracticeArr = [[NSArray alloc]init];
                }
                
                
                
                //NSArray * vcbPracticeArr = [_practice valueForKey:VOCABPRACTICE];
                if(vcbPracticeArr != NULL && [vcbPracticeArr count] >0 )
                {
                    for (NSDictionary * _vcbPractice in vcbPracticeArr) {
                        
                        vocab_practiceDict = [[NSMutableDictionary alloc]init];
                        [vocab_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        
                        
                        [vocab_practiceDict setValue:[_vcbPractice valueForKey:NAME] forKey:NAME];
                        [vocab_practiceDict setValue:[_vcbPractice valueForKey:EDGEID] forKey:EDGEID];
                        [vocab_practiceDict setValue:[_vcbPractice valueForKey:DATA] forKey:DATA];
                        [vocab_practiceDict setValue:[_vcbPractice valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                        
                        [vocab_practiceDict setValue:DATABASE_CATTYPE_VOCAB_PRACTICE_XML forKey:CATTYPE];
                        
                        
                        
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_vcbPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_vcbPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]]){
                            [defaults setObject:[_vcbPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_vcbPractice valueForKey:EDGEID]]];
                            [vocab_practiceDict setValue:[_vcbPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_vcbPractice valueForKey:EDGEID]]];
                            [vocab_practiceDict setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_vcbPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_vcbPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_vcbPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_vcbPractice valueForKey:EDGEID]]];
                            [vocab_practiceDict setValue:[_vcbPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_vcbPractice valueForKey:EDGEID]]];
                            [vocab_practiceDict setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        [self.vocab_practiceArray addObject:vocab_practiceDict];
                        vocab_practiceDict = NULL;
                    }
                }
                
                
                
                NSArray  * mcqPracticeArr;
                
                if([_practice valueForKey:MCQPRACTICE] != NULL && ![[_practice valueForKey:MCQPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:MCQPRACTICE] isKindOfClass:[NSArray class]]){
                    mcqPracticeArr = [_practice valueForKey:MCQPRACTICE];
                }else if([_practice valueForKey:MCQPRACTICE] != NULL && ![[_practice valueForKey:MCQPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:MCQPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    mcqPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:MCQPRACTICE], nil];
                }else{
                    mcqPracticeArr = [[NSArray alloc]init];
                }
                
                // NSArray * mcqPracticeArr = [_practice valueForKey:MCQPRACTICE];
                if(mcqPracticeArr != NULL && [mcqPracticeArr count] >0 )
                {
                    for (NSDictionary * _mcqPractice in mcqPracticeArr) {
                        mcq_practiceDict = [[NSMutableDictionary alloc]init];
                        [mcq_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [mcq_practiceDict setValue:DATABASE_CATTYPE_MCQ_PRACTICE_XML forKey:CATTYPE];
                        
                        [mcq_practiceDict setValue:[_mcqPractice valueForKey:NAME] forKey:NAME];
                        [mcq_practiceDict setValue:[_mcqPractice valueForKey:EDGEID] forKey:EDGEID];
                        [mcq_practiceDict setValue:[_mcqPractice valueForKey:DATA] forKey:DATA];
                        [mcq_practiceDict setValue:[_mcqPractice valueForKey:DESCRIPTION] forKey:DESCRIPTION];
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_mcqPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_mcqPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_mcqPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_mcqPractice valueForKey:IS_QT] != NULL && ![[_mcqPractice valueForKey:IS_QT] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_mcqPractice valueForKey:IS_QT] forKey:[[NSString alloc]initWithFormat:@"QT_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:IS_QT] forKey:IS_QT];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"0"] forKey:[[NSString alloc]initWithFormat:@"QT_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[[NSString alloc]initWithFormat:@"0"] forKey:IS_QT];
                        }
                        
                        
                        
                        if([_mcqPractice valueForKey:IS_WC] != NULL && ![[_mcqPractice valueForKey:IS_WC] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_mcqPractice valueForKey:IS_WC] forKey:[[NSString alloc]initWithFormat:@"WC_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:IS_WC] forKey:IS_WC];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"0"] forKey:[[NSString alloc]initWithFormat:@"WC_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[[NSString alloc]initWithFormat:@"0"] forKey:IS_WC];
                        }
                        
                        if([_mcqPractice valueForKey:STATEMENT] != NULL && ![[_mcqPractice valueForKey:STATEMENT] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_mcqPractice valueForKey:STATEMENT] forKey:[[NSString alloc]initWithFormat:@"STATEMENT_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:STATEMENT] forKey:STATEMENT];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@""] forKey:[[NSString alloc]initWithFormat:@"STATEMENT_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[[NSString alloc]initWithFormat:@""] forKey:STATEMENT];
                        }
                        
                        
                        if([_mcqPractice valueForKey:TIPSNAME] != NULL && ![[_mcqPractice valueForKey:TIPSNAME] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_mcqPractice valueForKey:TIPSNAME] forKey:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:TIPSNAME] forKey:TIPSNAME];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@""] forKey:[[NSString alloc]initWithFormat:@"TIPSNAME_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[[NSString alloc]initWithFormat:@""] forKey:TIPSNAME];
                        }
                        
                        
                        if([_mcqPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_mcqPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]]){
                            [defaults setObject:[_mcqPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:[_mcqPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_mcqPractice valueForKey:EDGEID]]];
                            [mcq_practiceDict setValue:@""  forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        [self.mcq_practiceArray addObject:mcq_practiceDict];
                        mcq_practiceDict = NULL;
                    }
                }
                
                
                
                NSArray  * gamePracticeArr;
                
                if([_practice valueForKey:GAMEPRACTICE] != NULL && ![[_practice valueForKey:GAMEPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:GAMEPRACTICE] isKindOfClass:[NSArray class]]){
                    gamePracticeArr = [_practice valueForKey:GAMEPRACTICE];
                }else if([_practice valueForKey:GAMEPRACTICE] != NULL && ![[_practice valueForKey:GAMEPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:GAMEPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    gamePracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:GAMEPRACTICE], nil];
                }else{
                    gamePracticeArr = [[NSArray alloc]init];
                }
                
                
                // NSArray * gamePracticeArr = [_practice valueForKey:GAMEPRACTICE];
                if(gamePracticeArr != NULL && [gamePracticeArr count] >0 )
                {
                    for (NSDictionary * _gamePractice in gamePracticeArr) {
                        game_practiceDict = [[NSMutableDictionary alloc]init];
                        [game_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [game_practiceDict setValue:DATABASE_CATTYPE_GAME forKey:CATTYPE];
                        [game_practiceDict setValue:[_gamePractice valueForKey:NAME] forKey:NAME];
                        [game_practiceDict setValue:[_gamePractice valueForKey:EDGEID] forKey:EDGEID];
                       
                        
                        
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        
                        
                        
                        if([_gamePractice valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] != NULL && ![[_gamePractice valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_gamePractice valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:[[NSString alloc]initWithFormat:@"template_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:[_gamePractice valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML] forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
                            if([[_gamePractice valueForKey:DATABASE_PRACTICE_INTERACTIVE_HTML]intValue] == 1)
                            {
                                
                                NSMutableDictionary * obj = [[NSMutableDictionary alloc]init];
                                [obj setValue:[_gamePractice valueForKey:NAME] forKey:@"title"];
                                [obj setValue:[_gamePractice valueForKey:@"scenario_description"] forKey:@"data"];
                                NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:obj, nil];
                                
                                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:NSJSONWritingPrettyPrinted error:nil];
                                 NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                
                                [game_practiceDict setValue:jsonString forKey:DATA];
                            }
                            else
                            {
                                NSError *error;
                                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[_gamePractice valueForKey:GAME]  options:NSJSONWritingPrettyPrinted error:&error];
                                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                                [game_practiceDict setValue:jsonString forKey:DATA];
                            }
                        }
                        else
                        {
                            [defaults setObject:@"0" forKey:[[NSString alloc]initWithFormat:@"template_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:@"0" forKey:DATABASE_PRACTICE_INTERACTIVE_HTML];
                            
                            NSError *error;
                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[_gamePractice valueForKey:GAME]  options:NSJSONWritingPrettyPrinted error:&error];
                            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            [game_practiceDict setValue:jsonString forKey:DATA];
                        }
                        
                        if([_gamePractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_gamePractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_gamePractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:[_gamePractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_gamePractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_gamePractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_gamePractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:[_gamePractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_gamePractice valueForKey:EDGEID]]];
                            [game_practiceDict setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        
                        
                        
                        
                        [self.game_practiceArray addObject:game_practiceDict];
                        game_practiceDict = NULL;
                    }
                }
                
                
                
                NSArray  * sppedRPracticeArr;
                
                if([_practice valueForKey:SREADINGPRACTICE] != NULL && ![[_practice valueForKey:SREADINGPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:SREADINGPRACTICE] isKindOfClass:[NSArray class]]){
                    sppedRPracticeArr = [_practice valueForKey:SREADINGPRACTICE];
                }else if([_practice valueForKey:SREADINGPRACTICE] != NULL && ![[_practice valueForKey:SREADINGPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:SREADINGPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    sppedRPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:SREADINGPRACTICE], nil];
                }else{
                    sppedRPracticeArr = [[NSArray alloc]init];
                }
                
                
                
                // NSArray * sppedRPracticeArr = [_practice valueForKey:SREADINGPRACTICE];
                if(sppedRPracticeArr != NULL && [sppedRPracticeArr count] >0 )
                {
                    for (NSDictionary * _sppedRPractice in sppedRPracticeArr) {
                        speedReading_practiceObject = [[NSMutableDictionary alloc]init];
                        [speedReading_practiceObject setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [speedReading_practiceObject setValue:DATABASE_CATTYPE_SPEEDREADING forKey:CATTYPE];
                        [speedReading_practiceObject setValue:[_sppedRPractice valueForKey:NAME] forKey:NAME];
                        [speedReading_practiceObject setValue:[_sppedRPractice valueForKey:EDGEID] forKey:EDGEID];
                        [speedReading_practiceObject setValue:[_sppedRPractice valueForKey:DATA] forKey:DATA];
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_sppedRPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_sppedRPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_sppedRPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_sppedRPractice valueForKey:EDGEID]]];
                            [speedReading_practiceObject setValue:[_sppedRPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_sppedRPractice valueForKey:EDGEID]]];
                            [speedReading_practiceObject setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_sppedRPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_sppedRPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_sppedRPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_sppedRPractice valueForKey:EDGEID]]];
                            [speedReading_practiceObject setValue:[_sppedRPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_sppedRPractice valueForKey:EDGEID]]];
                            [speedReading_practiceObject setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        [self.speedReading_practiceArray addObject:speedReading_practiceObject];
                        speedReading_practiceObject = NULL;
                    }
                }
                
                
                NSArray  * resourcePracticeArr;
                
                if([_practice valueForKey:RESOURCEPRACTICE] != NULL && ![[_practice valueForKey:RESOURCEPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:RESOURCEPRACTICE] isKindOfClass:[NSArray class]]){
                    resourcePracticeArr = [_practice valueForKey:RESOURCEPRACTICE];
                }else if([_practice valueForKey:RESOURCEPRACTICE] != NULL && ![[_practice valueForKey:RESOURCEPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:RESOURCEPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    resourcePracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:RESOURCEPRACTICE], nil];
                }else{
                    resourcePracticeArr = [[NSArray alloc]init];
                }
                // NSDictionary * _resourcePractice = [_practice valueForKey:RESOURCEPRACTICE];
                
                if(resourcePracticeArr != NULL && [resourcePracticeArr count] >0 )
                {
                    for (NSDictionary * _resourcePractice in resourcePracticeArr) {
                        resource_practiceObject = [[NSMutableDictionary alloc]init];
                        [resource_practiceObject setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [resource_practiceObject setValue:DATABASE_CATTYPE_RESOURSE forKey:CATTYPE];
                        [resource_practiceObject setValue:[_resourcePractice valueForKey:NAME] forKey:NAME];
                        [resource_practiceObject setValue:[_resourcePractice valueForKey:EDGEID] forKey:EDGEID];
                        
                        if([_resourcePractice valueForKey:FLIE_RESOURCE_ARR] != NULL && [_resourcePractice valueForKey:FLIE_RESOURCE_ARR] != (id)[NSNull null] && ![[_resourcePractice valueForKey:FLIE_RESOURCE_ARR]isEqualToString:@""] ){
                            //                    NSError *error;
                            //                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[_resourcePractice valueForKey:FLIE_RESOURCE_ARR]  options:NSJSONWritingPrettyPrinted error:&error];
                            //                        if(jsonData != NULL){
                            //                           NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                            [resource_practiceObject setValue:[_resourcePractice valueForKey:FLIE_RESOURCE_ARR] forKey:DATA];
                            //                        }
                            //                        else
                            //                        {
                            //                           [resource_practiceObject setValue:[_resourcePractice valueForKey:DATA] forKey:DATA];
                            //                        }
                            
                        }
                        else
                        {
                            [resource_practiceObject setValue:[_resourcePractice valueForKey:DATA] forKey:DATA];
                        }
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_resourcePractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_resourcePractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_resourcePractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_resourcePractice valueForKey:EDGEID]]];
                            [resource_practiceObject setValue:[_resourcePractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_resourcePractice valueForKey:EDGEID]]];
                            [resource_practiceObject setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_resourcePractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_resourcePractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_resourcePractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_resourcePractice valueForKey:EDGEID]]];
                            [resource_practiceObject setValue:[_resourcePractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_resourcePractice valueForKey:EDGEID]]];
                            [resource_practiceObject setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        
                        [self.resourse_practiceArray addObject:resource_practiceObject];
                        resource_practiceObject = NULL;
                    }
                }
                
                
                
                
                NSArray  * conversionPracticeArr;
                
                if([_practice valueForKey:CONVERSATIONPRACTICE] != NULL && ![[_practice valueForKey:CONVERSATIONPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:CONVERSATIONPRACTICE] isKindOfClass:[NSArray class]]){
                    conversionPracticeArr = [_practice valueForKey:CONVERSATIONPRACTICE];
                }else if([_practice valueForKey:CONVERSATIONPRACTICE] != NULL && ![[_practice valueForKey:CONVERSATIONPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:CONVERSATIONPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    conversionPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:CONVERSATIONPRACTICE], nil];
                }else{
                    conversionPracticeArr = [[NSArray alloc]init];
                }
                // NSDictionary * _resourcePractice = [_practice valueForKey:RESOURCEPRACTICE];
                
                if(conversionPracticeArr != NULL && [conversionPracticeArr count] >0 )
                {
                    for (NSDictionary * _conversionPractice in conversionPracticeArr) {
                        
                        conversation_practiceObject = [[NSMutableDictionary alloc]init];
                        [conversation_practiceObject setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [conversation_practiceObject setValue:DATABASE_CATTYPE_CONVERSATION forKey:CATTYPE];
                        [conversation_practiceObject setValue:[_conversionPractice valueForKey:NAME] forKey:NAME];
                        [conversation_practiceObject setValue:[_conversionPractice valueForKey:EDGEID] forKey:EDGEID];
                        [conversation_practiceObject setValue:[_conversionPractice valueForKey:DATA] forKey:DATA];
                        
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_conversionPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_conversionPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_conversionPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_conversionPractice valueForKey:EDGEID]]];
                            [conversation_practiceObject setValue:[_conversionPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_conversionPractice valueForKey:EDGEID]]];
                            [conversation_practiceObject setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_conversionPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_conversionPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_conversionPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_conversionPractice valueForKey:EDGEID]]];
                            [conversation_practiceObject setValue:[_conversionPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_conversionPractice valueForKey:EDGEID]]];
                            [conversation_practiceObject setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        
                        [self.conversation_practiceArray addObject:conversation_practiceObject];
                        conversation_practiceObject = NULL;
                    }
                }
                
                
                
                NSArray  * learnosityPracticeArr;
                
                if([_practice valueForKey:LEARNOSITYPRACTICE] != NULL && ![[_practice valueForKey:LEARNOSITYPRACTICE] isEqual:[NSNull null]] &&  [[_practice valueForKey:LEARNOSITYPRACTICE] isKindOfClass:[NSArray class]]){
                    learnosityPracticeArr = [_practice valueForKey:LEARNOSITYPRACTICE];
                }
                else if([_practice valueForKey:LEARNOSITYPRACTICE] != NULL && ![[_practice valueForKey:LEARNOSITYPRACTICE]  isEqual:[NSNull null]] && [[_practice valueForKey:LEARNOSITYPRACTICE]  isKindOfClass:[NSDictionary class]]){
                    learnosityPracticeArr = [[NSArray alloc]initWithObjects:[_practice valueForKey:LEARNOSITYPRACTICE], nil];
                }else{
                    learnosityPracticeArr = [[NSArray alloc]init];
                }
                if(learnosityPracticeArr != NULL && [learnosityPracticeArr count] >0 )
                {
                    for (NSDictionary * _learnosityPractice in learnosityPracticeArr) {
                        
                        learnosity_practiceObject = [[NSMutableDictionary alloc]init];
                        [learnosity_practiceObject setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
                        [learnosity_practiceObject setValue:DATABASE_CATTYPE_LEARNOSITY forKey:CATTYPE];
                        [learnosity_practiceObject setValue:[_learnosityPractice valueForKey:NAME] forKey:NAME];
                        [learnosity_practiceObject setValue:[_learnosityPractice valueForKey:EDGEID] forKey:EDGEID];
                        [learnosity_practiceObject setValue:[_learnosityPractice valueForKey:DATA] forKey:DATA];
                        
                        
                        
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        if([_learnosityPractice valueForKey:DISPLAYSEQUENCE] != NULL && ![[_learnosityPractice valueForKey:DISPLAYSEQUENCE] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_learnosityPractice valueForKey:DISPLAYSEQUENCE] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_learnosityPractice valueForKey:EDGEID]]];
                            [learnosity_practiceObject setValue:[_learnosityPractice valueForKey:DISPLAYSEQUENCE] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        else
                        {
                            [defaults setObject:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:[[NSString alloc]initWithFormat:@"CMS_%@",[_learnosityPractice valueForKey:EDGEID]]];
                            [learnosity_practiceObject setValue:[[NSString alloc]initWithFormat:@"%d",++local_sequence] forKey:DATABASE_PRACTICE_DISPLAYSEQUENCE];
                        }
                        
                        if([_learnosityPractice valueForKey:COMTHUMBNILIMG] != NULL && ![[_learnosityPractice valueForKey:COMTHUMBNILIMG] isEqual:[NSNull null]])
                        {
                            [defaults setObject:[_learnosityPractice valueForKey:COMTHUMBNILIMG] forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_learnosityPractice valueForKey:EDGEID]]];
                            [learnosity_practiceObject setValue:[_learnosityPractice valueForKey:COMTHUMBNILIMG] forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        else
                        {
                            [defaults setObject:@"" forKey:[[NSString alloc]initWithFormat:@"CM_Thumbnil_%@",[_learnosityPractice valueForKey:EDGEID]]];
                            [learnosity_practiceObject setValue:@"" forKey:DATABASE_PRACTICE_COMTHUMBNILIMG];
                        }
                        
                        [defaults synchronize];
                        
                        
                        
                        [self.learnosity_practiceArray addObject:learnosity_practiceObject];
                        learnosity_practiceObject = NULL;
                    }
                }
                
               [self.practiceArray addObject:practiceDict];
                practiceDict = NULL;
            }
        }
    }
    
    return TRUE;
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{
    
    
    elementTag = elementName;
    if ( [elementName isEqualToString:COURSE])
    {
        //NSLog(@"found rootElement");
        courseDict = [[NSMutableDictionary alloc]init];
        CurrentDictionary = COURSE_NO;
        
        
    }
    else if ( [elementName isEqualToString:CATELOG])
    {
        //NSLog(@"%@,found rootElement",elementName);
        catlogDict = [[NSMutableDictionary alloc]init];
        [catlogDict setValue:[courseDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = CATELOG_NO;
        
    }
    else if ( [elementName isEqualToString:ASSISSMENT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        
        
        
        
        
        moduleDict = [[NSMutableDictionary alloc]init];
        [moduleDict setValue:[courseDict valueForKey:EDGEID] forKey:PEDGEID];
        [moduleDict setValue:DATABASE_CATTYPE_ASSISMENT_XML forKey:CATTYPE];
        
        CurrentDictionary = ASSISSMENT_NO;
        
    }
    else if ( [elementName isEqualToString:MODULE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        
        moduleDict = [[NSMutableDictionary alloc]init];
        [moduleDict setValue:[courseDict valueForKey:EDGEID] forKey:PEDGEID];
        [moduleDict setValue:DATABASE_CATTYPE_MODULE forKey:CATTYPE];
        CurrentDictionary = MODULE_NO;
        
    }
    else if ( [elementName isEqualToString:SCHENARIO])
    {
        //NSLog(@"%@,found rootElement",elementName);
        scenarioDict = [[NSMutableDictionary alloc]init];
        
        
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_EDGEID];
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_CEDGEID];
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_NAME];
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_DATA];
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_DESC];
        //        [scenarioDict setValue:EMPTYDATATEXT forKey:DATABASE_SCENARIO_ISCOMP];
        //        [scenarioDict setValue:EMPTYDATAINT forKey:DATABASE_SCENARIO_TIME];
        
        [scenarioDict setValue:[moduleDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = SCHENARIO_NO;
        
    }
    else if ( [elementName isEqualToString:CONCEPT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        conceptDict = [[NSMutableDictionary alloc]init];
        [conceptDict setValue:[scenarioDict valueForKey:EDGEID] forKey:PEDGEID];
        [conceptDict setValue:DATABASE_CATTYPE_CONCEPT_XML forKey:CATTYPE];
        CurrentDictionary = CONCEPT_NO;
        
    }
    else if ( [elementName isEqualToString:ACTIVITY])
    {
        //NSLog(@"%@,found rootElement",elementName);
        activityDict = [[NSMutableDictionary alloc]init];
        [activityDict setValue:[scenarioDict valueForKey:EDGEID] forKey:PEDGEID];
        [activityDict setValue:DATABASE_CATTYPE_ACTIVITY forKey:CATTYPE];
        CurrentDictionary = ACTIVITY_NO;
        
    }
    else if ( [elementName isEqualToString:PRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        practiceDict = [[NSMutableDictionary alloc]init];
        [practiceDict setValue:[scenarioDict valueForKey:EDGEID] forKey:PEDGEID];
        [practiceDict setValue:DATABASE_CATTYPE_PRACTICE forKey:CATTYPE];
        CurrentDictionary = PRACTICE_NO;
        
    }
    else if ( [elementName isEqualToString:SCENARIOPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        scenario_practiceDict = [[NSMutableDictionary alloc]init];
        [scenario_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        [scenario_practiceDict setValue:DATABASE_CATTYPE_SCN_PRACTICE_XML forKey:CATTYPE];
        CurrentDictionary = SCENARIOPRACTICE_NO;
        
    }
    else if ( [elementName isEqualToString:VOCABPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        vocab_practiceDict = [[NSMutableDictionary alloc]init];
        [vocab_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        [vocab_practiceDict setValue:DATABASE_CATTYPE_VOCAB_PRACTICE_XML forKey:CATTYPE];
        CurrentDictionary = VOCABPRACTICE_NO;
        
    }
    else if ( [elementName isEqualToString:MCQPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        mcq_practiceDict = [[NSMutableDictionary alloc]init];
        [mcq_practiceDict setValue:[practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        [mcq_practiceDict setValue:DATABASE_CATTYPE_MCQ_PRACTICE_XML forKey:CATTYPE];
        
        CurrentDictionary = MCQPRACTICE_NO;
        
    }
    else if ( [elementName isEqualToString:GAME])
    {
        //NSLog(@"%@,found rootElement",elementName);
        game_practiceDict = [[NSMutableDictionary alloc]init];
        [game_practiceDict setValue:[moduleDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = GAME_NO;
        
    }
    
    else if ( [elementName isEqualToString:WATCH])
    {
        
        //NSLog(@"%@,found rootElement",elementName);
        watch_scenario_practiceDict = [[NSMutableDictionary alloc]init];
        [watch_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = WATCH_NO;
        
    }
    else if ( [elementName isEqualToString:ENACT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        enact_scenario_practiceDict = [[NSMutableDictionary alloc]init];
        [enact_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = ENACT_NO;
        
    }
    else if ( [elementName isEqualToString:REVIEW])
    {
        review_scenario_practiceDict = [[NSMutableDictionary alloc]init];
        [review_scenario_practiceDict setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = REVIEW_NO;
        //NSLog(@"%@,found rootElement",elementName);
        
    }
    
    else if ( [elementName isEqualToString:WORD])
    {
        vocabWord = [[NSMutableDictionary alloc]init];
        //[vocabWord setValue:[scenario_practiceDict valueForKey:EDGEID] forKey:PEDGEID];
        CurrentDictionary = WORD_NO;
        
        
    }
    else if ( [elementName isEqualToString:UNIT])
    {
        if(CurrentDictionary == WORD_NO )
        {
            vocabWord = [attributeDict copy];
        }
        else if(CurrentDictionary == VOCABPRACTICEXML_NO )
        {
            vocab_practiceXmlDict = [[NSMutableDictionary alloc]init];
            [vocab_practiceXmlDict setValue:practiceUid forKey:EDGEID];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:VOCABID] forKey:VOCABID];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:WORD] forKey:WORD];
            
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_MEANING] forKey:ATTRIBUTE_MEANING];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_PRONOUNCIATION] forKey:ATTRIBUTE_PRONOUNCIATION];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_PARTSOFSPEECH] forKey:ATTRIBUTE_PARTSOFSPEECH];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_ETYMOLOGIES] forKey:ATTRIBUTE_ETYMOLOGIES];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_USAGE] forKey:ATTRIBUTE_USAGE];
            [vocab_practiceXmlDict setValue:[attributeDict valueForKey:ATTRIBUTE_VOCABAUDIOPATH] forKey:ATTRIBUTE_VOCABAUDIOPATH];
            if([attributeDict valueForKey:ATTRIBUTE_VOCABIMAGEPATH] != NULL && ![[attributeDict valueForKey:ATTRIBUTE_VOCABIMAGEPATH] isEqual:[NSNull null]])
            {
               [vocab_practiceXmlDict setValue:[attributeDict valueForKey:DATABASE_VOCABWORD_IMAGEPATH] forKey:DATABASE_VOCABWORD_IMAGEPATH];
            }
            else
            {
                [vocab_practiceXmlDict setValue:[attributeDict valueForKey:DATABASE_VOCABWORD_IMAGEPATH] forKey:DATABASE_VOCABWORD_IMAGEPATH];
            
            }
            
            
        }
        else
        {
            unitDict = [[NSMutableDictionary alloc]init];
            [unitDict setValue:idealTime forKey:ATTRIBUTE_IDEALTIME];
            NSInteger lunitCount = [unitCount integerValue];
            unitCount = [[NSString alloc] initWithFormat:@"%ld",(long)++lunitCount];
            NSString *uinitId =[[NSString alloc] initWithFormat:@"unit%d_%@_%f",CouterID++,unitCount,[[NSDate date] timeIntervalSince1970 ]*1000];
            [unitDict setValue:uinitId forKey:EDGEID];
            [unitDict setValue:practiceUid forKey:PEDGEID];
            CurrentDictionary = UNIT_NO;
        }
        
    }
    else if ( [elementName isEqualToString:CONVERSATION])
    {
        idealTime = [attributeDict valueForKey:ATTRIBUTE_IDEALTIME];
    }
    else if ( [elementName isEqualToString:QUESTION])
    {
        QuestionDict = [[NSMutableDictionary alloc]init];
        NSInteger lunitCount = [unitCount integerValue];
        NSString *LocalUnitCount = [[NSString alloc] initWithFormat:@"%ld",(long)++lunitCount];
        NSString *uinitId =[[NSString alloc] initWithFormat:@"ques%d_%@_%f",CouterID++,LocalUnitCount,[[NSDate date] timeIntervalSince1970 ]*1000];
        [QuestionDict setValue:uinitId forKey:EDGEID];
        
        [QuestionDict setValue:[unitDict valueForKey:EDGEID] forKey:PEDGEID];
        
        
        CurrentDictionary = QUESTION_NO;
    }
    else if ( [elementName isEqualToString:PLAY])
    {
        
    }
    else if ( [elementName isEqualToString:TAG])
    {
        
    }
    else if ( [elementName isEqualToString:TEXT])
    {
        
    }
    else if ( [elementName isEqualToString:SEGMENT])
    {
        segmenttextDict = [[NSMutableDictionary alloc]init];
        if(CurrentDictionary == ANSWER_NO)
        {
            NSInteger lunitCount = [unitCount integerValue];
            NSString *LocalunitCount = [[NSString alloc] initWithFormat:@"%ld",(long)++lunitCount];
            NSString *uinitId =[[NSString alloc] initWithFormat:@"txtSeg%d_%@_%f",CouterID++,LocalunitCount,[[NSDate date] timeIntervalSince1970 ]*1000];
            
            
            [segmenttextDict setValue:uinitId forKey:EDGEID];
            [segmenttextDict setValue:[ansDict valueForKey:EDGEID] forKey:PEDGEID];
        }
        else if (CurrentDictionary == QUESTION_NO)
        {
            NSInteger lunitCount = [unitCount integerValue];
            NSString *LocalunitCount = [[NSString alloc] initWithFormat:@"%ld",(long)++lunitCount];
            NSString *uinitId =[[NSString alloc] initWithFormat:@"txtSeg%d_%@_%f",CouterID++,LocalunitCount,[[NSDate date] timeIntervalSince1970 ]*1000];
            
            
            [segmenttextDict setValue:uinitId forKey:EDGEID];
            [segmenttextDict setValue:[QuestionDict valueForKey:EDGEID] forKey:PEDGEID];
        }
        
        CurrentDictionary = SEGMENT_NO;
    }
    else if ( [elementName isEqualToString:SIMPLE])
    {
        
    }
    else if ( [elementName isEqualToString:CLICK])
    {
        
    }
    else if ( [elementName isEqualToString:ANSWER])
    {
        ansDict = [[NSMutableDictionary alloc]init];
        NSInteger lunitCount = [unitCount integerValue];
        NSString *LocalunitCount = [[NSString alloc] initWithFormat:@"%ld",(long)++lunitCount];
        NSString *uinitId =[[NSString alloc] initWithFormat:@"answer%d_%@_%f",CouterID++,LocalunitCount,[[NSDate date] timeIntervalSince1970 ]*1000];
        [ansDict setValue:uinitId forKey:EDGEID];
        
        [ansDict setValue:[unitDict valueForKey:EDGEID] forKey:PEDGEID];
        
        CurrentDictionary = ANSWER_NO;
    }
    else if ( [elementName isEqualToString:VOCABULARYXMLTAG])
    {
        
        CurrentDictionary = VOCABPRACTICEXML_NO;
    }
    
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementTag isEqualToString:DESCRIPTION])
        NSLog(@"Character ::%@",completeData);
    
    NSString *trimmedString = [completeData stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if((completeData != nil && ([elementTag isEqualToString:EDGEID] || [elementTag isEqualToString:NAME] || [elementTag isEqualToString:DATA] || [elementTag isEqualToString:DESCRIPTION] || [elementTag isEqualToString:IRTRACK]||[elementTag isEqualToString:TAG]|| [elementTag isEqualToString:SIMPLE]|| [elementTag isEqualToString:VALUE]|| [elementTag isEqualToString:VOCABID]|| [elementTag isEqualToString:WORD]|| [elementTag isEqualToString:ZIPURL]||[elementTag isEqualToString:VERSION]))||[elementTag isEqualToString:DURATION])
    {
        
        [(NSMutableDictionary *)[self getCurrentDict:CurrentDictionary] setValue:trimmedString forKey:elementTag ];
        elementTag = @"";
    }
    else if([elementTag isEqualToString:PLAY])
    {
        if(QuestionDict != NULL)
        {
            [QuestionDict setValue:trimmedString forKey:elementTag ];
        }
        else if(ansDict != NULL)
        {
            [ansDict setValue:trimmedString forKey:elementTag ];
            
            
        }
        elementTag = @"";
    }
    
    completeData =  nil;
    if ( [elementName isEqualToString:COURSE])
    {
        [self.courseArray addObject:courseDict];
        courseDict = NULL;
        
    }
    else if ( [elementName isEqualToString:CATELOG])
    {
        [self.catlogArray addObject:catlogDict];
        catlogDict = NULL;
    }
    else if ( [elementName isEqualToString:ASSISSMENT])
    {
        [self.moduleArray addObject:moduleDict];
        moduleDict = NULL;
    }
    else if ( [elementName isEqualToString:MODULE])
    {
        [self.moduleArray addObject:moduleDict];
        moduleDict = NULL;
    }
    else if ( [elementName isEqualToString:SCHENARIO])
    {
        [self.scenarioArray addObject:scenarioDict];
        scenarioDict = NULL;
    }
    else if ( [elementName isEqualToString:CONCEPT])
    {
        [self.conceptArray addObject:conceptDict];
        conceptDict = NULL;
    }
    else if ( [elementName isEqualToString:ACTIVITY])
    {
        [self.activityArray addObject:activityDict];
        activityDict = NULL;
    }
    else if ( [elementName isEqualToString:PRACTICE])
    {
        [self.practiceArray addObject:practiceDict];
        practiceDict = NULL;
        
    }
    else if ( [elementName isEqualToString:SCENARIOPRACTICE])
    {
        [self.scenario_practiceArray addObject:scenario_practiceDict];
        scenario_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:VOCABPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.vocab_practiceArray addObject:vocab_practiceDict];
        vocab_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:MCQPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.mcq_practiceArray addObject:mcq_practiceDict];
        mcq_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:GAME])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.game_practiceArray addObject:game_practiceDict];
        game_practiceDict = NULL;
        //return;
    }
    
    else if ( [elementName isEqualToString:SREADINGPRACTICE])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.speedReading_practiceArray addObject:speedReading_practiceObject];
        speedReading_practiceObject = NULL;
        //return;
    }
    
    else if ( [elementName isEqualToString:WATCH])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.watch_scenario_practiceArray addObject:watch_scenario_practiceDict];
        watch_scenario_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:ENACT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.enact_scenario_practiceArray addObject:enact_scenario_practiceDict];
        enact_scenario_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:REVIEW])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.review_scenario_practiceArray addObject:review_scenario_practiceDict];
        review_scenario_practiceDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:WORD])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.vocab_WordArray addObject:vocabWord];
        vocabWord = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:UNIT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        if(unitDict != NULL)
        {
            [self.unitArray addObject:unitDict];
            unitDict = NULL;
        }
        else if(vocab_practiceXmlDict != NULL)
        {
            [self.vocabularyArr addObject:vocab_practiceXmlDict];
            vocab_practiceXmlDict = NULL;
        }
        //return;
    }
    else if ( [elementName isEqualToString:QUESTION])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.questionArray addObject:QuestionDict];
        QuestionDict = NULL;
        //return;
    }
    else if ( [elementName isEqualToString:ANSWER])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.ansArray addObject:ansDict];
        ansDict = NULL;
        //return;
    }else if ( [elementName isEqualToString:VOCABULARYXMLTAG])
    {
        //NSLog(@"%@,found rootElement",elementName);
        
        //return;
    }
    else if ( [elementName isEqualToString:SEGMENT])
    {
        //NSLog(@"%@,found rootElement",elementName);
        [self.segmenttextArray addObject:segmenttextDict];
        segmenttextDict = NULL;
        //return;
    }
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(completeData == nil)
    {
        completeData =  [[NSMutableString alloc]init];
        
    }
    [completeData appendString:string];
    
}

-(NSMutableDictionary *)getCurrentDict:(int)dict_No
{
    
    switch (dict_No) {
        case 1:
            return courseDict;
        case 2:
            return catlogDict;
        case 3:
            return moduleDict;
        case 4:
            return moduleDict;
        case 5:
            return scenarioDict;
        case 6:
            return conceptDict;
        case 7:
            return activityDict;
        case 8:
            return practiceDict;
        case 9:
            return scenario_practiceDict;
        case 10:
            return vocab_practiceDict;
        case 11:
            return mcq_practiceDict;
        case 12:
            return game_practiceDict;
        case 13:
            return watch_scenario_practiceDict;
        case 14:
            return enact_scenario_practiceDict;
        case 15:
            return review_scenario_practiceDict;
        case 16:
            return NULL;
        case 17:
            return unitDict;
        case 18:
            return QuestionDict;
        case 19:
            return ansDict;
        case 20:
            return segmenttextDict;
        case 21:
            return vocab_practiceXmlDict;
        default:
            return NULL;
            break;
    }
}





-(BOOL)parseConceptXML:(NSString *)xmlpath :(NSString *)count :(NSString *)uid
{
    
    CouterID=0;
    self.unitArray = [[NSMutableArray alloc]init];
    self.questionArray = [[NSMutableArray alloc]init];
    self.ansArray = [[NSMutableArray alloc]init];
    self.segmenttextArray = [[NSMutableArray alloc]init];
    self.vocabularyArr = [[NSMutableArray alloc]init];
    
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlpath];
    xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    unitCount = count;
    practiceUid = uid;
    [xmlParser setDelegate:self];
    [xmlParser parse];
    
    return TRUE;
}

@end
