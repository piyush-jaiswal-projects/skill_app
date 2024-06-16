//
//  Engine.m
//  InterviewPrep
//
//  Created by liq-lap-mac-02 on 16/11/14.
//  Copyright (c) 2014 Liqvid. All rights reserved.
//

#import "Engine.h"
#import "URL_Macro.h"
#import "GlobalHeader.h"
#import "SSZipArchive.h"
#import "tablesMacro.h"
#import "FileLogger.h"
#import "UIKit/UIKit.h"
#import "AppDelegate.h"


@interface Engine() <SSZipArchiveDelegate>
{
    AppDelegate * appDelegate;
}

@end


@implementation Engine





-(Engine *)init:(NSObject *)obj courseCode:(NSString *)code
{
    
    self.dataMngntObj = [[DataManagement alloc] init:obj CourseCode:code];
    self.networkObj = [[Network alloc] init:code];
    courseCode = code;
    appDelegate = APP_DELEGATE;
    return self;
}

-(BOOL)updateComponant:(NSString *)edgeId
{
    return [self.dataMngntObj updateComponant:edgeId];
}

-(BOOL)setCourseCode:(NSString *)_courseCode
{
    courseCode = _courseCode;
    [self.dataMngntObj setCourseCode:courseCode];
    [self.networkObj setCourseCode:courseCode];
    return TRUE;
}
-(BOOL)setAppType:(NSString *)_appType
{
    appType = _appType;
    [self.dataMngntObj setAppType:_appType];
    return TRUE;
}

-(BOOL)setlincenceKey:(NSString *)_licenseKey
{
    licenseKey = _licenseKey;
    return TRUE;
}

//-(NSMutableDictionary *)getWord
//{
//    [Logger logAduro:@"Engine : start Function getWord" ];
//
//
//
//    Utility *utility = [[Utility alloc]init];
//    NSMutableDictionary *uiResponse = [[NSMutableDictionary alloc] init];
//    [uiResponse setValue:@"SUCCESS" forKey:@"STATUS"];
//     [uiResponse setValue:@"107" forKey:@"id"];
//    [uiResponse setValue:@"Thr-o-ttle" forKey:@"pronunciation"];
//     [uiResponse setValue:@"A device controlling the flow of fuel or power to an engine" forKey:@"meaning"];
//     [uiResponse setValue:@"Throttle" forKey:@"word"];
//     [uiResponse setValue:@"" forKey:@"word_date"];
//
//
//
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//
//    [reqObj setValue:JSON_GETWORD forKey:JSON_DECREE ];
//
//    [Logger log:@"Engine : Request Data to Server :%@",reqObj];
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqObj options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
//    {
//
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//
//        NSString * str = [resEncryptData stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
//        str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
//        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//
//
//        NSData *jsonRawData = [str dataUsingEncoding:NSUTF8StringEncoding];
//
//
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        [Logger log:@"Decrypt respose from Server :%@",temp];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            return [[temp valueForKey:@"retVal"] valueForKey:@"wordInfo"];
//
//
//        }
//    }
//    [Logger logAduro:@"Engine : end Function getWord" ];
//
//    return uiResponse;
//
//}

-(BOOL)updateCoursePackData :(NSArray *)packArr
{
    return [self.dataMngntObj updateCoursePackData:packArr];
}
 -(BOOL)setUserInfo:(NSMutableDictionary *)userDic
{
    return [self.dataMngntObj setUserInfo:userDic];
}

-(BOOL) checkAndDownloadVocabulary
{
    
    
    [Logger logAduro:@"Engine  : sart Function checkAndDownloadVocabulary" ];
    
    Utility *utility = [[Utility alloc]init:courseCode];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    NSString * vocabUrl = [[NSString alloc]initWithFormat:@"%@%@/%@",AUDRO_ZIP_URL,courseCode,VOCABLARYZIPNAME];
    [self.networkObj downloadZip:vocabUrl name:VOCABLARYZIPNAME path:dataPath];
    [self Unzipping:VOCABLARYZIPNAME path:dataPath];
    NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:courseCode];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:VOCABLARYFOLDERNAME];
    dataPath1 = [dataPath1 stringByAppendingPathComponent:VOCABLARYWORDFOLDERNAME];
    [utility fileEncryptallVocabFile:dataPath1];
    XMLDictionary * xmlObj = [[XMLDictionary alloc]init:courseCode];
    [xmlObj parseVocabXML];
    [self.dataMngntObj fillVocabWordDatabase:xmlObj];
    [Logger logAduro:@"Engine  : end Function checkAndDownloadVocabulary" ];
    
    return true;
}





- (void)Unzipping:(NSString *)zipName path:(NSString *)path
{
    [Logger logAduro:@"Engine  : start Function Unzipping" ];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,zipName];
    NSString *zipPath = filePath;
    
    [SSZipArchive unzipFileAtPath:zipPath toDestination:path delegate:self];
    [Logger logAduro:@"Engine  : end Function Unzipping"];
    
}




-(BOOL)isShowProfile:(NSString *)coursePack{
    return [self.dataMngntObj isShowProfile:coursePack];
}

-(NSDictionary *)getCatelogDataObject :(NSString *)course_pack Topic :(NSString *)topicId
{
    return [self.dataMngntObj getCatelogData:course_pack Topic:topicId];
}
-(NSString *)getCatelogData:(NSString *)course_pack Topic :(NSString *)topicId
{
    NSString * strCatlog;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self.dataMngntObj getCatelogData:course_pack Topic:topicId]
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        strCatlog = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    return strCatlog;
    
}

-(NSString *)getAssessmnetMCQData:(int)EdgeId :(int)type
{
    return[self.dataMngntObj getAssessmnetMCQData :EdgeId :type];
}

-(NSString *)getScenariopracticeData:(NSInteger )data :(NSInteger )type :(NSString *)coursePack
{
    return [self.dataMngntObj getScenariopracticeData :data:type :coursePack];
}
-(NSMutableDictionary *)getScenariopracticArr:(NSInteger )data :(NSInteger )type :(NSString *)coursePack
{
    return [self.dataMngntObj getScenariopracticArr :data:type :coursePack];
}
-(NSString *)getZipfileName:(int)EdgeId : (NSString *)Type;
{
    return [self.dataMngntObj getZipfileName:EdgeId :Type];
}
-(NSArray*)getGameArr:(NSString *)uid
{
    return [self.dataMngntObj getGameArr:uid];
}



-(void)downloadZipFileAndParseData:(NSString *)fileName uID:(NSString * )uid
{
    downloadingModuleID = uid;
    NSString * vocabUrl = [[NSString alloc]initWithFormat:@"%@%@/%@",AUDRO_ZIP_URL,courseCode,fileName];
    [self.networkObj downloadFileFromURL:vocabUrl];
    
    
}


-(void)setModuleId :(NSString *)uid
{
    downloadingModuleID = uid;
}

