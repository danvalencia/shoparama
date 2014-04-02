//
//  MainAssembly.m
//  Shoparama
//
//  Created by Daniel Valencia on 4/2/14.
//  Copyright (c) 2014 Daniel Valencia Co. All rights reserved.
//

#import "MainAssembly.h"
#import "ProductService.h"

@implementation MainAssembly

- (id)productService
{
    return [TyphoonDefinition withClass:[ProductService class]];
}

@end
