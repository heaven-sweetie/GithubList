
@import Foundation;


extern NSString *const keyAPIErrorCode;
extern NSString *const keyAPIErrorType;
extern NSString *const APIErrorDomain;


NS_ASSUME_NONNULL_BEGIN

@interface APIResponseBuilder : NSObject

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy, nullable) NSURLResponse *response;
@property (nonatomic, copy, nullable) NSData *data;
@property (nonatomic, copy, nullable) NSError *error;

@end


@interface APIResponse : NSObject

@property (nonatomic, readonly, getter=isSuccess) BOOL success;
@property (nonatomic, nullable, readonly) NSDictionary *parsedData;
@property (nonatomic, nullable, readonly) NSError *error;

+ (instancetype)responseWith:(void (^)(APIResponseBuilder *builder))builderBlock;

@end

NS_ASSUME_NONNULL_END