-(void)fromBaseEncryptAndParse :(NSString *)filePath :(NSString *)edge_id
{
    Utility *utility = [[Utility alloc]init:courseCode];
    NSArray *pathComponents = [filePath pathComponents];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPathdoc = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPathdoc = [dataPathdoc stringByAppendingPathComponent:courseCode];
    NSString *dataPath1 = [dataPathdoc stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    [self Unzipping:[pathComponents lastObject] path:dataPath1];
    [self.dataMngntObj initialise];
    NSArray * practiceArr = [self.dataMngntObj getpracticeArray:edge_id :DATABASE_CATTYPE_PRACTICE];
    for (NSDictionary * localDict  in practiceArr)
    {
        NSDictionary* dicXmlPath = [self.dataMngntObj getPracticeXMLpath:[localDict valueForKey:DATABASE_EXERCISE_EDGEID]:DATABASE_CATTYPE_SCN_PRACTICE_XML];
        if(dicXmlPath != NULL )
        {
            XMLDictionary * xmlObj = [[XMLDictionary alloc]init:courseCode];
            
            
            NSString *datapracticePath = [documentsDirectory stringByAppendingPathComponent:[dicXmlPath valueForKey:DATABASE_PRACTICE_DATA]];
            [xmlObj parseConceptXML:datapracticePath :[[NSString alloc]initWithFormat:@"%ld",(long)[self.dataMngntObj unitCount] ]:[dicXmlPath valueForKey:DATABASE_PRACTICE_EDGEID]];
            [self.dataMngntObj fillConceptPracticeXmlDatabase:xmlObj catType:DATABASE_CATTYPE_CONCEPT_XML];
        }
        
        
        NSDictionary * vocabPath = [self.dataMngntObj getPracticeXMLpath:[localDict valueForKey:DATABASE_EXERCISE_EDGEID]:DATABASE_CATTYPE_VOCAB_PRACTICE_XML];
        if(vocabPath != NULL)
        {
            
            
            XMLDictionary * xmlotherObj = [[XMLDictionary alloc]init:courseCode];
            NSString *dataVocabPath = [documentsDirectory stringByAppendingPathComponent:[vocabPath valueForKey:DATABASE_PRACTICE_DATA]];
            [xmlotherObj parseConceptXML:dataVocabPath :[[NSString alloc]initWithFormat:@"%ld",(long)[self.dataMngntObj unitCount] ]:[vocabPath valueForKey:DATABASE_PRACTICE_EDGEID]];
            [self.dataMngntObj vocabpracticeXml:xmlotherObj];
        }
        
    }
}
-(void)EncryptAndParse :(NSString *)fileName
{
    Utility *utility = [[Utility alloc]init:courseCode];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPathdoc = [documentsDirectory stringByAppendingPathComponent:ROOTFOLDERNAME];
    dataPathdoc = [dataPathdoc stringByAppendingPathComponent:courseCode];
    NSString *dataPath1 = [dataPathdoc stringByAppendingPathComponent:COURSEZIPFOLDERNAME];
    
    
    [self Unzipping:[fileName stringByReplacingOccurrencesOfString:@" " withString:@""] path:dataPath1];
    int value = 90;
    
    
    
    NSString * path = [self.dataMngntObj getfolderPath:[downloadingModuleID intValue] :DATABASE_CATTYPE_SCENARIO];
    
    
    NSString *folderpath  = [documentsDirectory stringByAppendingPathComponent:[path stringByReplacingOccurrencesOfString:@" " withString:@""]];
    
    
    [utility fileEncryptallVocabFile:folderpath];
    
    
    [self.dataMngntObj initialise];
    
    //    NSDictionary * dicpath = [self.dataMngntObj getConceptXMLpath:downloadingModuleID:DATABASE_CATTYPE_CONCEPT_XML];
    //    if(dicpath != NULL)
    //    {
    //        XMLDictionary * xmlObj = [[XMLDictionary alloc]init:courseCode];
    //        NSString *datapracticePath = [documentsDirectory stringByAppendingPathComponent:[dicpath valueForKey:DATABASE_EXERCISE_DATA]];
    //        //[utility encryptAllFile :datapracticePath destination:datapracticePath];
    //        [xmlObj parseConceptXML:datapracticePath  :[[NSString alloc]initWithFormat:@"%ld",(long)[self.dataMngntObj unitCount] ] :[dicpath valueForKey:DATABASE_EXERCISE_EDGEID]];
    //
    //        [self.dataMngntObj fillConceptPracticeXmlDatabase:xmlObj catType:DATABASE_CATTYPE_CONCEPT_XML];
    //    }
    
    [self.dataMngntObj initialise];
    NSArray * practiceArr = [self.dataMngntObj getpracticeArray:downloadingModuleID :DATABASE_CATTYPE_PRACTICE];
    for (NSDictionary * localDict  in practiceArr)
    {
        
        
        NSDictionary* dicXmlPath = [self.dataMngntObj getPracticeXMLpath:[localDict valueForKey:DATABASE_EXERCISE_EDGEID]:DATABASE_CATTYPE_SCN_PRACTICE_XML];
        if(dicXmlPath != NULL )
        {
            XMLDictionary * xmlObj = [[XMLDictionary alloc]init:courseCode];
            
            
            NSString *datapracticePath = [documentsDirectory stringByAppendingPathComponent:[dicXmlPath valueForKey:DATABASE_PRACTICE_DATA]];
            [xmlObj parseConceptXML:datapracticePath :[[NSString alloc]initWithFormat:@"%ld",(long)[self.dataMngntObj unitCount] ]:[dicXmlPath valueForKey:DATABASE_PRACTICE_EDGEID]];
            [self.dataMngntObj fillConceptPracticeXmlDatabase:xmlObj catType:DATABASE_CATTYPE_CONCEPT_XML];
        }
        NSDictionary * vocabPath = [self.dataMngntObj getPracticeXMLpath:[localDict valueForKey:DATABASE_EXERCISE_EDGEID]:DATABASE_CATTYPE_VOCAB_PRACTICE_XML];
        if(vocabPath != NULL)
        {
           XMLDictionary * xmlotherObj = [[XMLDictionary alloc]init:courseCode];
            NSString *dataVocabPath = [documentsDirectory stringByAppendingPathComponent:[vocabPath valueForKey:DATABASE_PRACTICE_DATA]];
            [xmlotherObj parseConceptXML:dataVocabPath :[[NSString alloc]initWithFormat:@"%ld",(long)[self.dataMngntObj unitCount] ]:[vocabPath valueForKey:DATABASE_PRACTICE_EDGEID]];
            [self.dataMngntObj vocabpracticeXml:xmlotherObj];
        }
        
    }
    value = 101;
    
    NSDictionary *userInfoNext = [NSDictionary dictionaryWithObject:[[NSString alloc]initWithFormat:@"%d",value] forKey:SOMEKEY];
    [[NSNotificationCenter defaultCenter] postNotificationName: GETPERCENTAGENOTIFICATIONNAME object:nil userInfo:userInfoNext];
}

-(NSMutableArray *)getVocabWords:(NSString *)pracUid
{
    return [self.dataMngntObj getVocabWords:pracUid];
}
-(NSMutableArray *)getVocabWordsSlider:(NSString *)pracUid
{
    return [self.dataMngntObj getVocabWordsSlider:pracUid];
}
-(BOOL)setPracticeOrAssissmentData :(NSDictionary *)strData edgeId:(NSString * )edgeId :(NSString * )pack
{
    return [self.dataMngntObj setPracticeOrAssissmentData :strData edgeId:edgeId :(NSString * )pack];
}
-(BOOL)isAssessMCQData :(NSString *)edge_id
{
    return [self.dataMngntObj isAssessMCQData:edge_id];
}


-(BOOL)setTracktableData:(NSMutableDictionary *)data
{
    if(![[data valueForKey:DATABASE_TRACKINGTABLE_COURSEPACK]isEqualToString:@""])
     return [self.dataMngntObj setTracktableData:data];
    else
      return FALSE;
}

//-(BOOL)syncCompletionStatus :(NSDictionary * )trackDataDic
//{
//   NSMutableArray * mainArr = [[NSMutableArray alloc]init];
//   NSMutableDictionary * nsDict =[[NSMutableDictionary alloc]init];
//
//
//            [nsDict setValue:[trackDataDic valueForKey:@"edgeId"] forKey:JSON_EDGEID];
//            //[nsDict setValue:[trackDataDic valueForKey:@"startTime"] forKey:JSON_SATRTTIMEMS];
//            //[nsDict setValue:[trackDataDic valueForKey:DATABASE_TRACKINGTABLE_ENDTIME] forKey:JSON_ENDTIMEMS];
//            [nsDict setValue:[trackDataDic valueForKey:@"courseCode"] forKey:JSON_COURSECODE];
//            [nsDict setValue:[trackDataDic valueForKey:@"package_code"] forKey:JSON_COURSEPACK];
//
//            if([[trackDataDic valueForKey:@"iscomp"]intValue] == 1)
//                [nsDict setValue:@"c" forKey:JSON_ISCOMP];
//            else if([[trackDataDic valueForKey:@"iscomp"]intValue] == 0)
//                [nsDict setValue:@"nc" forKey:JSON_ISCOMP];
//            else if([[trackDataDic valueForKey:@"iscomp"]intValue] == -1)
//                [nsDict setValue:@"na" forKey:JSON_ISCOMP];
//            else
//                [nsDict setValue:@"na" forKey:JSON_ISCOMP];
//        [mainArr addObject:nsDict];
//
//    NSString * syncTime = [appDelegate.engineObj.dataMngntObj getCurrentTime];
//    NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//    [reqObj setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN ];
//    [reqObj setValue:JSON_SYNCCOMPONANTCOMPLETION forKey:JSON_DECREE ];
//    [reqObj setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:JSON_DEVICEID];
//    [reqObj setObject:APPVERSION forKey:JSON_APPVERSION];
//    [reqObj setObject:@"iOS" forKey:JSON_PLATFORM];
//    [reqObj setObject:CLASS_NAME forKey:JSON_CALSS_NAME];
//    [reqObj setObject:CLIENT forKey:JSON_CLIENT];
//    [reqObj setValue:mainArr forKey:JSON_PARAM];
//    NSMutableDictionary * _reqObj = [[NSMutableDictionary alloc]init];
//    [_reqObj setValue:B_SERVICE_SYNCCCTRACK forKey:@"SERVICE"];
//    [_reqObj setValue:@"MobileSplash" forKey:@"original_source"];
//    [_reqObj setValue:syncTime forKey:@"syncTime"];
//    [appDelegate.engineObj.networkObj sendRequesttoServer:_reqObj:reqObj];
//    return TRUE;
//
//}



-(NSString *)getFileData:(NSInteger)uId
{
    return [self.dataMngntObj getPathWithoutRoot:[self.dataMngntObj getConceptFilePath:uId]];
}
-(NSMutableDictionary *)getWordData:(NSString *)uid
{
    return [self.dataMngntObj getWordData:uid];
}

-(NSMutableDictionary *)getScnpracticeData:(NSInteger)scnPracId : (NSString *)practiceType : (NSInteger )scnUid
{
    return [self.dataMngntObj getScnpracticeData:scnPracId : practiceType:scnUid];
}
-(BOOL)setUpdatedScnariopractice:(NSMutableDictionary *)dictionary;
{
    return [self.dataMngntObj setUpdatedScnariopractice:dictionary];
}

-(NSString *)getSecnarioInstruction:(NSInteger)scnPracId :(NSString *)coursePack
{
    return [self.dataMngntObj getSecnarioInstruction:scnPracId :coursePack
            ];
    
}

//-(NSDictionary *)SANAuploadAudio:(NSString *)path :(NSString *)WordValue :(NSString *)tokenId
//{
//    NSMutableDictionary *uiResponse = [[NSMutableDictionary alloc] init];
//    NSMutableString * file = [[NSMutableString alloc]initWithFormat:@"%@.wav",tokenId];
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
//    NSMutableDictionary * resData;
//    if(data.length > 4096){
//       resData =[self.networkObj sendRequestToSANAAduro:SANAVOICEAPI data:data method:@"POST" : WordValue : tokenId: @"wav" : file];
//        if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//        {
//            [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
//            //[uiResponse setValue:DATANULL forKey:UIMSG];
//        }
//        else
//        {
//            [uiResponse setValue:SUCCESS forKey:UIRESPONSERESULT];
//            [uiResponse setValue:[resData valueForKey:NETWORKDATA]forKey:UIRESPONSE];
//        }
//    }
//    else
//    {
//        [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
//    }
//    return uiResponse;
//}

-(NSDictionary *)uploadAudio:(NSString *)path :(NSString *)WordValue :(NSString *)user_id :(NSString *)token_id
{
    NSMutableDictionary *uiResponse = [[NSMutableDictionary alloc] init];
    NSMutableString * file = [[NSMutableString alloc]initWithString:@"hello.wav"];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    NSMutableDictionary * resData =[self.networkObj sendRequestToPicUploadAduro:SANAVOICEAPI data:data method:@"POST" : user_id : token_id:@"true":file];
    
    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
    {
        [uiResponse setValue:FAILURE forKey:UIRESPONSERESULT];
        //[uiResponse setValue:DATANULL forKey:UIMSG];
    }
    else
    {
        [uiResponse setValue:SUCCESS forKey:UIRESPONSERESULT];
        [uiResponse setValue:[resData valueForKey:NETWORKDATA]forKey:UIRESPONSE];
    }
    return uiResponse;
}

-(BOOL)setVocabWord:(NSDictionary *)vocabWordData
{
    return [self.dataMngntObj setVocabWord:vocabWordData];
}
-(int)getIdealTime:(NSInteger )conceptid
{
    return [self.dataMngntObj getIdealTime:conceptid];
}


-(NSMutableArray *)getCatelogDataForIr
{
    return [self.dataMngntObj getCatelogDataForIr];
}
-(NSMutableArray *)getScnArrayForIr:(NSString *)strUid
{
    return [self.dataMngntObj getScnArrayForIr:strUid];
}
//-(NSMutableDictionary *)getTrackDataForIr:(NSString *)strUid
//{
//    return [self.dataMngntObj getTrackDataForIr:strUid];
//}
-(NSInteger)getMaxScore:(NSString *)uID :(NSString *)type
{
    return [self.dataMngntObj getMaxScore:uID :type];
}
-(BOOL)setUpdateScore:(float)score :(NSString *)uid :(NSString *)table
{
    return [self.dataMngntObj setUpdateScore:score :uid :table];
}
-(NSMutableArray *)getCAPArray:(NSString *)uID :(NSString *)type
{
    return [self.dataMngntObj getCAPArray:uID :type];
}
-(NSMutableArray *)getSCNPracArr:(NSString *)uID :(NSString *)type
{
    return [self.dataMngntObj getSCNPracArr:uID :type];
}
-(NSMutableArray *)getVocabArray:(NSString *)uID
{
    return [self.dataMngntObj getVocabArray:uID];
}
-(NSDictionary *)getVocabWord:(NSString *)uID
{
    return [self.dataMngntObj getVocabWord:uID];
}
-(NSString *)getDashboardData:(NSString *)coursePack
{
    return [self.dataMngntObj getDashboardData:coursePack];
}
-(BOOL)setImageFlag
{
    return [self.dataMngntObj setImage:IMAGECAPTURED];
}

//-(BOOL)syncVisitedData :(NSString * )tokenId
//{
//    [Logger logAduro:@"Engine : start Function syncVisitedData" ];
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSArray *visitedArr = [defaults valueForKey:@"visitedData"];
//
//    if(visitedArr!= NULL && [visitedArr count] >0)
//    {
//
//        Utility *utility = [[Utility alloc]init:courseCode];
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:tokenId forKey:JSON_TOKEN ];
//        [reqObj setValue:JSON_VISITED_LIST forKey:JSON_DECREE ];
//
//        NSMutableDictionary * paramObj = [[NSMutableDictionary alloc]init];
//        [paramObj setValue: APPVERSION forKey:JSON_APPVERSION];
//        [paramObj setObject:[self getIMEINumber] forKey:JSON_DEVICEID];
//        [paramObj setObject:@"iOS" forKey:JSON_PLATFORM];
//        [paramObj setValue:visitedArr forKey:@"visit_data"];
//
//
//        [reqObj setValue:paramObj forKey:JSON_PARAM];
//        [Logger log:@"Engine : Request Data to Server :%@",reqObj];
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqObj options:0 error:&err];
//        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//        NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//        [Logger log:@"Engine : respose from Server :%@",resData];
//        if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//        {
//            //[uiResponse setValue:FAILURE forKey:UIRESPONSE];
//            //[uiResponse setValue:DATANULL forKey:UIMSG];
//        }
//        else
//        {
//            NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//
//
//            NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//
//            NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//            [Logger log:@"Engine : Response Data to Server :%@",temp];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [defaults removeObjectForKey:@"visitedData"];
//
//            }
//
//        }
//    }
//
//    [Logger logAduro:@"Engine : end Function syncVisitedData"];
//
//    return TRUE;
//}

