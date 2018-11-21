//
//  WebServiceCalling.m
//
//  Created by Ahmed Salah on 4/13/14.
//  Copyright (c) 2014 ITWorx. All rights reserved.
//

#import "WebServiceCalling.h"


@implementation WebServiceCalling

-(id)initWithURLString:(REQUESTED_ENUM)url withID:(NSString *)idString andDomainURL:(NSString *)domainURL{

    if (self = [super initWithHostName:domainURL]) {
        self.myRequest = url;
        switch (url) {
            case login:{
                requestURL = [NSString stringWithFormat:KGetMachines,idString,@"10"];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (MKNetworkOperation*)downloadFile:(NSString*)url andfileName:(NSString*)output {
   
//    NSString* fullPath = [BooksFolderInDocuments stringByAppendingPathComponent:output];
//    [[NSURL URLWithString:fullPath] setResourceValue: [ NSNumber numberWithBool: YES ] forKey: NSURLIsExcludedFromBackupKey error: nil ];
//    MKNetworkOperation *op = [self operationWithURLString:url params:nil httpMethod:@"GET"];
//    [op addDownloadStream:[NSOutputStream outputStreamToFileAtPath:fullPath append:NO]];
//    return op;
    return nil;
}

-(MKNetworkOperation*)getWithUrl:(NSString*) url completionHandler:(DataResponseBlock)completionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    MKNetworkOperation *op = [self operationWithPath:[self encodeURL:url]
                                              params:nil
                                          httpMethod:@"GET" ssl:YES];
    
    [op setUsername:KUserName password:KPassword basicAuth:YES];
    
    op.shouldContinueWithInvalidCertificate = YES;
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
        NSData *responsedata = [completedOperation responseData];
        completionBlock(responsedata);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {

         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation*)postWithUrl:(NSString*) url andParamsDic:(NSDictionary *)paramsDict andHeaders:(NSDictionary *)httpHeaders completionHandler:(DataResponseBlock)completionBlock errorHandler:(MKNKErrorBlock) errorBlock{
    MKNetworkOperation *op = [self operationWithPath:[self encodeURL:url]
                                              params:paramsDict
                                          httpMethod:@"POST"];
    [op addHeaders:httpHeaders];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
         NSData *responsedata = [completedOperation responseData];
         completionBlock(responsedata);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
         errorBlock(error);
     }];
    
    [self enqueueOperation:op];
    
    return op;
}
-(NSString *)encodeURL:(NSString *)url{
//    NSString* escapedUrlString = [url stringByAddingPercentEncodingWithAllowedCharacters :[NSCharacterSet URLHostAllowedCharacterSet]];
    return url;
}


-(void)getData:(DataResponseParsingBlock)completionBlock{

//    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD showWithStatus: @"Loading..."];
    __block NSMutableArray *responseArr = [NSMutableArray array];
    if ([self checkConnection]) {
        operation =  [self getWithUrl:requestURL completionHandler:^(NSData *responseData) {
            [SVProgressHUD dismiss];
            Server *server = [Server fromData:responseData error:nil];
            
            completionBlock(server);
        } errorHandler:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"Something failed"];
//            completionBlock(responseArr);
        }];
    }else{

        [SVProgressHUD dismiss];
     
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                    subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                        type:TSMessageNotificationTypeError];
        completionBlock(responseArr);
    }


}

-(void)postDataWithCompletionBlock:(DataResponseParsingBlock)completionBlock andParamsDic:(NSDictionary *)paramsDict andHeaders:(NSDictionary *)httpHeaders{

    __block NSMutableArray *responseArr = [NSMutableArray array];    
    if ([self checkConnection]) {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];

        [SVProgressHUD showWithStatus: @"Loading..."];
        
        operation = [self operationWithPath:requestURL
                                     params:paramsDict
                                 httpMethod:@"POST" ssl:NO];
        operation.shouldContinueWithInvalidCertificate = YES;
        [operation addHeaders:httpHeaders];
        operation.postDataEncoding = MKNKPostDataEncodingTypeJSON;
        [operation addCompletionHandler:^(MKNetworkOperation *completedOperation)
         {
            
//             NSData *responsedata = [completedOperation responseData];
             
             completionBlock(responseArr);
             
         }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
             [SVProgressHUD showErrorWithStatus:@"Something failed"];
             
         }];
        
        [self enqueueOperation:operation];
        
    }else{
        if (![self checkConnection] ) {
            [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                        subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                            type:TSMessageNotificationTypeError];
        }
        
    
        completionBlock(responseArr);
    }
}



-(BOOL)checkConnection{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
-(void)postData:(DataResponseParsingBlock)completionBlock{
    
}
-(void)fileDownloadWithUrl:(NSString*)url andfileName:(NSString*)output{
    operation = [self downloadFile:url andfileName:output];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
    }];

}

@end
