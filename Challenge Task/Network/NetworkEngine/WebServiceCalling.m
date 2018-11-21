//
//  WebServiceCalling.m
//  Qiyas
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
                requestURL = KLogin;
                break;
            }case signUp:{
                requestURL = KSignUp;
                break;
            }case Products:{
                requestURL = KProducts;
                break;
            }case Dog:{
                requestURL = [NSString stringWithFormat:KProductsByCategory,idString];
                break;
            }case MostSold:{
                requestURL = KMostSeller;
                break;
            }case DogFood:{

                requestURL = [NSString stringWithFormat:KProductsByCategory ,idString];

                break;
            }case Treat:{
    
                requestURL = [NSString stringWithFormat:KProductsByCategory ,idString];

                break;
            }case Rawhid:{
                requestURL = [NSString stringWithFormat:KProductsByCategory ,idString];
                break;
            }case Supplement:{
                requestURL = [NSString stringWithFormat:KProductsByCategory,idString];
                break;
            }
            case FleasAndTick:{
                requestURL = [NSString stringWithFormat:KProductsByCategory,idString];
                break;
            }
            case Shampoo:{
                requestURL = [NSString stringWithFormat:KProductsByCategory,idString];
                break;
            }case Brunche:{
                requestURL = [NSString stringWithFormat:KProductsByCategory,idString];
                break;
            }
            case User:{
                requestURL = [NSString stringWithFormat:KUserByID,idString];
                break;
            }
            case AddToFav:{
                requestURL = KAddToFavorit;
                break;
            }
            case RemoveFromFav:{
                requestURL = KRemoveUserFavourites;
                break;
            }
            case Search:{
                requestURL = [NSString stringWithFormat:KSearch,idString];
                break;
            }
            case Tips:{
                requestURL = KTips;
                break;
            }
            case Custom:{
                requestURL = KCustomOrder;
                break;
            }
            case UserFavorits:{
                requestURL = [NSString stringWithFormat:KUserFavorits,idString];
                break;
            }
            case ForgotPass:{
                requestURL = [NSString stringWithFormat:KforgetPassword,idString];
                break;
            }
            case NewOrder:{
                requestURL = KNewOrder;
                break;
            }
            case Adds:{
                requestURL = KAdds;
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
                                          httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation)
     {
        NSData *responsedata = [completedOperation responseData];
        completionBlock(responsedata);
         
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
//         [SVProgressHUD showErrorWithStatus:@"تعذر الاتصال بالسيرفر"];
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

- (NSMutableArray *)mappingResponse {
    NSMutableArray *responseArr = [NSMutableArray array];
    NSArray *arr = [NSArray array];
    switch (self.myRequest){
        case login:
        {
            if ([[responseDic jsonObjectForKey:@"loginResult"]jsonObjectForKey:@"Data"]) {
                [responseArr addObject:[[responseDic jsonObjectForKey:@"loginResult"]jsonObjectForKey:@"Data"]];
            }
            break;
        }
        case signUp:
        {
            if ([[responseDic jsonObjectForKey:@"registerResult"]jsonObjectForKey:@"Data"])
                [responseArr addObject:[[responseDic jsonObjectForKey:@"registerResult"]jsonObjectForKey:@"Data"]];
            
            break;
        }
        case User:{
            if ([[responseDic jsonObjectForKey:@"GetUserByIdResult"] jsonObjectForKey:@"Data"]) {
                [responseArr addObject:[[responseDic jsonObjectForKey:@"GetUserByIdResult"] jsonObjectForKey:@"Data"]];
            }
            
        }
        case Products:
        {
            arr = [[responseDic jsonObjectForKey:@"ShowAllProductsExceptPuppiesResult" ]jsonObjectForKey:@"Data"] ;
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case MostSold:
        {
            arr = [[responseDic jsonObjectForKey:@"Most20SellerResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Dog:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult" ]jsonObjectForKey:@"Data" ];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case DogFood:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"]jsonObjectForKey:@"Data" ] ;
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Treat:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"]jsonObjectForKey: @"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Rawhid:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Supplement:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case FleasAndTick:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Shampoo:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Brunche:
        {
            arr = [[responseDic jsonObjectForKey:@"GetProductByCategoryIdResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case UserFavorits:
        {
            arr = [[responseDic jsonObjectForKey:@"ShowUserfavouritesResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Search:
        {
            arr = [[responseDic jsonObjectForKey:@"SearchProductByNameResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                ProductModel *model = [[ProductModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Tips:
        {
            arr = [[responseDic jsonObjectForKey:@"ShowTipsResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                TipsModel *model = [[TipsModel alloc]initWithData:dic];
                [responseArr addObject:model];
            }
            break;
        }
        case Adds:
        {
            arr = [[responseDic jsonObjectForKey:@"ShowAllAddsResult"] jsonObjectForKey:@"Data"];
            for (NSDictionary *dic in arr) {
                AdsData *model = [[AdsData alloc]initWithDictionary:dic];
                [responseArr addObject:model];
            }
            break;
        }
        default:
            break;
    }
    return responseArr;
}

-(void)getData:(DataResponseParsingBlock)completionBlock{

    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    __block NSMutableArray *responseArr = [NSMutableArray array];
    if ([self checkConnection]) {
        operation =  [self getWithUrl:requestURL completionHandler:^(NSData *responseData) {
            [SVProgressHUD dismiss];
            SBJSON* parser = [[SBJSON alloc] init];
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseData
                                                                 options:kNilOptions
                                                                   error:nil];
            NSString *response = [parser stringWithObject:dic];
            responseDic = [parser objectWithString:response error:nil];
            responseArr = [self mappingResponse];
//            [ApplicationDelegate WriteToCachedDictionary:responseDic withName:DicKey];
            completionBlock(responseArr);
        } errorHandler:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"Something failed"];
//            responseDic =[[ApplicationDelegate cachedDic] objectForKey:DicKey];
            responseArr = [self mappingResponse];
            completionBlock(responseArr);
        }];
    }else{
//        [SVProgressHUD showErrorWithStatus:@"تعذر الاتصال بالانترنت"];
        [SVProgressHUD dismiss];
     
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                    subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                        type:TSMessageNotificationTypeError];
//        responseDic =[[ApplicationDelegate cachedDic] objectForKey:DicKey];
        responseArr = [self mappingResponse];
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
             if (self.myRequest != NewOrder && self.myRequest != ForgotPass && self.myRequest != Custom) {
                 [SVProgressHUD dismiss];
             }
             NSData *responsedata = [completedOperation responseData];
             SBJSON* parser = [[SBJSON alloc] init];
             NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responsedata
                                                                 options:kNilOptions
                                                                   error:nil];
             NSString *response = [parser stringWithObject:dic];
             responseDic = [parser objectWithString:response error:nil];
             
             responseArr = [self mappingResponse];
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
        
    
        responseArr = [self mappingResponse];
        completionBlock(responseArr);
    }
}


-(void)getDataForAds:(DataResponseParsingBlock)completionBlock{
    __block NSMutableArray *responseArr = [NSMutableArray array];
    if ([self checkConnection]) {
        operation =  [self getWithUrl:requestURL completionHandler:^(NSData *responseData) {

            SBJSON* parser = [[SBJSON alloc] init];
            NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:responseData
                                                                options:kNilOptions
                                                                  error:nil];
            NSString *response = [parser stringWithObject:dic];
            responseDic = [parser objectWithString:response error:nil];
            responseArr = [self mappingResponse];
//            [ApplicationDelegate WriteToCachedDictionary:responseDic withName:DicKey];
            completionBlock(responseArr);
        } errorHandler:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"Something failed"];
//            responseDic =[[ApplicationDelegate cachedDic] objectForKey:DicKey];
            responseArr = [self mappingResponse];
            completionBlock(responseArr);
        }];
    }else{
       
        [SVProgressHUD dismiss];
        
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Something failed", nil)
                                    subtitle:NSLocalizedString(@"The internet connection seems to be down. Please check that!", nil)
                                        type:TSMessageNotificationTypeError];
//        responseDic =[[ApplicationDelegate cachedDic] objectForKey:DicKey];
        responseArr = [self mappingResponse];
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