//-(BOOL)uploadImageToAduroFromLocal
//{
//    [Logger logAduro:@"Engine : start Function uploadImageToAduroFromLocal" ];
//    NSDictionary * userDictionary = [self.dataMngntObj getUserInfo];
//    if(userDictionary!= NULL)
//    {
//        int flag = [[userDictionary valueForKey:DATABASE_ISIMAGECAPTURE] intValue];
//        if(flag == 0)
//        {
//            return FALSE;
//        }
//        Utility *utility = [[Utility alloc]init:courseCode];
//        NSMutableDictionary * reqObj = [[NSMutableDictionary alloc] init];
//        [reqObj setValue:self.tokenID forKey:JSON_TOKEN ];
//        [reqObj setValue:JSON_UPLOADLOC forKey:JSON_DECREE ];
//
//        NSArray * arr = [[NSArray alloc]initWithObjects:@"0", nil];
//        NSMutableDictionary * file_types = [[NSMutableDictionary alloc]init];
//        [file_types setValue:arr forKey:@"file_types"];
//        [reqObj setValue:file_types forKey:JSON_PARAM];
//        [Logger log:@"Engine : Request Data to Server :%@",reqObj];
//        NSError * err;
//        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:reqObj options:0 error:&err];
//        NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//        NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//        NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//        [Logger log:@"Engine : respose from Server :%@",resData];
//        if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//        {
//            //[uiResponse setValue:FAILURE forKey:UIRESPONSE];
//            //[uiResponse setValue:DATANULL forKey:UIMSG];
//        }
//        else
//        {
//            NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//
//
//            NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//
//            NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//            [Logger log:@"Engine : Response Data to Server :%@",temp];
//            if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//            {
//                NSDictionary * valdict = [temp valueForKey:@"retVal"];
//                NSArray * fileArr = [valdict valueForKey:@"file_locs"];
//
//                NSMutableString * url = [[NSMutableString alloc]initWithFormat:ADURO_AUDIO_URL];
//                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
//                                                                     NSUserDomainMask, YES);
//                NSString *documentsDirectory = [paths objectAtIndex:0];
//                NSString* path = [documentsDirectory stringByAppendingPathComponent:
//                                  @"userPic.png" ];
//                NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
//
//
//                NSMutableDictionary * resData =[self.networkObj sendRequestToPicUploadAduro:url data:data method:@"POST":[fileArr objectAtIndex:0] : self.tokenID : @"false" :@"image.png"];
//
//                if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//                {
//
//                }
//                else
//                {
//                    [self.dataMngntObj setImage:NOIMAGECAPTURED];
//
//                }
//
//            }
//
//        }
//    }
//
//    [Logger logAduro:@"Engine : end Function uploadImageToAduroFromLocal"];
//
//    return TRUE;
//}


