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

+ (void)accessAddressBookComplete:(void(^)(NSArray *))complete;

@end
