// Generated with quicktype
// For more options, try https://app.quicktype.io

#import <Foundation/Foundation.h>

@class Server;
@class Content;
@class Model;
@class Status;
@class Type;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface Server : NSObject
@property (nonatomic, copy) NSArray<Content *> *content;
@property (nonatomic, assign) int totalPages;
@property (nonatomic, assign) NSInteger totalElements;
@property (nonatomic, assign) BOOL last;
@property (nonatomic, nullable, copy) id sort;
@property (nonatomic, assign) BOOL first;
@property (nonatomic, assign) NSInteger numberOfElements;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger number;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface Content : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, nullable, copy) NSString *ipAddress;
@property (nonatomic, nullable, copy) NSString *ipSubnetMask;
@property (nonatomic, strong) Model *model;
@property (nonatomic, assign) NSInteger locationID;
@property (nonatomic, strong) Status *status;
@property (nonatomic, strong) Type *type;
@property (nonatomic, nullable, copy) NSString *serialNumber;
@property (nonatomic, nullable, copy) id version;
@property (nonatomic, copy) NSArray *communicationProtocols;
@property (nonatomic, copy) NSArray *targetMachines;
@property (nonatomic, assign) NSInteger location;
@property (nonatomic, nullable, copy) id serialNum;
@end

@interface Model : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, nullable, copy) id creationDate;
@property (nonatomic, nullable, copy) id expiryDate;
@end

@interface Status : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *statusValue;
@property (nonatomic, copy) NSString *legacyValue;
@end

@interface Type : NSObject
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *name;
@end

NS_ASSUME_NONNULL_END
//
//  Server.h
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


NS_ASSUME_NONNULL_END
