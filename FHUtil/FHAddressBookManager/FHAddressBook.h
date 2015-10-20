//
//  FHAddressBook.h
//  AddressBookTest
//
//  Created by Forr on 15/10/11.
//  Copyright © 2015年 Forr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FHAddressBook : NSObject
/** 姓名 */
@property (nonatomic , copy) NSString *name;
/** 手机号码 */
@property (nonatomic , copy) NSString *telephone;
/** 图片data */
@property (nonatomic , strong) NSData *imageData;

@end
