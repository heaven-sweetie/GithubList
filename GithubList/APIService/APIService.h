
@import Foundation;


#import "APIRequest.h"
#import "APIResponse.h"


typedef void (^ResponseBlock)(APIResponse *response);


NS_ASSUME_NONNULL_BEGIN

@interface APIService : NSObject

@property (nonatomic, readonly, getter=isLoading) BOOL loading;

- (void)requestBy:(APIRequest *)apiRequest with:(ResponseBlock)apiResponseBlock;

@end

NS_ASSUME_NONNULL_END