//-(BOOL)uploadZipToAduroFromLocal
//{
//
//    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString * str = [[NSString alloc]initWithFormat:@"records.zip"];
//    NSString * str1 = [[NSString alloc]initWithFormat:@"records"];
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:str1];
//     NSString *dataPath1 = [documentsDirectory stringByAppendingPathComponent:str];
//    if([SSZipArchive createZipFileAtPath:dataPath1 withContentsOfDirectory:dataPath])
//        {
//            NSLog(@"Successfully Created");
//        }
//
//
//
//    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
//                                                                 NSUserDomainMask, YES) objectAtIndex:0];
//
//    NSString * oldName = [[NSString alloc]initWithFormat:@"%@/%@.zip",documentDir,@"records"];
//
//
//    NSMutableString * url = [[NSMutableString alloc]initWithFormat:ADURO_AUDIO_URL];
//
////                       ];
//    NSData *data = [[NSFileManager defaultManager] contentsAtPath:oldName];
//    NSMutableDictionary * resData;
//    if(data.length > 50)
//        resData =[self.networkObj sendRequestToPicUploadAduro:url data:data method:@"POST":self.user_id: self.tokenID:@"true":@"records.zip"];
//
//
//
//    if(resData != NULL && [[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        BOOL success = [fileManager removeItemAtPath:oldName error:&error];
//        if (success) {
//            BOOL success = [fileManager removeItemAtPath:dataPath error:&error];
//
//        }
//        else
//        {
//            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
//        }
//    }
//    else
//    {
//
//
//    }
//
//
//
//    return TRUE;
//}

