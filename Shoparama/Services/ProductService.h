//
//  ProductService.h
//  Shoparama
//
//  Created by Daniel Valencia on 3/31/14.
//  Copyright (c) 2014 Daniel Valencia Co. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProductServiceReceivedBlock)(NSArray* result);
typedef void(^ProductServiceErrorBlock)(NSError* message);

@interface ProductService : NSObject<NSURLConnectionDelegate>

- (void)fetchSubCategoriesFor:(NSString*)parentCategoryId onSuccess:(ProductServiceReceivedBlock)successBlock onError:(ProductServiceErrorBlock)errorBlock;

@end
