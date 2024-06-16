//
//  Keychain.h
//  KeyChain
//
//  Created by KH1386 on 3/10/14.
//  Copyright (c) 2014 KH1386. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSOKeychain : NSObject
{
    NSString * service;
    NSString * group;
}

+(id)sharedKeychain;
-(id) initWithService:(NSString *) service_
            withGroup:(NSString*)group_;

-(BOOL) insert:(NSString *)key : (NSData *)data;
-(BOOL) update:(NSString*)key :(NSData*) data;
-(BOOL) remove: (NSString*)key;
-(NSString*) find:(NSString*)key;
@end