//-(NSDictionary *)getAssessmentReportUrl :(NSString *)tokenId
//{
//    [Logger logAduro:@"Engine : start Function getAssessmentReportUrl" ];
//    Utility *utility = [[Utility alloc]init];
//
//    NSMutableDictionary * weburlDict = [[NSMutableDictionary alloc]init];
//    [weburlDict setValue:JSON_GETUSERREPORT forKey:JSON_DECREE];
//
//    [weburlDict setValue:@"iOS"  forKey:JSON_PLATFORM];
//    [weburlDict setValue: APPVERSION forKey:JSON_APPVERSION];
//    NSMutableDictionary * localObj = [[NSMutableDictionary alloc]init];
//    [localObj setValue:courseCode forKey:@"course_code"];
//    [weburlDict setValue:localObj forKey:JSON_PARAM];
//    [weburlDict setValue:tokenId forKey:JSON_TOKEN];
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:weburlDict options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"webUrl Request :%@",myString);
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function getAssessmentReportUrl" ];
//        return false;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        NSLog(@"webUrl Response :%@",temp);
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN] && ![[temp valueForKey:@"retVal"]isEqual:[NSNull null]])
//        {
//          return [temp valueForKey:@"retVal"];
//
//
//
//        }
//            return nil;
//    }
//    return nil;
//
//}

-(NSDictionary *)getUserInfo
{
    [Logger logAduro:@"Engine : start Function getUserInfo" ];
    return [self.dataMngntObj getUserInfo];
}
-(NSDictionary *)getCurrentSession :(NSString *)val
{
    return [self.dataMngntObj getCurrentSession:val];
}
-(BOOL)cancelDownload
{
    return [self.networkObj cancelDownload];
}

-(NSString *)getLastpracticeTextUid
{
    return [self.dataMngntObj getLastpracticeTextUid];
}


-(NSString *)getPracticeMCQList
{
    
    
    NSString * data;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self.dataMngntObj getPracticeMCQList]
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        data = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        // NSLog(@"json %@", data);
    }
    
    
    return data;
    
}


-(NSString *)getCourseXml{
    return [self.dataMngntObj getCourseXml];
}

-(NSString *)getAssessmnetMCQHTMLPath:(int)EdgeId :(int)type
{
    return [self.dataMngntObj getAssessmnetMCQHTMLPath:EdgeId :type];
}

-(NSMutableDictionary *)getGameDashboardData :(NSString *)coursePack Topic :(NSString *)topicId;
{
    return [self.dataMngntObj getGameDashboardData:coursePack Topic:topicId];
}
-(NSMutableArray *)getAllTopicData
{
    return [self.dataMngntObj getAllTopicData];
}

-(NSString *)getScenarioName:(int)scnUid
{
    return [self.dataMngntObj getScenarioName:scnUid];
}

-(NSArray *)getAllCourseCode
{
    return [self.dataMngntObj getAllCourseCode];
}
-(NSString *)getCurrentCoursepack
{
    return [self.dataMngntObj getCurrentCoursepack];
}
-(NSArray *)getAllCourseCodeWithPack :(NSString *)pack_code : (NSString *)user_level
{
    return [self.dataMngntObj getAllCourseCodeWithPack :pack_code :user_level];
}

-(NSMutableArray *)getChapterDetail:(NSInteger )data
{
    return [self.dataMngntObj getChapterDetail :data];
}


-(BOOL)DownloadNewCourseCode : (NSDictionary * )xmlData
{
    [Logger logAduro:@"Engine  : sart Function DownloadNewCourseCode with Parameter" ];
    XMLDictionary * xmlObj = [[XMLDictionary alloc]init];
    [xmlObj parseCourseJSON:xmlData];
    [self.dataMngntObj fillCourseDatabase:xmlObj];
    [Logger logAduro:@"Engine  : end Function DownloadNewCourseCode with Parameter" ];
    return true;
}
-(BOOL)parseChapComponent:(NSDictionary *)xmlData
{
    [Logger logAduro:@"Engine  : sart Function parseChapComponent" ];
    XMLDictionary * xmlObj = [[XMLDictionary alloc]init:courseCode];
    [xmlObj parseScenarioJSON:xmlData];
    [self.dataMngntObj fillCourseDatabase:xmlObj];
    
    [Logger logAduro:@"Engine  : end Function parseChapComponent" ];
    return true;
}

-(BOOL)isCourseExist:(NSString *)course_edgeId
{
    return [self.dataMngntObj isCourseExist:course_edgeId];
}

-(BOOL)coursePackExistorNot:(NSString *)_coursePack
{
    return [self.dataMngntObj coursePackExistorNot:_coursePack];
}

-(BOOL)DeleteCourseCode:(NSString *)deleteCode deleteDirectory:(BOOL)isDelete
{
    return [self.dataMngntObj deleteCourseCode:deleteCode deleteDirectory:isDelete];
}

-(BOOL)deleteScenario:(NSString *)edgeId deleteDirectory:(BOOL)isDelete deleteZip:(BOOL)_isDelete
{
    return [self.dataMngntObj deleteScenario:edgeId deleteDirectory:isDelete deleteZip:_isDelete];
}

//-(BOOL)getEventList
//{
//    [Logger logAduro:@"Engine : start Function getEventList" ];
//    Utility *utility = [[Utility alloc]init:courseCode];
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue: JSON_EVENTLIST_DECREE forKey:JSON_DECREE];
//    [dictionary setValue:[[NSString alloc] initWithFormat:@"%@",self.tokenID] forKey:JSON_TOKEN];
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function getEventList" ];
//        [[NSNotificationCenter defaultCenter] postNotificationName: SERVICE_GETLIVESESSIONLIST object:nil userInfo:nil];
//        return false;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        NSLog(@"%@",temp);
//
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//                [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:[resUserData valueForKey:@"classList"]] forKey:edgeId];
//
//                [defaults synchronize];
//                [Logger logAduro:@"Engine : End Function getEventList"];
//                [[NSNotificationCenter defaultCenter] postNotificationName: SERVICE_GETLIVESESSIONLIST object:nil userInfo:nil];
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function getEventList"];
//                [[NSNotificationCenter defaultCenter] postNotificationName: SERVICE_GETLIVESESSIONLIST object:nil userInfo:nil];
//                return false;
//            }
//        }
//    }
//    [[NSNotificationCenter defaultCenter] postNotificationName: SERVICE_GETLIVESESSIONLIST object:nil userInfo:nil];
//    [Logger logAduro:@"Engine : end Function getEventList"];
//    return true;
//}




