
#import "Cell.h"

#import "CellData.h"


@implementation Cell

- (void)setData:(CellData *)data {
    _data = data;
    
    self.textLabel.text = data.content;
    self.textLabel.textColor = data.color;
}

@end
