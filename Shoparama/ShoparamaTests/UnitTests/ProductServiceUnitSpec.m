#import "Kiwi.h"
#import "ProductService.h"
#import "Constants.h"
#import "Typhoon.h"
#import "MainAssembly.h"



SPEC_BEGIN(ProductServiceUnitSpec)

__block TyphoonBlockComponentFactory* factory;

beforeAll(^{
    factory = [[TyphoonBlockComponentFactory alloc] initWithAssembly:[MainAssembly assembly]];
});

describe(@"ProductsApi", ^{
    context(@"Fetching categories", ^{
        let(productService, ^{
            return [factory componentForType:[ProductService class]];
        });
        
        it(@"should return a list of all top level categories if response is successfull", ^{
            [NSURLConnection stub:@selector(sendAsynchronousRequest:queue:completionHandler:)];
            KWCaptureSpy* spy = [NSURLConnection captureArgument:@selector(sendAsynchronousRequest:queue:completionHandler:) atIndex:2];
            
            [productService fetchSubCategoriesFor:@"1" onSuccess:^(NSArray* categories){
                [[categories should] beNonNil];
                [[theValue([categories count]) should] equal:theValue(1)];
            } onError:^(NSError* errorMessage){
                fail(@"Product Service call should have worked. Maybe service is down");
            }];
            
            NSString* jsonResponse = @"{\"code\":\"OK\", \"results\":[{\"cat_id\":\"11932\",\"name\":\"Video Games\"}]}";
            
            NSData* jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
            void (^completionBlock)(NSURLResponse *response, NSData *data, NSError *connectionError) = spy.argument;
            completionBlock(nil, jsonData, nil);
        });
    });
});

SPEC_END