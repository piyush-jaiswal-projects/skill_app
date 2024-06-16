//
//  Engine.h
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Network.h"
#import "DataManagement.h"
#import "Utility.h"
#import "XMLDictionary.h"
#import "FileLogger.h"
//#import <FacebookSDK/FacebookSDK.h>

@interface Engine : NSObject
{
    
    @private
        BOOL isDataExist;
        NSString * downloadingModuleID;
        NSString * courseCode;
        NSString * appType;
        NSString * licenseKey;
    
}
//@property NSString * user_id;
@property Network * networkObj;
@property DataManagement * dataMngntObj;
//@property NSString * tokenID;

-(Engine *)init:(NSObject *)LangObj courseCode:(NSString *)code;


#pragma mark  DATABASE--------------------------- GET FUNCTION
-(BOOL)isNetworkAvailbale;
-(NSString *)getCourseName;
-(BOOL)getHonorCode;
-(BOOL)isShowProfile:(NSString *)coursePack;
-(NSString *)getCatelogData :(NSString *)course_pack ;
-(NSDictionary *)getCatelogDataObject :(NSString *)course_pack Topic :(NSString *)topicId;
-(NSString *)getAssessmnetMCQData:(int)EdgeId :(int)type;
-(NSString *)getScenariopracticeData:(NSInteger )data :(NSInteger )type :(NSString *)coursePack;
//-(BOOL)syncVisitedData:(NSString * )tokenId;
-(NSMutableArray *)getChapterDetail:(NSInteger )data;
-(NSString *)getZipfileName:(int)EdgeId : (NSString *)Type;
-(NSDictionary *)getUserInfo;
-(NSString *)getFileData:(NSInteger)uId;
-(NSMutableDictionary *)getWordData:(NSString *)uid;
-(NSMutableDictionary *)getScnpracticeData:(NSInteger)scnPracId : (NSString *)practiceType : (NSInteger )scnUid;
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
-(NSString *)getPracticeMCQList;
-(NSString *)getLastpracticeTextUid;
-(NSString *)getCourseXml;
-(NSString *)getAssessmnetMCQHTMLPath:(int)EdgeId :(int)type;
-(NSMutableDictionary *)getGameDashboardData:(NSString *)coursePack Topic :(NSString *)topicId;
-(NSMutableArray *)getAllTopicData;

-(NSString *)getScenarioName:(int)scnUid;
-(NSArray *)getAllCourseCode;
-(NSString *)getCurrentCourseId;
-(NSDictionary *)getCurrentSession:(NSString *)val;
-(NSMutableArray *)getVocabWords:(NSString *)pracUid;
-(NSMutableArray *)getVocabWordsSlider:(NSString *)pracUid;
-(BOOL)isCourseExist:(NSString *)course_edgeId;
-(BOOL)coursePackExistorNot:(NSString *)_coursePack;
-(NSMutableArray *)getAllCoursePack;
-(NSArray *)getAllCourseCodeWithPack :(NSString *)pack_code :(NSString *)user_level;
-(NSString *)getCurrentCoursepack;
//-(NSMutableDictionary *)getWord;
-(NSArray*)getGameArr:(NSString *)uid;
//-(NSDictionary *)getAssessmentReportUrl:(NSString *)tokenId;
-(BOOL)isAssessMCQData :(NSString *)edge_id;
-(NSDictionary*)getChapterMCQ:(int)scnUid;
-(NSMutableArray *)getWeekSpentData;
-(NSMutableDictionary *)getDashboardDataWithType;
-(NSDictionary *)getChapterData :(NSString *)edgeId;
-(int)getAttemptCounter;
-(BOOL)isPreregisteredUser;
-(NSDictionary *)getGSELevel :(NSString *)code;
-(NSArray *)getChaptersDataWithSkill:(NSString *)coursePack Topic :(NSString *)topicId :(NSString *)skillId;
-(NSDictionary *)getTopicData : (NSString *)topicId : (NSString *)courseEdgeId :(NSString *)chapterId :(NSString *)assessment_type;
-(NSDictionary *)getTopicDataOnly : (NSString *)topicId;
-(NSMutableDictionary *)getScenarioList:(NSString *)course_pack Topic:(NSString *) topicId;
-(NSDictionary *)getQuizOrAssementData:(NSString *)uid :(int)CatType;


