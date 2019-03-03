
#import "ViewController.h"

#import "ViewModel.h"


@interface ViewController ()
<UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ViewModel *viewModel;

@end


@implementation ViewController

// MARK: - Configure

- (void)configureData {
    __weak typeof(self) weakSelf = self;
    [self.viewModel namesWith:^{
        [weakSelf.tableView reloadData];
    }];
}

- (void)registCells {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
}


// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfNames;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [self.viewModel nameAt:indexPath.row];
    return cell;
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
    
    [self registCells];
    [self configureData];
}


@end
