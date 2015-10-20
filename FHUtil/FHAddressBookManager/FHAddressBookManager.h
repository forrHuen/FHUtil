//
//  FHAddressBookManager.h
//  AddressBookDemo
//
//  Created by Forr on 15/10/11.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FHAddressBook.h"

@interface FHAddressBookManager : NSObject
/**
 *  访问本地通讯录，获取通讯录列表
 *
 *  @param complete 回调内容，存储FHAddressBook模型的数组
 */
+ (void)accessAddressBookComplete:(void(^)(NSArray *))complete;

@end