#pragma mark DATABASE------------------------------ SET FUNCTION
-(void)setModuleId :(NSString *)uid;
-(BOOL)setHonorCode:(NSDictionary *)honorDic;
-(BOOL)setPracticeOrAssissmentData :(NSDictionary*)strData edgeId:(NSString * )edgeId :(NSString * )pack ;
-(BOOL)setTracktableData:(NSMutableDictionary *)data;
-(BOOL)setUpdatedScnariopractice:(NSMutableDictionary *)dictionary;
-(BOOL)setVocabWord:(NSDictionary *)vocabWordData;
-(BOOL)setUpdateScore:(float)score :(NSString *)uid :(NSString *)table;
-(BOOL)setImageFlag;
-(BOOL)setCourseCode:(NSString *)_courseCode;
-(BOOL)setAppType:(NSString *)_appType;
-(BOOL)setlincenceKey:(NSString *)_licenseKey;
-(BOOL)updateComponant:(NSString *)edgeId;
-(BOOL)updateCoursePackData :(NSArray *)packArr;
 -(BOOL)setUserInfo:(NSMutableDictionary *)userDic;
-(BOOL)updateUser:(NSString *)user_id :(NSString *)token :(NSString *)profilePic;



#pragma mark - NETWORK FUNCTION
//-(BOOL)getEventList;
//-(BOOL)cancelEvent:(NSString *)edgeId;
//-(BOOL)joinEvent:(NSString *)edgeId;

#pragma mark - LANGUAGE FUNCTION
#pragma mark - ZIPEXTRACT FUNCTION
#pragma mark - LOGGER FUNCTION




#pragma mark - SERVICE FUNCTION

-(BOOL)DeleteCourseCode:(NSString *)deleteCode deleteDirectory:(BOOL)isDelete;
-(BOOL)deleteScenario:(NSString *)edgeId deleteDirectory:(BOOL)isDelete deleteZip:(BOOL)_isDelete;



#pragma mark - DATABASE_NETWORK FUNCTION

//-(NSMutableDictionary *)checkCourseCodeDirctoryExistonServer:(NSString*)_courseCode licence_key:(NSString *)key;
//-(NSMutableDictionary *)getCoursePackInfo:(NSString*)coursePack;
//-(NSMutableDictionary *)getExistCoursePackInfo:(NSString*)coursePack :(NSString *)tokenId;

-(NSMutableDictionary *)getChapterDetail:(NSString*)_courseCode edge_Id:(NSString *)edgeId;
-(BOOL) checkAndDownloadVocabulary;   // course download and encryptand parse
-(void)downloadZipFileAndParseData:(NSString *)fileName uID:(NSString * )uid; // for Chapter only Download
-(void)EncryptAndParse :(NSString *)fileName; // for encrypt and parse of Chapter
-(void)fromBaseEncryptAndParse :(NSString *)filePath :(NSString *)edge_id;
-(NSDictionary *)uploadAudio:(NSString *)path :(NSString *)WordValue :(NSString *)user_id :(NSString *)token_id;
//-(NSDictionary *)SANAuploadAudio:(NSString *)path :(NSString *)WordValue :(NSString *)tokenId;
-(NSMutableDictionary *)getScenariopracticArr:(NSInteger )data :(NSInteger )type :(NSString *)coursePack;

//-(BOOL)uploadImageToAduroFromLocal;
//-(BOOL)uploadZipToAduroFromLocal;

-(BOOL)cancelDownload;

-(BOOL)DownloadNewCourseCode:(NSDictionary *)xmlData;
-(BOOL)parseChapComponent:(NSDictionary *)xmlData;
-(NSString *) getIMEINumber;
//-(BOOL)setDeviceToken:(NSDictionary * )dict;
-(NSDictionary *)getAssessmentObject:(NSString *)edgeId;
-(NSDictionary *)getMCQObject:(NSString *)edgeId;



-(BOOL)insertIndividualCoins:(NSDictionary *) obj;
-(BOOL)insertCoins:(NSArray *)dataArr;



-(NSMutableArray *)getAllDownloadedCoursesWithChapters:(NSString *)contentPack;
-(NSMutableArray *)getChapterAndAssessmentList;
-(NSMutableArray *)getlevelArrayFromCourses :(NSString * )contentPack;
-(BOOL)updateUserProfile:(NSString *)name :(NSString *)password;



@end
