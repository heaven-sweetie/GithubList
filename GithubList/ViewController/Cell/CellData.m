
#import "CellData.h"


@interface CellData ()

@property (nonatomic, readonly, getter=isHighlight) BOOL isHighlight;

@end


@implementation CellData

- (NSString *)identifier {
    return NSStringFromClass(self.cellClass);
}

- (CGFloat)height {
    if (self.isHighlight) {
        return 100.0;
    }
    return 60.0;
}

- (UIColor *)color {
    if (self.isHighlight) {
        return UIColor.redColor;
    } else {
        return UIColor.blackColor;
    }
}

- (BOOL)isHighlight {
    return [self.content containsString:@"apple"] || [self.content containsString:@"realm"];
}

@end
