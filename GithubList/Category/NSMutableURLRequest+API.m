
#import "NSMutableURLRequest+API.h"

@implementation NSMutableURLRequest (API)

- (void)addHttpHeaderFieldsFrom:(NSDictionary *)dictionary {
    NSArray *allKeys = dictionary.allKeys;
    for (NSString *key in allKeys) {
        [self addValue:dictionary[key] forHTTPHeaderField:key];
    }
}

@end
