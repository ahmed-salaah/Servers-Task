//
//  WebServiceCalling.h
//
//  Created by Ahmed Salah on 4/13/14.
//  Copyright (c) 2014 ITWorx. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface WebServiceCalling : MKNetworkEngine
{
    MKNetworkOperation *operation;
    NSDictionary *responseDic;
    NSString *requestURL, *DicKey;
    NSMutableDictionary *cashedDic;
}

typedef enum REQUESTED_ENUM {
    login,
  
} REQUESTED_ENUM;

typedef void (^DataResponseBlock)(NSData *responseData);
typedef void (^DataResponseParsingBlock)(id responseData);

@property (nonatomic, readwrite) REQUESTED_ENUM myRequest;
@property (nonatomic, assign)BOOL download;

-(id)initWithURLString:(REQUESTED_ENUM)url withID:(NSString *)idString andDomainURL:(NSString *)domainURL;
-(void)getData:(DataResponseParsingBlock)completionBlock;

-(void)postData:(DataResponseParsingBlock)completionBlock;
-(void)fileDownloadWithUrl:(NSString*)url andfileName:(NSString*)output;
-(MKNetworkOperation*)downloadFile:(NSString*)url andfileName:(NSString*)output;
-(MKNetworkOperation*)getWithUrl:(NSString*) url completionHandler:(DataResponseBlock)completionBlock errorHandler:(MKNKErrorBlock) errorBlock;
-(MKNetworkOperation*)postWithUrl:(NSString*) url andParamsDic:(NSDictionary *)paramsDict andHeaders:(NSDictionary *)httpHeaders completionHandler:(DataResponseBlock)completionBlock errorHandler:(MKNKErrorBlock) errorBlock;
-(void)postDataWithCompletionBlock:(DataResponseParsingBlock)completionBlock andParamsDic:(NSDictionary *)paramsDict andHeaders:(NSDictionary *)httpHeaders;
@end
