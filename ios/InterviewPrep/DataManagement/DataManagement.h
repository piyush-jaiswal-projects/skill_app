//
//  DataManagement.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Database.h"
#import "XMLDictionary.h"
#import "Language.h"


@interface DataManagement : NSObject
{
    
    @private
        Database * dataObj;
        Language * languageObj;
        //NSString * courseCode;   
}


@property NSInteger unitCount;


-(DataManagement *)init:(NSObject *)obj CourseCode:(NSString *)code;



#pragma mark - DELETE DATA API's

    -(BOOL)deleteTestData;



#pragma mark -    SET RAW DATA API's

    -(BOOL)fillCourseDatabase:(XMLDictionary *)xml;
    -(BOOL)fillVocabWordDatabase:(XMLDictionary *)xml;
    -(void)vocabpracticeXml:(XMLDictionary *)xmlObj;
    -(void)fillConceptPracticeXmlDatabase:(XMLDictionary *)xmlObj catType:(NSString *)catType;




#pragma mark -    SET API's

    -(BOOL)setCourseCode:(NSString *)_courseCode;
    -(BOOL)setAppType:(NSString *)_appType;
    -(BOOL)setUserInfo:(NSMutableDictionary *)userDic;
    -(BOOL)setIRPullData :(NSDictionary *)IRData;
    -(BOOL)setPracticeOrAssissmentData :(NSDictionary *)strData edgeId:(NSString * )edgeId :(NSString * )pack;
    -(BOOL)setTrackSyncTime:(NSString *)syncTime;
    -(BOOL)setTracktableData:(NSMutableDictionary *)data;
    -(BOOL)setTracktableDataArr:(NSMutableArray *)dataArr;
    -(BOOL)setUpdatedScnariopractice:(NSMutableDictionary *)dictionary;
    -(BOOL)setVocabWord:(NSDictionary *)vocabWordData;
    -(BOOL)setUpdateScore:(float)score :(NSString *)uid :(NSString *)table;
    -(BOOL)setImage:(int)isLocal;
    -(BOOL)setUpdateVersion:(int)version;
    -(BOOL)updateAllComponant:(NSArray*)data;
    -(BOOL)updateComponant:(NSString*)edgeId;
    -(BOOL)deleteAllTrackingData;
   -(BOOL)updateCoursePackData:(NSArray *)coursepackArr;
    -(BOOL)updateCoursePack:(NSArray *)coursePack;
    -(NSDictionary *)getGSELevel :(NSString *)code;
   -(NSArray *)getChaptersDataWithSkill:(NSString *)coursePack Topic :(NSString *)topicId :(NSString *)skillId;
   -(NSDictionary *)getTopicData:(NSString *)topicId: (NSString *)courseEdgeId :(NSString *)chapterId :(NSString *)assessment_type;
-(NSDictionary *)getTopicDataOnly : (NSString *)topicId;
-(BOOL)updateUser:(NSString *)user_id :(NSString *)token :(NSString *)profilePic;
-(NSMutableArray *)getAllTrackDataBasedOnEdgeId :(NSString *)edgeId;








#pragma mark -    GET API's

-(NSMutableArray *)getWeekSpentData;
-(NSDictionary *)getAssessmentObject:(NSString *)edgeId;
-(NSDictionary *)getMCQObject:(NSString *)edgeId;
-(NSMutableArray *)getAllCoursePack;
-(NSString *)getCourseName;
-(NSString *)getCurrentTime;
-(NSDictionary *)getUserInfo;
-(BOOL)isShowProfile:(NSString *)coursePack;
-(NSMutableDictionary *)getCatelogData:(NSString *)course_pack Topic:(NSString *)topicId;
-(NSString *)getAssessmnetMCQData:(int)EdgeId :(int)type;
-(NSString *)getScenariopracticeData:(NSInteger )data :(NSInteger )type :(NSString *)coursePack;

