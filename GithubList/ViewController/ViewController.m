
#import "ViewController.h"

#import "ViewModel.h"
#import "CellData.h"
#import "Cell.h"


@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ViewModel *viewModel;
@property (nonatomic, strong) NSArray<CellData *> *cellDataList;

@end


@implementation ViewController

// MARK: - Configure

- (void)configureData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel namesWith:^(NSArray<NSString *> *names) {
        __block NSMutableArray *cellDataList = [NSMutableArray array];
        [names enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
            CellData *cellObject = [CellData new];
            cellObject.cellClass = Cell.class;
            cellObject.content = name;
            [cellDataList addObject:cellObject];
        }];
        weakSelf.cellDataList = cellDataList;
        [weakSelf registCells];
        
        [weakSelf.tableView reloadData];
    }];
}

- (void)registCells {
    [self.cellDataList enumerateObjectsUsingBlock:^(CellData *data, NSUInteger idx, BOOL *stop) {
        [self.tableView registerClass:data.cellClass forCellReuseIdentifier:data.identifier];
    }];
}


// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellData *cellData = self.cellDataList[indexPath.row];
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellData.identifier forIndexPath:indexPath];
    cell.data = cellData;
    return cell;
}


// MARK: - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellDataList[indexPath.row].height;
}


// MARK: - Lazy

- (ViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [ViewModel new];
    }
    return _viewModel;
}


// MARK: - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureData];
}


@end
