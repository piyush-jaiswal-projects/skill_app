#import "NSString+AESCrypt.h"

@implementation NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key {
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}

- (NSString *)AES256DecryptWithKey:(NSString *)key {
    //NSData* encryptedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}

- (NSString *)AES128EncryptedDataWithKey:(NSString *)key {
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES128EncryptedDataWithKey:key];
    //NSString *encryptedString = [[NSString alloc] initWithData:encryptedData encoding:NSUTF8StringEncoding];
    NSString *encryptedString = [encryptedData base64Encoding];
    return encryptedString;
}

- (NSString *)AES128DecryptedDataWithKey:(NSString *)key {
    //NSData* encryptedData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES128DecryptedDataWithKey:key];
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    return plainString;
}




@end
