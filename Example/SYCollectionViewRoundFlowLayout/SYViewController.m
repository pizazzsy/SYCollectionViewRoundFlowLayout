//
//  SYViewController.m
//  SYCollectionViewRoundFlowLayout
//
//  Created by sy on 02/01/2023.
//  Copyright (c) 2023 sy. All rights reserved.
//

#import "SYViewController.h"
#import "SYExampleViewController.h"

@interface SYViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSArray *myCellTitleArr;
@end

@implementation SYViewController
-(UITableView*)myTableView{
    if(!_myTableView){
        _myTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        _myTableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _myTableView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self creatUI];
}
-(void)creatUI{
    [self.view addSubview:self.myTableView];
}
-(void)initData{
    _myCellTitleArr = [NSArray arrayWithObjects:
                    @"CollectionView（包住section圆角）",
                    @"有Header&Footer，包Header,不包Footer",
                    @"有Header&Footer，包Header,包Footer",
                    @"有Header&Footer，不包Header,包Footer",
                    @"CollectionView（包住section圆角）(横向)",
                    @"CollectionView (横向 有H&F View)",
                    @"borderLine 包Section",
                    @"borderLine 包Section（带投影）",
                    @"BackgroundColor 底色（带投影）",
                    @"CollectionView（底色 圆角 分别不同颜色）",
                    @"CollectionView（单独设置某个 header 底色）",
                    @"CollectionView（单独设置某个 footer 底色）",
                    @"有H&F，Cell为0，判断是否计算H&F",
                    
#pragma mark - alignment
                    @"CollectionView,无sections底色，cell左对齐",
                    @"CollectionView,有sections底色，cell左对齐",
                    @"CollectionView,无sections底色，cell居中",
                    @"CollectionView,无sections底色，cell右对齐",
                    @"CollectionView,cell右对齐与cell右侧开始",
                    
#pragma mark - touch
                    @"CollectionView,背景图点击事件响应",
                    @"CollectionView,背景图点按动画",
                    nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - delegate , dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.myCellTitleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = _myCellTitleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SYExampleViewController *VC = [[SYExampleViewController alloc]init];


    switch (indexPath.row) {
        case 0:
            //CollectionView（包住section圆角）
            VC.isHaveHeaderFooterView = NO;
            break;
        case 1:
            //有Header&Footer，包Header,不包Footer
            VC.isHaveHeaderFooterView = YES;
            VC.isRoundWithHeaerView = YES;
            break;
        case 2:
            //有Header&Footer，包Header,包Footer
            VC.isHaveHeaderFooterView = YES;
            VC.isRoundWithHeaerView = YES;
            VC.isRoundWithFooterView = YES;
            break;
        case 3:
            //有Header&Footer，不包Header,包Footer
            VC.isHaveHeaderFooterView = YES;
            VC.isRoundWithFooterView = YES;
            break;
        case 4:
            //CollectionView（包住section圆角）(横向)
            VC.isHaveHeaderFooterView = NO;
            VC.isHorizontal = YES;
            break;
        case 5:
            //CollectionView (横向 有H&F View)
            VC.isHaveHeaderFooterView = YES;
            VC.isRoundWithHeaerView = YES;
            VC.isRoundWithFooterView = YES;
            VC.isHorizontal = YES;
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:VC animated:YES];
}


@end
