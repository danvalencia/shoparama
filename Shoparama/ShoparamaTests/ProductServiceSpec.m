#import "Kiwi.h"
#import "ProductService.h"
#import "Constants.h"
#import "Typhoon.h"
#import "TyphoonTestUtils.h"
#import "MainAssembly.h"


SPEC_BEGIN(ProductServiceSpec)

__block TyphoonBlockComponentFactory* factory;

beforeAll(^{
    factory = [[TyphoonBlockComponentFactory alloc] initWithAssembly:[MainAssembly assembly]];
});

describe(@"ProductsApi", ^{
    context(@"Fetching categories", ^{
        let(productService, ^{
            return [factory componentForType:[ProductService class]];
        });
        
        it(@"should return a list of all categories", ^{
            NSString* categoryId = @"1";
            __block NSArray* categoriesArray;
            [productService fetchSubCategoriesFor:categoryId onSuccess:^(NSArray* categories){
                categoriesArray = categories;
            } onError:^(NSError* errorMessage){
                fail(@"Product Service call should have worked. Maybe service is down");
            }];
            
            [TyphoonTestUtils waitForCondition:^BOOL
             {
                 typhoon_asynch_condition(categoriesArray != nil);
             } andPerformTests:^
             {
                 NSLog(@"################### Result: %@", categoriesArray);
                 [[categoriesArray should] beNonNil];
             }];

        });
    });
});

SPEC_END