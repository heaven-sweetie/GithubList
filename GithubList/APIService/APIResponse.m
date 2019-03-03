
#import "APIResponse.h"


NSString *const keyAPIErrorCode = @"APIErrorCode";
NSString *const keyAPIErrorType = @"APIErrorType";
NSString *const APIErrorDomain = @"APIErrorDomain";


NS_ASSUME_NONNULL_BEGIN

@implementation APIResponseBuilder
@end


@interface APIResponse ()

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy, nullable) NSURLResponse *response;
@property (nonatomic, copy, nullable) NSData *data;
@property (nonatomic, copy, nullable) NSError *error;

@end


@implementation APIResponse

- (BOOL)isSuccess {
    if (!self.response) { return NO; }
    
    if ([self.response isKindOfClass:NSHTTPURLResponse.class]) {
        NSInteger httpResponseStatusCode = ((NSHTTPURLResponse *)self.response).statusCode;
        return (httpResponseStatusCode >= 200 && httpResponseStatusCode < 300);
    }
    return YES;
}

- (NSDictionary * __nullable)parsedData {
    if (!self.data) { return nil; }
    
    NSError *error = nil;
    NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:&error];
    if (error) { return nil; }
    
    return parsedData;
}


// MARK: - Construction

- (instancetype)initWith:(APIResponseBuilder *)builder {
    self = [super init];
    if (self) {
        self.request = builder.request;
        self.response = builder.response;
        self.data = builder.data;
        self.error = builder.error;
    }
    return self;
}

+ (instancetype)responseWith:(void (^)(APIResponseBuilder *))builderBlock {
    APIResponseBuilder *builder = [APIResponseBuilder new];
    builderBlock(builder);
    return [[APIResponse alloc] initWith:builder];
}

@end

NS_ASSUME_NONNULL_END