-(NSMutableDictionary *)getScenariopracticArr:(NSInteger )data :(NSInteger )type :(NSString *)coursePack;
-(NSMutableArray *)getChapterDetail:(NSInteger )data;
-(NSString *)getfolderPath:(int)EdgeId :(NSString *)Type;
-(NSString *)getZipfileName:(NSInteger) EdgeId : (NSString *)Type;
-(NSMutableArray *) getScenarioArray: (NSString *)CatContEdgeId;
-(NSMutableArray *) getpracticeArray: (NSString *)CatContEdgeId : (NSString *)catType;
-(NSDictionary *) getConceptXMLpath: (NSString *)EdgeId : (NSString *)catType;
-(NSDictionary *) getPracticeXMLpath: (NSString *)EdgeId :(NSString *)catType;
-(NSMutableArray *)getVocabWords:(NSString *)pracUid;
-(NSMutableArray *)getVocabWordsSlider:(NSString *)pracUid;
-(NSMutableArray*)getAssessMCQData;
-(NSMutableArray*)getAssessMCQDataOld;
-(BOOL)isAssessMCQData :(NSString *)edge_id;
-(NSMutableArray *)getAllTrackData :(int)type;
-(BOOL)updateTrackComponantCompletion:(NSDictionary *)dict;
-(NSString*)getPathWithoutRoot:(NSString *)file;
-(NSMutableDictionary *)getWordData:(NSString *)uid;
-(NSString *)getConceptFilePath:(NSInteger)uid;
-(NSMutableDictionary *)getScnpracticeData:(NSInteger)scnPracId : (NSString *)practiceType :(NSInteger)scenarioId;
-(NSString *)getSecnarioInstruction:(NSInteger)scnPracId :(NSString *)coursepack;
-(int)getIdealTime:(NSInteger )conceptId;
-(NSMutableArray *)getCatelogDataForIr;
-(NSMutableArray *)getScnArrayForIr:(NSString *)strUid;
-(NSInteger)getMaxScore:(NSString *)uID :(NSString *)type;
-(NSMutableArray *)getCAPArray:(NSString *)uID :(NSString *)type;
-(NSMutableArray *)getSCNPracArr:(NSString *)uID :(NSString *)type;
-(NSMutableArray *)getVocabArray:(NSString *)uID;
-(NSDictionary *)getVocabWord:(NSString *)uID;
-(NSString *)getDashboardData:(NSString *)coursePack;
-(NSMutableDictionary *)getGameDashboardData:(NSString *)coursePack Topic :(NSString *)topicId;
-(NSMutableArray *)getAllTopicData;
-(NSDictionary *)getCurrentSession:(NSString *)val;
-(NSMutableDictionary *)getPracticeMCQList;
-(NSString *)getLastpracticeTextUid;
-(NSString *)getCourseXml;
-(NSString *)getAssessmnetMCQHTMLPath:(int)EdgeId :(int)type;
-(NSString *)getScenarioName:(int)scnUid;
-(NSArray *)getAllCourseCode;
-(NSString *)getCurrentCourseId;
-(NSMutableArray *)getCourseArr;
//-(NSMutableArray *)getAllCoursePack;
-(NSArray *)getAllCourseCodeWithPack :(NSString *)pack_code :(NSString * )user_level;
-(NSString *)getCurrentCoursepack;
-(NSArray*)getGameArr:(NSString *)uid;
-(NSDictionary*)getChapterMCQ:(int)scnUid;
//-(NSMutableArray *)getAllCourses :(NSString )* coursePack;
-(NSMutableDictionary *)getDashboardDataWithType;
-(NSDictionary *)getChapterData :(NSString *)edgeId;
-(int)getAttemptCounter;

-(BOOL)isPreregisteredUser;
-(NSDictionary *)getQuizOrAssementData:(NSString *)uid :(int)CatType;
-(NSArray *)getCourseData:(NSString *)courseCode;
//-(NSArray *)getAllCourseCodeWithoutPack :(NSString *)pack_code :(int)user_level;



#pragma mark -    SERVICE  API's


-(void)initialise;
-(BOOL)isCourseExist:(NSString *)course_edgeId;
-(BOOL)coursePackExistorNot:(NSString *)_coursePack;
-(BOOL)deleteCourseCode:(NSString *)deleteCode deleteDirectory:(BOOL)isDelete;
-(BOOL)deleteScenario:(NSString *)edgeId deleteDirectory:(BOOL)isDelete deleteZip:(BOOL)_isDelete;
-(void)cleanUserDatabase;


#pragma mark -    COINS Related Functions

-(BOOL)insertIndividualCoins:(NSDictionary *) obj;
-(BOOL)insertCoins:(NSArray *)dataArr;
-(NSArray*)getCoinsArr;
-(BOOL)deleteCoinsData;
-(void)updateUserCoins:(NSDictionary *) obj;
-(NSArray *)getComponantCoins:(NSString *)edge_id;





-(NSMutableArray *)getAllDownloadedCoursesWithChapter:(NSString *)contentPack;
-(NSMutableArray *)getChapterAndAssessmentList;


-(NSMutableArray *)getlevelArrayFromCourses:(NSString *)contentPack;
-(BOOL)updateUserProfile:(NSString *)name :(NSString *)password;






@end
