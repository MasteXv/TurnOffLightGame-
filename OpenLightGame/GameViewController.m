//
//  GameViewController.m
//  OpenLightGame
//
//  Created by 鲜美生活 on 2017/7/31.
//  Copyright © 2017年 小旭. All rights reserved.
//

#import "GameViewController.h"
#import "LightCollectionViewCell.h"
#import "LightModel.h"
#define kXNum 9
#define kYNum 9
@interface GameViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *GameCollectionView;

@property (nonatomic, strong)NSMutableArray *DataSource;
@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置collectionView属性
    [self SetCollectionVProperty];
    //设置数据源数组
    [self handleDataSource];
}

//设置collectionView属性
- (void)SetCollectionVProperty{
    self.GameCollectionView.delegate = self;
    self.GameCollectionView.dataSource = self;
}

//设置数据源数组
- (void)handleDataSource{
    [self.DataSource removeAllObjects];
    for (int i = 0; i < kXNum*kYNum; i++) {
        LightModel *model = [[LightModel alloc] init];
        model.IsOpen = @"ON";
        [self.DataSource addObject:model];
    }
}

//全灭
- (IBAction)CloseAll:(id)sender {
    [self.DataSource removeAllObjects];
    for (int i = 0; i < kXNum*kYNum; i++) {
        LightModel *model = [[LightModel alloc] init];
        model.IsOpen = @"OFF";
        [self.DataSource addObject:model];
    }
    [self.GameCollectionView reloadData];
}

//全亮
- (IBAction)OpenAll:(id)sender {
    [self.DataSource removeAllObjects];
    for (int i = 0; i < kXNum*kYNum; i++) {
        LightModel *model = [[LightModel alloc] init];
        model.IsOpen = @"ON";
        [self.DataSource addObject:model];
    }
    [self.GameCollectionView reloadData];
}

#pragma UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return kXNum*kYNum;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LightCell" forIndexPath:indexPath];
    LightModel *model = self.DataSource[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击灯泡时
    LightModel *model = self.DataSource[indexPath.row];
    //使相应灯泡状态翻转方法
    [self MakeLightStateChangeMothedWithModel:model];
    //四个角的灯泡
    if (indexPath.row == 0) {
        //左上
        LightModel *model1 = self.DataSource[indexPath.row + 1];
        LightModel *model2 = self.DataSource[indexPath.row + kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2]];
    }else if (indexPath.row == kXNum - 1){
        //右上
        LightModel *model1 = self.DataSource[indexPath.row - 1];
        LightModel *model2 = self.DataSource[indexPath.row + kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2]];
    }else if (indexPath.row == (kYNum-1)*9){
        //左下
        LightModel *model1 = self.DataSource[indexPath.row + 1];
        LightModel *model2 = self.DataSource[indexPath.row - kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2]];
    }else if (indexPath.row == kXNum*kYNum - 1){
        //右下
        LightModel *model1 = self.DataSource[indexPath.row - 1];
        LightModel *model2 = self.DataSource[indexPath.row - kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2]];
    }else if (indexPath.row <= kXNum - 1){
        //第一行
        LightModel *model1 = self.DataSource[indexPath.row - 1];
        LightModel *model2 = self.DataSource[indexPath.row + 1];
        LightModel *model3 = self.DataSource[indexPath.row + kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2,model3]];
    }else if (indexPath.row >= kXNum*kYNum-kXNum){
        //最后一行
        LightModel *model1 = self.DataSource[indexPath.row - 1];
        LightModel *model2 = self.DataSource[indexPath.row + 1];
        LightModel *model3 = self.DataSource[indexPath.row - kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2,model3]];
    }else if (indexPath.row%9==0){
        //第一列
        LightModel *model1 = self.DataSource[indexPath.row + kXNum];
        LightModel *model2 = self.DataSource[indexPath.row + 1];
        LightModel *model3 = self.DataSource[indexPath.row - kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2,model3]];
    }else if ((indexPath.row+1)%9==0){
        //最后一列
        LightModel *model1 = self.DataSource[indexPath.row + kXNum];
        LightModel *model2 = self.DataSource[indexPath.row - 1];
        LightModel *model3 = self.DataSource[indexPath.row - kXNum];
        [self BatchHandleModelMothedWithArr:@[model1,model2,model3]];
    }else{
        //其余的所有情况
        LightModel *model1 = self.DataSource[indexPath.row + kXNum];
        LightModel *model2 = self.DataSource[indexPath.row - 1];
        LightModel *model3 = self.DataSource[indexPath.row - kXNum];
        LightModel *model4 = self.DataSource[indexPath.row + 1];
        [self BatchHandleModelMothedWithArr:@[model1,model2,model3,model4]];
    }
    [self.GameCollectionView reloadData];
}

//数组方式处理传入的model方法
- (void)BatchHandleModelMothedWithArr:(NSArray *)arr{
    for (LightModel *model in arr) {
        //使相应灯泡状态翻转方法
        [self MakeLightStateChangeMothedWithModel:model];
    }
}

//使相应灯泡状态翻转方法
- (void)MakeLightStateChangeMothedWithModel:(LightModel *)model{
    if ([model.IsOpen isEqualToString:@"ON"]) {
        model.IsOpen = @"OFF";
    }else{
        model.IsOpen = @"ON";
    }
}

#pragma UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(40, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && !self.view.window) {
        self.view = nil;
    }
}

- (NSMutableArray *)DataSource{
    if (!_DataSource) {
        self.DataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _DataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
