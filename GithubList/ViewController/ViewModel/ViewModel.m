
#import "ViewModel.h"


#import "APIService.h"


@interface ViewModel ()

@property (nonatomic, strong) APIService *apiService;
@property (nonatomic, strong) NSArray<NSString *> *names;

@end


@implementation ViewModel

- (void)namesWith:(void (^)(void))completion {
    APIRequest *request = [APIRequest requestWith:^(APIRequestBuilder *builder) {
        builder.method = GET;
        builder.path = @"/search/repositories";
        builder.urlQuery = @{@"q": @"swift", @"page": @"1"};
    }];
    
    __weak typeof(self) weakSelf = self;
    [self.apiService requestBy:request with:^(APIResponse *response) {
        NSArray *items = response.parsedData[@"items"];
        weakSelf.names = [items valueForKeyPath:@"full_name"];
        completion();
    }];
}

- (NSInteger)numberOfNames {
    return self.names.count;
}

- (NSString *)nameAt:(NSInteger)index {
    return self.names[index];
}


- (APIService *)apiService {
    if (!_apiService) {
        _apiService = [APIService new];
    }
    return _apiService;
}

@end
