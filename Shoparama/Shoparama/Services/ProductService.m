//
//  ProductService.m
//  Shoparama
//
//  Created by Daniel Valencia on 3/31/14.
//  Copyright (c) 2014 Daniel Valencia Co. All rights reserved.
//

#import "ProductService.h"
#import "TDOAuth.h"
#import "Constants.h"

@interface ProductService() {
    NSString* _productServiceHost;
    NSString* _productServiceKey;
    NSString* _productServiceSecret;
    NSString* _productServiceScheme;
    NSDictionary* _urls;
};

@end

@implementation ProductService

- (id)init
{
    self = [super init];
    if (self) {
        _productServiceHost = [[[NSBundle mainBundle] infoDictionary] valueForKey:PRODUCT_SERVICE_HOST];
        _productServiceScheme = [[[NSBundle mainBundle] infoDictionary] valueForKey:PRODUCT_SERVICE_SCHEME];
        _productServiceKey = [[[NSBundle mainBundle] infoDictionary] valueForKey:PRODUCT_SERVICE_KEY];
        _productServiceSecret = [[[NSBundle mainBundle] infoDictionary] valueForKey:PRODUCT_SERVICE_SECRET];
        _urls = @{
            @"CATEGORY": @"/test/v1/categories"
        };
    }
    return self;
}

- (void)fetchSubCategoriesFor:(NSString*)parentCategoryId onSuccess:(ProductServiceReceivedBlock)successBlock onError:(ProductServiceErrorBlock)errorBlock
{
    NSURLRequest* request = [TDOAuth URLRequestForPath:_urls[@"CATEGORY"]
                                     GETParameters:@{@"q": [NSString stringWithFormat:@"{\"parent_cat_id\":%@}", parentCategoryId]}
                                     scheme:_productServiceScheme
                                     host:_productServiceHost
                                     consumerKey:_productServiceKey
                                     consumerSecret:_productServiceSecret
                                     accessToken:nil
                                     tokenSecret:nil];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            errorBlock(connectionError);
        } else {
            NSDictionary* jsonResponse = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if ([jsonResponse[@"code"] isEqualToString:@"OK"]) {
                NSArray* subCategories = (NSArray*)jsonResponse[@"results"];
                successBlock(subCategories);
            } else {
                NSError* error = [NSError errorWithDomain:@"Error with the product service API. See user info dictionary for details." code:0 userInfo:jsonResponse];
                errorBlock(error);
            }
        }
    }];
}

@end
