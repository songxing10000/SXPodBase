//
//  CKKBaseModel
//  dfpo
//
//  Created by dfpo on 16/11/18.
//  Copyright © 2016年 dfpo. All rights reserved.
//


@interface CKKBaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary*)dict;

+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray*)array;

/**
 根据自己生成一个字典,或者数组
 */
@property(nonatomic, readonly) NSDictionary *dict;
@end

/*
 一、数组包含对象
 
 + (NSDictionary *)modelContainerPropertyGenericClass {
 return @{@"shopfileList" : [CKKUploadImage class],
 @"shopAuthorizeList": [CKKUploadImage class],
 @"businessAddress": [ProvinceCityDistrict class]};
 }
 
 二、服务器返回description，模型上对des对应
 
 + (NSDictionary *)modelCustomPropertyMapper {
 return @{@"des": @"description"};
 }
 
 三、对象写入磁盘
 
 1、遵守协议 <NSCoding, NSCopying>
 2、implementation里导入头文件#import <YYModel.h>，写入代码
 - (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
 - initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
 - copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
 - (NSUInteger)hash { return [self yy_modelHash]; }
 - (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
 - (NSString *)description { return [self yy_modelDescription]; }
 
 */