//-(BOOL)cancelEvent:(NSString *)edgeId
//{
//    [Logger logAduro:@"Engine : start Function cancelEvent" ];
//    Utility *utility = [[Utility alloc]init:courseCode];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:edgeId forKey:JSON_CLASSID];
//    
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_EVENTCANCEL_DECREE forKey:JSON_DECREE];
//    
//    [dictionary setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//    
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    
//    
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function cancelEvent" ];
//        return false;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                
//                
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function cancelEvent"];
//                return false;
//            }
//        }
//    }
//    [Logger logAduro:@"Engine : end Function cancelEvent"];
//    return true;
//}


//-(BOOL)joinEvent:(NSString *)edgeId
//{
//    [Logger logAduro:@"Engine : start Function joinEvent" ];
//    Utility *utility = [[Utility alloc]init:courseCode];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:edgeId forKey:JSON_CLASSID];
//
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_EVENTJOIN_DECREE forKey:JSON_DECREE];
//
//    [dictionary setValue:[[NSString alloc] initWithFormat:@"%@",self.tokenID] forKey:JSON_TOKEN];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduroWizIQ:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
//    {
//        [Logger logAduro:@"Engine : end Function joinEvent"];
//        return false;
//    }
//    else
//    {
//
//        NSString *newStr = [[resData valueForKey:NETWORKDATA] substringFromIndex:2];
//        NSString *resEncryptData = [utility decrypt:newStr withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function joinEvent"];
//                return false;
//            }
//        }
//    }
//    [Logger logAduro:@"Engine : end Function joinEvent"];
//    return true;
//}

//-(BOOL)getNotificaton:(NSString *)edgeId :(NSString *)type
//{
//    [Logger logAduro:@"Engine : start Function getNotificaton" ];
//    Utility *utility = [[Utility alloc]init:courseCode];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:edgeId forKey:JSON_EDGEID];
//    [ldict setValue:type forKey:JSON_TYPE];
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_EVENTNOTI_DECREE forKey:JSON_DECREE];
//
//    [dictionary setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST"];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
//    {
//        [Logger logAduro:@"Engine : end Function getNotificaton"];
//        return false;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function getNotificaton"];
//                return false;
//            }
//        }
//    }
//    [Logger logAduro:@"Engine : end Function getNotificaton"];
//    return true;
//}
-(NSString *)getCurrentCourseId
{
    return [self.dataMngntObj getCurrentCourseId];
}


//-(BOOL)CourseDldNotiFy
//{
//    [Logger logAduro:@"Engine : start Function CourseDldNotiFy" ];
//    Utility *utility = [[Utility alloc]init:courseCode];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:courseCode forKey:JSON_COURSECODE];
//
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_COURSE_SIGNUP_DECREE forKey:JSON_DECREE];
//
//    [dictionary setValue:[[NSString alloc] initWithFormat:@"%@",self.tokenID] forKey:JSON_TOKEN];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function CourseDldNotiFy" ];
//        return false;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function CourseDldNotiFy"];
//                return false;
//            }
//        }
//    }
//    [Logger logAduro:@"Engine : end Function CourseDldNotiFy"];
//    return true;
//}




//-(NSMutableDictionary *)checkCourseCodeDirctoryExistonServer:(NSString*)_courseCode licence_key:(NSString *)key
//{
//    
//    NSMutableDictionary * courseXmlResp = [[NSMutableDictionary alloc]init];
//    [courseXmlResp setValue: @"0" forKey:@"resStat"];
//    [courseXmlResp setValue:@"" forKey:@"resVal"];
//    
//    [Logger logAduro:@"Engine : start Function checkCourseCodeDirctoryExistonServer" ];
//    Utility *utility = [[Utility alloc]init:_courseCode];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:_courseCode forKey:JSON_COURSECODE];
//    [ldict setValue:key forKey:JSON_COURSEPACK];
//    [ldict setValue: APPVERSION forKey:JSON_APPVERSION];
//    
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_COURSE_CHECK_DECREE forKey:JSON_DECREE];
//    
//    
//    [dictionary setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//    
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    
//    
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function checkCourseCodeDirctoryExistonServer" ];
//        return courseXmlResp;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSString * str = [resEncryptData stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
//        str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
//        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSData *jsonRawData = [str dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                if([[resUserData valueForKey:@"course_code"] isEqualToString:_courseCode] && [[resUserData valueForKey:@"status"] intValue] == 1 ){
//                    [courseXmlResp setValue: @"1" forKey:@"resStat"];
//                    
//                    
//                    //NSString * str = [[resUserData valueForKey:@"courseArr"] stringByReplacingOccurrencesOfString:@"string"
//                    // withString:@"duck"];
//                    
//                    
//                    
//                    
//                    [courseXmlResp setValue: [resUserData valueForKey:@"courseArr"] forKey:@"xmlData"];
//                    
//                    
//                    return courseXmlResp;
//                } //Course exist;
//                else{
//                    
//                    
//                    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[[NSString alloc]initWithFormat:@"%@",[resUserData valueForKey:@"msg"]] forKey:SOMEKEY];
//                    [[NSNotificationCenter defaultCenter] postNotificationName: GETSERVERMSGNOTIFICATIONNAME object:nil userInfo:userInfo];
//                    [courseXmlResp setValue: @"2" forKey:@"resStat"];
//                    return courseXmlResp;
//                } //Course not exist;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function checkCourseCodeDirctoryExistonServer"];
//                [courseXmlResp setValue: @"0" forKey:@"resStat"];
//                return courseXmlResp;
//            }
//        }
//        else
//        {
//            [courseXmlResp setValue: @"0" forKey:@"resStat"];
//            return courseXmlResp;
//        }
//    }
//    [Logger logAduro:@"Engine : end Function checkCourseCodeDirctoryExistonServer"];
//    [courseXmlResp setValue: @"0" forKey:@"resStat"];
//    return courseXmlResp;
//    
//    
//}



