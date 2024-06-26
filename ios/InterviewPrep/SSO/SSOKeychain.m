//
//  Keychain.m
//  KeyChain
//
//  Created by KH1386 on 3/10/14.
//  Copyright (c) 2014 KH1386. All rights reserved.
//

#import "SSOKeychain.h"
#import <Security/Security.h>
#import "NSSOGlobal.h"

@implementation SSOKeychain
+(id)sharedKeychain
{
    static SSOKeychain *sharedKeychain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      NSString *group = [NSString stringWithFormat:@"%@.%@",sso_teamId,KEYCHAIN_GROUP_NAME];
                      sharedKeychain = [[self alloc] initWithService:KEYCHAIN_SERVICE_NAME withGroup:group];
                  });
    return sharedKeychain;
}

-(id) initWithService:(NSString *) service_
            withGroup:(NSString*)group_
{
    self =[super init];
    if(self)
    {
        service = [NSString stringWithString:service_];
        if(group_)
        {
            group = [NSString stringWithString:group_];
        }
    }
    return  self;
}

-(NSMutableDictionary*) prepareDict:(NSString *) key
{
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    
    NSData *encodedKey = [key dataUsingEncoding:NSUTF8StringEncoding];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrGeneric];
    [dict setObject:encodedKey forKey:(__bridge id)kSecAttrAccount];
    [dict setObject:service forKey:(__bridge id)kSecAttrService];
    [dict setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    
    //This is for sharing data across apps
    if(group != nil)
        [dict setObject:group forKey:(__bridge id)kSecAttrAccessGroup];
    
    return  dict;
    
}
-(BOOL) insert:(NSString *)key : (NSData *)data
{
    NSMutableDictionary * dict =[self prepareDict:key];
    [dict setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
    if(errSecSuccess != status) {
        NSLog(@"Unable add item with key = %@ error:%d",key,status);
        
    }
    return (errSecSuccess == status);
}
-(NSString*) find:(NSString*)key //origionally returned NSData
{
    NSMutableDictionary *dict = [self prepareDict:key];
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict,&result);
    
    if( status != errSecSuccess)
    {
        if(status == -25300)
        {
            printf("%s : not found in keychain\n",[key UTF8String]);
        }
        else
        {
            NSLog(@"Find: Unable to fetch item for key %@ with error:%d",key,status);
        }
        return @"";
    }
    return [[NSString alloc] initWithData:(__bridge NSData *)result encoding:NSUTF8StringEncoding];
}

-(BOOL) update:(NSString*)key :(NSData*) data
{
    NSMutableDictionary * dictKey =[self prepareDict:key];
    
    NSMutableDictionary * dictUpdate =[[NSMutableDictionary alloc] init];
    [dictUpdate setObject:data forKey:(__bridge id)kSecValueData];
    
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)dictKey, (__bridge CFDictionaryRef)dictUpdate);
    if(errSecSuccess != status)
    {
        NSLog(@"Unable add update with key =%@ error:%d",key,status);
    }
    return (errSecSuccess == status);
    
    
    return YES;
    
}
-(BOOL) remove: (NSString*)key
{
    NSMutableDictionary *dict = [self prepareDict:key];
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);
    
    if( status != errSecSuccess)
    {
        if(status == -25300)
        {
            printf("%s : not found in keychain\n",[key UTF8String]);
        }
        else
        {
            NSLog(@"Unable to remove item for key %@ with error:%d",key,status);
        }
        return NO;
    }
    return  YES;
}

@end
