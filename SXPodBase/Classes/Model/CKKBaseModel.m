//
//  CKKSJBaseModel.m
//  CKK_SJ
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//

#import "CKKBaseModel.h"
#import "YYModel.h"
@implementation CKKBaseModel

- (instancetype)initWithDictionary:(NSDictionary*)dict {
    
    __block NSDictionary *temDict = nil;
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
        temDict = dict;
    } else if ([dict isKindOfClass:[NSArray class]]) {
        
        NSLog(@"--读取数据不正确--%@--自动查找所需的字典--", self);
        [(NSArray *)dict enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSDictionary class]]) {
                
                if ([[obj allKeys] count] > [[temDict allKeys] count]) {
                
                    temDict = obj;
                }
            }
        }];
    }
    return [[self class] yy_modelWithJSON:temDict];
}

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray*)array {
    __block NSArray *temArr = nil;
    if ([array isKindOfClass:[NSArray class]]) {
        
        temArr = array;
    } else if ([array isKindOfClass:[NSDictionary class]]) {
        
        NSLog(@"--读取数据不正确--%@--自动查找所需的数组--", self);
        [(NSDictionary *)array enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[NSArray class]]) {
                
                temArr = obj;
                *stop = YES;
            }
        }];
    }
    return [NSArray yy_modelArrayWithClass:[self class] json:temArr].mutableCopy;
}
- (NSString *)description {
    return [self yy_modelDescription];
}
- (NSDictionary *)dict {
    return [self yy_modelToJSONObject];
}
@end
