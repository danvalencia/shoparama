#import "Kiwi.h"
#import "ProductService.h"

SPEC_BEGIN(ProductServiceSpec)

describe(@"ProductsApi", ^{
    context(@"Fetching categories", ^{
        let(productsApi, ^{
            return [[ProductService alloc] init];
        });
        
        it(@"should return a list of all categories", ^{
            [[productsApi shouldNot] beNil];
        });
    });
});

SPEC_END