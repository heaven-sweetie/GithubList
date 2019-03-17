
@import UIKit;


NS_ASSUME_NONNULL_BEGIN

@interface CellData : NSObject

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, readonly) NSString *identifier;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) UIColor *color;

@end

NS_ASSUME_NONNULL_END
