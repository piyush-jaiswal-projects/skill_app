//
//  XMLDictionary.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 20/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLDictionary : NSObject <NSXMLParserDelegate>
{
    NSXMLParser *xmlParser;
    NSMutableString * completeData;
    NSMutableDictionary *courseDict;
        NSMutableDictionary *catlogDict;
            NSMutableDictionary *assessmentDict;
            NSMutableDictionary *moduleDict;
                NSMutableDictionary *scenarioDict;
                    NSMutableDictionary *conceptDict;
                    NSMutableDictionary *activityDict;
                    NSMutableDictionary *practiceDict;
    
                        NSMutableDictionary *scenario_practiceDict;
                            NSMutableDictionary *watch_scenario_practiceDict;
                            NSMutableDictionary *enact_scenario_practiceDict;
                            NSMutableDictionary *review_scenario_practiceDict;
                        NSMutableDictionary *vocab_practiceDict;
                        NSMutableDictionary *mcq_practiceDict;
    
    
    
                            NSMutableDictionary *game_practiceDict;
                            NSMutableDictionary *speedReading_practiceObject;
                            NSMutableDictionary *resource_practiceObject;
                            NSMutableDictionary *conversation_practiceObject;
                            NSMutableDictionary *learnosity_practiceObject;
    NSMutableDictionary *vocabWord;
    
    NSMutableDictionary * unitDict;
    NSMutableDictionary * QuestionDict;
    NSMutableDictionary * ansDict;
    NSMutableDictionary * segmenttextDict;
    NSMutableDictionary *vocab_practiceXmlDict;
    
    
    
    
    int CurrentDictionary;
    int CouterID;
    
    NSString * elementTag;
    int level;
    
    NSString * idealTime;
   
    NSString * unitCount;
    NSString * practiceUid;
    NSString * CourseCode;
    
    
}

@property NSMutableArray *courseArray;

@property NSMutableArray *unitArray;
@property NSMutableArray *questionArray;
@property NSMutableArray *ansArray;
@property NSMutableArray *segmenttextArray;

@property NSMutableArray *vocabularyArr;




@property NSMutableArray *catlogArray;
@property NSMutableArray *assessmentArray;
@property NSMutableArray *moduleArray;
@property NSMutableArray *scenarioArray;
@property NSMutableArray *conceptArray;
@property NSMutableArray *activityArray;
@property NSMutableArray *practiceArray;

@property NSMutableArray *scenario_practiceArray;
@property NSMutableArray *watch_scenario_practiceArray;
@property NSMutableArray *enact_scenario_practiceArray;
@property NSMutableArray *review_scenario_practiceArray;
@property NSMutableArray *vocab_practiceArray;
@property NSMutableArray *vocab_practiceXmlArray;


@property NSMutableArray *mcq_practiceArray;
@property NSMutableArray *game_practiceArray;
 @property NSMutableArray *speedReading_practiceArray;
@property NSMutableArray * resourse_practiceArray;
@property NSMutableArray * conversation_practiceArray;
@property NSMutableArray * learnosity_practiceArray;
@property NSMutableArray *vocab_WordArray;

-(XMLDictionary * )init :(NSString *)CourseCode;

-(BOOL)parseXML:(NSString *)xmlpath;
-(BOOL)parseConceptXML:(NSString *)xmlpath :(NSString *)count :(NSString *)uid;
-(BOOL)parseVocabXML;

-(BOOL)parseScenarioJSON : (NSDictionary *) jsonData;
-(BOOL)parseCourseJSON : (NSDictionary *) jsonData;




@end
