
#import "APIService.h"


NS_ASSUME_NONNULL_BEGIN

@interface APIService ()

@property (nonatomic) BOOL loading;

@property (nonatomic, strong) NSMutableArray<NSString *> *loadingURLs;

@end


@implementation APIService

- (void)requestBy:(APIRequest *)apiRequest with:(ResponseBlock)apiResponseBlock {
    NSString *urlString = apiRequest.url.absoluteString;
    if (self.isLoading && [self.loadingURLs containsObject:urlString]) {
        return;
    }
    
    self.loading = YES;
    [self.loadingURLs addObject:urlString];
    
    __weak typeof(self) weakSelf = self;
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithRequest:apiRequest.urlRequest completionHandler:
                                  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                      weakSelf.loading = NO;
                                      [weakSelf.loadingURLs removeObject:urlString];
                                      
                                      APIResponse *apiResponse = [APIResponse responseWith:^(APIResponseBuilder *builder) {
                                          builder.request = apiRequest.urlRequest;
                                          builder.response = response;
                                          builder.data = data;
                                          builder.error = error;
                                      }];
                                      dispatch_sync(dispatch_get_main_queue(), ^{
                                          apiResponseBlock(apiResponse);
                                      });
                                  }];
    [task resume];
}

- (NSMutableArray<NSString *> *)loadingURLs {
    if (!_loadingURLs) {
        _loadingURLs = [NSMutableArray array];
    }
    return _loadingURLs;
}

@end

NS_ASSUME_NONNULL_END
