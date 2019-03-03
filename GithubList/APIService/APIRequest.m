
#import "APIRequest.h"

#import "NSDictionary+API.h"
#import "NSMutableURLRequest+API.h"


NS_ASSUME_NONNULL_BEGIN

@implementation APIRequestBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        self.base = @"api.github.com";
    }
    return self;
}

@end


@interface APIRequest ()

@property (nonatomic) HTTPMethod method;
@property (nonatomic, copy) NSString *base;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, nullable, copy) NSDictionary *header;
@property (nonatomic, nullable, copy) NSDictionary *urlQuery;
@property (nonatomic, nullable, copy) NSDictionary *body;

@end


@implementation APIRequest

- (NSURL *)url {
    NSString *const schemeHTTPS = @"https";
    
    NSString *const formatURLWithSchemeBasePath = @"%@://%@%@";
    NSString *const formatURLWithSchemeBasePathQuery = @"%@://%@%@?%@";
    
    NSString *urlString = nil;
    if (self.method == GET && self.urlQuery) {
        urlString = [NSString stringWithFormat:formatURLWithSchemeBasePathQuery,
                     schemeHTTPS, self.base, self.path, self.urlQuery.httpURLQuery];
    } else {
        urlString = [NSString stringWithFormat:formatURLWithSchemeBasePath, schemeHTTPS, self.base, self.path];
    }
    return [NSURL URLWithString:urlString];
}

- (NSURLRequest *)urlRequest {
    NSTimeInterval const timeoutInterval = 15.f;
    
    NSMutableURLRequest *reqeust = [[NSMutableURLRequest alloc] initWithURL:self.url
                                                                cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                            timeoutInterval:timeoutInterval];
    reqeust.HTTPMethod = [APIRequest methodStringBy:self.method];
    
    if (self.header) {
        [reqeust addHttpHeaderFieldsFrom:self.header];
    }
    if (self.method == POST) {
        NSData *data = self.body.encodePOSTData;
        NSString *length = [@(data.length) stringValue];
        [reqeust setValue:length forHTTPHeaderField:@"Content-length"];
        [reqeust setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [reqeust setHTTPBody:data];
    }
    return reqeust;
}

+ (NSString *)methodStringBy:(HTTPMethod)method {
    switch (method) {
        case POST:
            return @"POST";
        case GET:
        default:
            return @"GET";
    }
}


// MARK: - Construction

- (instancetype)initWith:(APIRequestBuilder *)builder {
    self = [super init];
    if (self) {
        self.method = builder.method;
        self.base = builder.base;
        self.path = builder.path;
        self.header = builder.header;
        self.urlQuery = builder.urlQuery;
        self.body = builder.body;
    }
    return self;
}

+ (instancetype)requestWith:(void (^)(APIRequestBuilder *))builderBlock {
    APIRequestBuilder *builder = [APIRequestBuilder new];
    builderBlock(builder);
    return [[APIRequest alloc] initWith:builder];
}

@end



NS_ASSUME_NONNULL_END
