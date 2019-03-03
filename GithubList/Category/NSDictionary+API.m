
#import "NSDictionary+API.h"

@implementation NSDictionary (API)

- (NSString *)httpURLQuery {
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSArray *keys = self.allKeys;
    for (NSString *key in keys) {
        id value = self[key];
        if ([value isKindOfClass:NSString.class]) {
            value = [value stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
        }
        NSString *queryString = [NSString stringWithFormat:@"%@=%@", key, value];
        [queryItems addObject:queryString];
    }
    
    return [queryItems componentsJoinedByString:@"&"];
}

- (NSData *)encodePOSTData {
    NSMutableArray *parts = [NSMutableArray array];
    for (NSString *key in self) {
        NSString *newValue = self[key];
        id value = self[key];
        if ([value isKindOfClass:NSArray.class]) {
            newValue = [value componentsJoinedByString:@","];
        }
        if ([value isKindOfClass:NSNumber.class]) {
            newValue = [NSString stringWithFormat:@"%@", value];
        }
        if ([value isKindOfClass:NSDictionary.class]) {
            continue;
        }
        NSString *encodedValue = [newValue stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet];
        NSString *encodedKey = [key stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.alphanumericCharacterSet];
        
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    NSLog(@"%@", encodedDictionary);
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

@end