//-(NSMutableDictionary *)getCoursePackInfo:(NSString*)coursePack
//{
//
//    NSMutableDictionary * coursePackResp = [[NSMutableDictionary alloc]init];
//    [coursePackResp setValue: @"0" forKey:@"resStat"];
//    [coursePackResp setValue:@"Please check your network." forKey:@"resVal"];
//
//    [Logger logAduro:@"Engine : start Function getCoursePackInfo" ];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:coursePack forKey:JSON_COURSEPACK];
//    [ldict setValue: APPVERSION forKey:JSON_APPVERSION];
//    [ldict setObject:[self getIMEINumber] forKey:JSON_DEVICEID];
//    [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
//
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_COURSEPACKINFO_DECREE forKey:JSON_DECREE];
//
//
//    [dictionary setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    Utility *utility = [[Utility alloc]init];
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//
//
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function getCoursePackInfo" ];
//        [coursePackResp setValue:@"0" forKey:@"resStat"];
//        [coursePackResp setValue:@"Please check your network." forKey:@"resVal"];
//        return coursePackResp;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSString * str = [resEncryptData stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
//        str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
//        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//
//        NSData *jsonRawData = [str dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//
//                NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
//                NSMutableArray * productArr = [[NSMutableArray alloc]init];
//                if(packArr != NULL && [packArr count] >0){
//                    [self.dataMngntObj updateCoursePackData:packArr];
//
//                    for (NSDictionary *obj  in packArr) {
//                        [productArr addObject:[obj valueForKey:@"product_code"]];
//                    }
//                    [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                    [coursePackResp setValue:@"1" forKey:@"resStat"];
//                    [coursePackResp setValue:@"" forKey:@"resVal"];
//
//                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//                    [dic setValue:productArr forKey:@"product_codes"];
//                    [dic setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:@"token_id"];
//                    [self setDeviceToken:dic];
//
//                }
//                else
//                {
//                    [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                    [coursePackResp setValue:@"2" forKey:@"resStat"];
//                    [coursePackResp setValue:@"No Course code Available" forKey:@"resVal"];
//                    return coursePackResp;
//                }
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                [coursePackResp setValue:@"2" forKey:@"resStat"];
//                [coursePackResp setValue:@"Unknown Error" forKey:@"resVal"];
//                return coursePackResp;
//
//            }
//        }
//        else
//        {
//            [coursePackResp setValue:@"2" forKey:@"resStat"];
//            [coursePackResp setValue:[[temp valueForKey:JSON_RETVAL]valueForKey:@"msg"] forKey:@"resVal"];
//            return coursePackResp;
//        }
//    }
//    [Logger logAduro:@"Engine : end Function getCoursePackInfo"];
//    //[courseXmlResp setValue: @"0" forKey:@"resStat"];
//    return coursePackResp;
//
//
//}
//-(NSMutableDictionary *)getExistCoursePackInfo:(NSString*)coursePack :(NSString *)tokenId
//{
//    
//    NSMutableDictionary * coursePackResp = [[NSMutableDictionary alloc]init];
//    [coursePackResp setValue: @"0" forKey:@"resStat"];
//    [coursePackResp setValue:@"Please check your network." forKey:@"resVal"];
//    
//    [Logger logAduro:@"Engine : start Function getExistCoursePackInfo" ];
//    //
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:coursePack forKey:JSON_COURSEPACK];
//    [ldict setValue: APPVERSION forKey:JSON_APPVERSION];
//    [ldict setObject:[self getIMEINumber] forKey:JSON_DEVICEID];
//    [ldict setObject:@"iOS" forKey:JSON_PLATFORM];
//    
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_RESCOURSEPACKINFO_DECREE forKey:JSON_DECREE];
//    
//    
//    [dictionary setValue:[[NSString alloc] initWithFormat:@"%@",tokenId] forKey:JSON_TOKEN];
//    
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    Utility *utility = [[Utility alloc]init];
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    
//    
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
//    {
//        [Logger logAduro:@"Engine : end Function getCoursePackInfo" ];
//        [coursePackResp setValue:@"0" forKey:@"resStat"];
//        [coursePackResp setValue:@"Please check your network." forKey:@"resVal"];
//        return coursePackResp;
//    }
//    else
//    {
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSString * str = [resEncryptData stringByReplacingOccurrencesOfString:@"&#38;"  withString:@"&"];
//        str = [str stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
//        str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//        str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//        
//        NSData *jsonRawData = [str dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                NSArray *packArr = (NSArray*)[resUserData valueForKey:HTML_JSON_KEY_PACKAGEINFO];
//                NSMutableArray * productArr = [[NSMutableArray alloc]init];
//                if(packArr != NULL && [packArr count] >0){
//                    [self.dataMngntObj updateCoursePackData:packArr];
//                    
//                    for (NSDictionary *obj  in packArr) {
//                        [productArr addObject:[obj valueForKey:@"product_code"]];
//                    }
//                    [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                    [coursePackResp setValue:@"1" forKey:@"resStat"];
//                    [coursePackResp setValue:@"" forKey:@"resVal"];
//                    
//                    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
//                    [dic setValue:productArr forKey:@"product_codes"];
//                    [dic setValue:tokenId forKey:@"token_id"];
//                    [self setDeviceToken:dic];
//                    
//                }
//                else
//                {
//                    [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                    [coursePackResp setValue:@"2" forKey:@"resStat"];
//                    [coursePackResp setValue:@"No Course code Available" forKey:@"resVal"];
//                    return coursePackResp;
//                }
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function getCoursePackInfo"];
//                [coursePackResp setValue:@"2" forKey:@"resStat"];
//                [coursePackResp setValue:@"Unknown Error" forKey:@"resVal"];
//                return coursePackResp;
//                
//            }
//        }
//        else
//        {
//            [coursePackResp setValue:@"2" forKey:@"resStat"];
//            [coursePackResp setValue:[[temp valueForKey:JSON_RETVAL]valueForKey:@"msg"] forKey:@"resVal"];
//            return coursePackResp;
//        }
//    }
//    [Logger logAduro:@"Engine : end Function getCoursePackInfo"];
//    //[courseXmlResp setValue: @"0" forKey:@"resStat"];
//    return coursePackResp;
//    
//    
//}





-(NSMutableDictionary *)getChapterDetail:(NSString*)_courseCode edge_Id:(NSString *)edgeId
{
    
    NSMutableDictionary * courseXmlResp = [[NSMutableDictionary alloc]init];
    [courseXmlResp setValue: @"0" forKey:@"resStat"];
    [courseXmlResp setValue:@"" forKey:@"resVal"];
    
    [Logger logAduro:@"Engine : start Function getChapterDetail" ];
    Utility *utility = [[Utility alloc]init:courseCode];
    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
    [ldict setValue:courseCode forKey:JSON_COURSECODE];
    [ldict setValue:edgeId forKey:JSON_EDGEID];
    
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setValue:ldict forKey:JSON_PARAM];
    [dictionary setValue: JSON_CHAPCOMPONENT_DECREE forKey:JSON_DECREE];
    
    
    [dictionary setValue:[appDelegate.global_userInfo valueForKey:DATABASE_TOKEN] forKey:JSON_TOKEN];
    
    NSError * err;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
    
    
    NSMutableDictionary * resData =[self.networkObj sendRequestToAduro:AUDRO_URL data:reqEncryptData method:@"POST" ];
    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT ])
    {
        [Logger logAduro:@"Engine : end Function getChapterDetail" ];
        return courseXmlResp;
    }
    else
    {
        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
        NSLog(@"%@",temp);
        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
        {
            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
            if(resUserData != NULL)
            {
                [courseXmlResp setValue: @"1" forKey:@"resStat"];
                [courseXmlResp setValue: [resUserData valueForKey:@"chapComponent"] forKey:@"xmlData"];
                return courseXmlResp;
                
            }
            else
            {
                [Logger logAduro:@"Engine : End Function getChapterDetail"];
                [courseXmlResp setValue: @"0" forKey:@"resStat"];
                return courseXmlResp;
            }
        }
        else
        {
            [courseXmlResp setValue: @"0" forKey:@"resStat"];
            return courseXmlResp;
        }
    }
    [Logger logAduro:@"Engine : end Function getChapterDetail"];
    [courseXmlResp setValue: @"0" forKey:@"resStat"];
    return courseXmlResp;
    
    
}


