//
//  FHAddressBookManager.m
//  AddressBookDemo
//
//  Created by Forr on 15/10/11.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import "FHAddressBookManager.h"
#import <AddressBook/AddressBook.h>

@implementation FHAddressBookManager
/** 访问通信录 */
+ (void)accessAddressBookComplete:(void(^__nullable)(NSArray *))complete
{
    NSMutableArray *contacts = [NSMutableArray array];
    CFErrorRef error = NULL;
    ABAddressBookRef abRef = ABAddressBookCreateWithOptions(NULL , &error);
    ABAddressBookRequestAccessWithCompletion(abRef, ^(bool granted, CFErrorRef error) {
        //若授权
        if (granted)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                CFErrorRef error = NULL;
                ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL , &error);
                //获取通讯录中的所有人
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
                NSArray *allContacts = (__bridge_transfer NSArray*)allPeople;
                for (NSInteger i = 0; i < allContacts.count; i++)
                {
                    //获取联系人
                    ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
                    //获取个人名字
                    NSString *firstName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
                    NSString *lastName = (__bridge_transfer NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
                    NSString *name = [NSString stringWithFormat:@"%@%@",firstName,lastName];
                    //获取手机信息
                    ABMultiValueRef phonesRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
                    
                    FHAddressBook *addressBook = [[FHAddressBook alloc]init];
                    addressBook.name = name==nil?@"":name;
                    addressBook.telephone = [self getTelephoneProperty:phonesRef];
                    addressBook.imageData = (__bridge_transfer NSData *)ABPersonCopyImageData(person);
                    
                    [contacts addObject:addressBook];
                    if (phonesRef){
                        CFRelease(phonesRef);
                    }
                    if (person) {
                        CFRelease(person);
                    }
                }
                if (complete) {
                    complete(contacts);
                }
            });
        }
    });
}

/** 获取手机号 */
+ (NSString *)getTelephoneProperty:(ABMultiValueRef)phonesRef
{
    for (int i=0; i < ABMultiValueGetCount(phonesRef); i++) {
        CFStringRef currentPhoneLabel = ABMultiValueCopyLabelAtIndex(phonesRef, i);
        CFStringRef currentPhoneValue = ABMultiValueCopyValueAtIndex(phonesRef, i);
        
        if(currentPhoneLabel) {
            if (CFStringCompare(currentPhoneLabel, kABPersonPhoneMobileLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
            
            if (CFStringCompare(currentPhoneLabel, kABHomeLabel, 0) == kCFCompareEqualTo) {
                return (__bridge NSString *)currentPhoneValue;
            }
        }
        if(currentPhoneLabel) {
            CFRelease(currentPhoneLabel);
        }
        if(currentPhoneValue) {
            CFRelease(currentPhoneValue);
        }
    }
    return nil;
}


@end
