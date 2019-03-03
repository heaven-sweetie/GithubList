
@import Foundation;


NS_ASSUME_NONNULL_BEGIN

@interface ViewModel : NSObject

- (void)namesWith:(void(^)(void))completion;

@property (nonatomic, readonly) NSInteger numberOfNames;

- (NSString *)nameAt:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