-(NSMutableDictionary *)getScenarioList:(NSString *)course_pack Topic:(NSString *) topicId
{
    return [self.dataMngntObj getCatelogData:course_pack Topic:topicId];
}
-(NSString *)getCourseName
{
    return [self.dataMngntObj getCourseName];
}
-(NSString *) getIMEINumber
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//-(BOOL)setDeviceToken:(NSDictionary * )dict
//{
//    [Logger logAduro:@"Engine : start Function setDeviceToken" ];
//    Utility *utility = [[Utility alloc]init];
//    NSMutableDictionary * ldict = [[NSMutableDictionary alloc]init];
//    [ldict setValue:[dict valueForKey:@"token_id"] forKey:@"token_value"];
//    [ldict setValue:[dict valueForKey:@"product_codes"] forKey:@"product_codes"];
//    [ldict setValue:[self getIMEINumber] forKey:@"deviceId"];
//    [ldict setValue:@"1" forKey:@"platform"];
//
//
//    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc]init];
//    [dictionary setValue:ldict forKey:JSON_PARAM];
//    [dictionary setValue: JSON_USERDEVICETOKEN_DECREE forKey:JSON_DECREE];
//
//    [dictionary setValue:[[NSString alloc] initWithFormat:@"%@",[dict valueForKey:@"token_id"]] forKey:JSON_TOKEN];
//
//    NSError * err;
//    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&err];
//    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSString *reqEncryptData = [utility encrypt:myString withKey:RC4KEYVALUE :ENCRYPT];
//    NSMutableDictionary * resData =[self.networkObj sendRequestToAduroWizIQ:AUDRO_URL data:reqEncryptData method:@"POST" ];
//    if(![[resData valueForKey:NETWORKSTATUS] isEqualToString:SUCCESSRESULT])
//    {
//        [Logger logAduro:@"Engine : end Function setDeviceToken"];
//        return false;
//    }
//    else
//    {
//
//        // NSString *newStr = [[resData valueForKey:NETWORKDATA] substringFromIndex:2];
//        NSString *resEncryptData = [utility decrypt:[resData valueForKey:NETWORKDATA] withKey:RC4KEYVALUE :ENCRYPT];
//        NSData *jsonRawData = [resEncryptData dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary * temp = [NSJSONSerialization JSONObjectWithData:jsonRawData options:0 error:nil];
//        if([[temp valueForKey:@"retCode"] isEqualToString:SUCCESSJOSN])
//        {
//            NSDictionary * resUserData = [temp valueForKey:JSON_RETVAL];
//            if(resUserData != NULL)
//            {
//                return true;
//            }
//            else
//            {
//                [Logger logAduro:@"Engine : End Function setDeviceToken"];
//                return false;
//            }
//        }
//    }
//    [Logger logAduro:@"Engine : end Function setDeviceToken"];
//    return true;
//}


-(NSMutableArray *)getAllCoursePack
{
    return [self.dataMngntObj getAllCoursePack];
}


-(NSDictionary *)getAssessmentObject:(NSString *)edgeId
{
    return [self.dataMngntObj getAssessmentObject:edgeId ];
}
-(NSDictionary *)getMCQObject:(NSString *)edgeId
{
    return [self.dataMngntObj getMCQObject:edgeId ];
}
-(NSDictionary*)getChapterMCQ:(int)scnUid
{
    return [self.dataMngntObj getChapterMCQ:scnUid];
}
-(NSMutableArray *)getWeekSpentData
{
    return [self.dataMngntObj getWeekSpentData];
}
-(NSMutableDictionary *)getDashboardDataWithType
{
    return [self.dataMngntObj getDashboardDataWithType];
}
-(NSDictionary *)getChapterData :(NSString *)edgeId
{
    return [self.dataMngntObj getChapterData:edgeId];
}
-(int)getAttemptCounter
{
    return [self.dataMngntObj getAttemptCounter];
}

-(BOOL)insertIndividualCoins:(NSDictionary *) obj
{
    return [self.dataMngntObj insertIndividualCoins:obj];
}
-(BOOL)insertCoins:(NSArray *)dataArr
{
    return [self.dataMngntObj insertCoins:dataArr];
}
-(BOOL)isPreregisteredUser
{
    return [self.dataMngntObj isPreregisteredUser];
}
-(NSDictionary *)getGSELevel :(NSString *)code
{
    return [self.dataMngntObj getGSELevel:code];
}
-(NSArray *)getChaptersDataWithSkill:(NSString *)coursePack Topic :(NSString *)topicId :(NSString *)skillId
{
    return [self.dataMngntObj getChaptersDataWithSkill:coursePack Topic:topicId:skillId];
}
-(NSDictionary *)getTopicData : (NSString *)topicId : (NSString *)courseEdgeId :(NSString *)chapterId :(NSString *)assessment_type
{
    return [self.dataMngntObj getTopicData:topicId :courseEdgeId :chapterId :assessment_type];
}
-(NSDictionary *)getTopicDataOnly : (NSString *)topicId
{
    return [self.dataMngntObj getTopicDataOnly:topicId];
}
-(NSDictionary *)getQuizOrAssementData:(NSString *)uid :(int)CatType
{
    return [self.dataMngntObj getQuizOrAssementData:uid:CatType];
}
-(BOOL)updateUser:(NSString *)user_id :(NSString *)token :(NSString *)profilePic
{
    return [self.dataMngntObj updateUser:user_id :token :profilePic];
}
-(NSMutableArray *)getAllDownloadedCoursesWithChapters:(NSString *)contentPack
{
    return [self.dataMngntObj getAllDownloadedCoursesWithChapter:contentPack];
}

-(NSMutableArray *)getChapterAndAssessmentList
{
     return [self.dataMngntObj getChapterAndAssessmentList];
}
-(NSMutableArray *)getlevelArrayFromCourses :(NSString * )contentPack
{
    return [self.dataMngntObj getlevelArrayFromCourses:contentPack];
}
-(BOOL)updateUserProfile:(NSString *)name :(NSString *)password
{
    return [self.dataMngntObj updateUserProfile:name :password];
}
@end
