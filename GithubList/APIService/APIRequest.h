
@import Foundation;


typedef NS_ENUM(NSUInteger, HTTPMethod){
    GET, POST
};


NS_ASSUME_NONNULL_BEGIN


@interface APIRequestBuilder : NSObject

@property (nonatomic) HTTPMethod method;
@property (nonatomic, copy) NSString *base;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, nullable, copy) NSDictionary *header;
@property (nonatomic, nullable, copy) NSDictionary *urlQuery;       //  To use GET
@property (nonatomic, nullable, copy) NSDictionary *body;           //  To use POST

@end


@interface APIRequest : NSObject

@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, readonly) NSURLRequest *urlRequest;

+ (instancetype)requestWith:(void (^)(APIRequestBuilder *builder))builderBlock;

@end

NS_ASSUME_NONNULL_END
