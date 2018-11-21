//
//  Server.m
//  Challenge Task
//
//  Created by Ahmed Salah on 11/19/18.
//  Copyright © 2018 Ahmed Salah. All rights reserved.
//

#import "Server.h"

#define λ(decl, expr) (^(decl) { return (expr); })
#define NSNullify(x) ([x isNotEqualTo:[NSNull null]] ? x : [NSNull null])

NS_ASSUME_NONNULL_BEGIN

@interface Server (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface Content (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface Model (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface Status (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface Type (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:[NSArray class]]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:[NSDictionary class]]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

Server *_Nullable ServerFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        if (json  ==  nil) {
            return nil;
        }
        return [Server fromJSONDictionary:json];
//        return *error ? nil : [Server fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

Server *_Nullable ServerFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return ServerFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable ServerToData(Server *Server, NSError **error)
{
    @try {
        id json = [Server JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable ServerToJSON(Server *Server, NSStringEncoding encoding, NSError **error)
{
    NSData *data = ServerToData(Server, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation Server
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"content": @"content",
        @"totalPages": @"totalPages",
        @"totalElements": @"totalElements",
        @"last": @"last",
        @"sort": @"sort",
        @"first": @"first",
        @"numberOfElements": @"numberOfElements",
        @"size": @"size",
        @"number": @"number",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return ServerFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ServerFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Server alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _content = map(_content, λ(id x, [Content fromJSONDictionary:x]));
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Server.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"content": map(_content, λ(id x, [x JSONDictionary])),
        @"last": _last ? @YES : @NO,
        @"first": _first ? @YES : @NO,
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return ServerToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return ServerToJSON(self, encoding, error);
}
@end

@implementation Content
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"id",
        @"name": @"name",
        @"ipAddress": @"ipAddress",
        @"ipSubnetMask": @"ipSubnetMask",
        @"model": @"model",
        @"locationId": @"locationID",
        @"status": @"status",
        @"type": @"type",
        @"serialNumber": @"serialNumber",
        @"version": @"version",
        @"communicationProtocols": @"communicationProtocols",
        @"targetMachines": @"targetMachines",
        @"location": @"location",
        @"serialNum": @"serialNum",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Content alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _model = [Model fromJSONDictionary:(id)_model];
        _status = [Status fromJSONDictionary:(id)_status];
        _type = [Type fromJSONDictionary:(id)_type];
    }
    return self;
}

-(void)setValue:(nullable id)value forKey:(NSString *)key
{
    [super setValue:value forKey:Content.properties[key]];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:Content.properties.allValues] mutableCopy];

    for (id jsonName in Content.properties) {
        id propertyName = Content.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"model": [_model JSONDictionary],
        @"status": [_status JSONDictionary],
        @"type": [_type JSONDictionary],
    }];

    return dict;
}
@end

@implementation Model
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"id",
        @"name": @"name",
        @"creationDate": @"creationDate",
        @"expiryDate": @"expiryDate",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Model alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:Model.properties.allValues];
}
@end

@implementation Status
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"id",
        @"statusValue": @"statusValue",
        @"legacyValue": @"legacyValue",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Status alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:Status.properties.allValues];
}
@end

@implementation Type
+(NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"id": @"id",
        @"name": @"name",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[Type alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:Type.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END

