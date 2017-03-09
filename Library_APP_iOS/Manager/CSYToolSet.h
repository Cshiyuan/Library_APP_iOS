//
//  CSYToolSet.h
//  Library_APP_iOS
//
//  Created by chenshyiuan on 2017/3/9.
//  Copyright © 2017年 chenshyiuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookInfo.h"

@interface CSYToolSet : NSObject


+(BookInfo *)getBookInfoWithDictionary:(NSDictionary *)dictionary;

@end
