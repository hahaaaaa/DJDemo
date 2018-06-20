//
//  ViewController.m
//  DJDemo
//
//  Created by Sky on 2018/4/18.
//  Copyright © 2018年 Sky. All rights reserved.
//

#import "ViewController.h"
#import "CollectionReusableView.h"
#import <Masonry.h>
#import "DJObject.h"


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

{
    FMDatabase *_db;
    int mark_student;
    NSString *_docPath;
}
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Hello world！";
    self.view.backgroundColor = [UIColor brownColor];
    
    [self initData];
    
    [self loadCollectionView];
    
    [self initDataBase];
    

}
- (void)initData {
    self.dataSource = @[@"创建表",@"添加数据",@"删除数据",@"修改数据",@"查询数据",@"删表"];
}
- (void)initDataBase {
    //数据库相关
    _docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"%@",_docPath);
    mark_student = 1;
    //1、设置数据库名称
    NSString *fileName = [_docPath stringByAppendingPathComponent:@"student.sqlite"];
    //2、获取数据库
    _db = [FMDatabase databaseWithPath:fileName];
    if ([_db open]) {
        [DJHud showMessage:@"打开成功！"];
    } else {
        [DJHud showMessage:@"打开失败！"];
    }
    
}
#pragma mark - ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ UICollectionView
- (void)loadCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat cell_margin = 15;
    CGFloat cell_space = 15;
    layout.minimumLineSpacing = cell_margin;
    layout.minimumInteritemSpacing = cell_space;
    layout.estimatedItemSize = CGSizeMake(30, 20);
    layout.headerReferenceSize = CGSizeMake(375, 100);

    layout.sectionInset = UIEdgeInsetsMake(cell_margin, cell_margin, cell_margin, cell_margin);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionReusableView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CollectionReusableView class])];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    UITableView *tab = nil;
    [tab performBatchUpdates:^{
        
    } completion:^(BOOL finished) {
        
    }];
    _collectionView.showsVerticalScrollIndicator = YES;
    
    [self.view addSubview:_collectionView];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    UILabel *label = [UILabel new];
    label.tag = indexPath.row + 100;
    label.text = self.dataSource[indexPath.row];
    [cell.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:indexPath.row + 100];
    if ([label.text containsString:@"创建"]) {
        //3.创建表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL, sex text NOT NULL);"];
        if (result) {
            [DJHud showMessage:@"创建表成功"];
        } else {
            [DJHud showMessage:@"创建表失败"];
        }
    } else if ([label.text containsString:@"添加"]) {
        
        //插入数据
        NSString *name = [NSString stringWithFormat:@"王子涵%@",@(mark_student)];
        int age = mark_student;
        NSString *sex = @"男";
        mark_student ++;
        //1.executeUpdate:不确定的参数用？来占位（后面参数必须是oc对象，；代表语句结束）
        BOOL result = [_db executeUpdate:@"INSERT INTO t_student (name, age, sex) VALUES (?,?,?)",name,@(age),sex];
        //2.executeUpdateWithForamat：不确定的参数用%@，%d等来占位 （参数为原始数据类型，执行语句不区分大小写）
        //    BOOL result = [_db executeUpdateWithFormat:@"insert into t_student (name,age, sex) values (%@,%i,%@)",name,age,sex];
        //3.参数是数组的使用方式
        //    BOOL result = [_db executeUpdate:@"INSERT INTO t_student(name,age,sex) VALUES  (?,?,?);" withArgumentsInArray:@[name,@(age),sex]];
        if (result) {
            [DJHud showMessage:@"插入成功"];

        } else {
            [DJHud showMessage:@"插入失败"];

        }
 
    } else if ([label.text containsString:@"删除"]) {
        //1.不确定的参数用？来占位 （后面参数必须是oc对象,需要将int包装成OC对象）
        int idNum = 11;
        BOOL result = [_db executeUpdate:@"delete from t_student where id = ?",@(idNum)];
        //2.不确定的参数用%@，%d等来占位
        //BOOL result = [_db executeUpdateWithFormat:@"delete from t_student where name = %@",@"王子涵"];
        if (result) {
            [DJHud showMessage:@"删除成功"];

        } else {
            [DJHud showMessage:@"删除失败"];

        }

    } else if ([label.text containsString:@"修改"]) {
        //修改学生的名字
        NSString *newName = @"李浩宇";
        NSString *oldName = @"王子涵2";
        BOOL result = [_db executeUpdate:@"update t_student set name = ? where name = ?",newName,oldName];
        if (result) {
            
            [DJHud showMessage:@"修改成功"];
        } else {
            [DJHud showMessage:@"修改失败"];
        }
        

    } else if ([label.text containsString:@"查询"]) {
        //查询整个表
        FMResultSet * resultSet = [_db executeQuery:@"select * from t_student"];
        //根据条件查询
        //FMResultSet * resultSet = [_db executeQuery:@"select * from t_student where id < ?", @(4)];
        //遍历结果集合
        while ([resultSet next]) {
            int idNum = [resultSet intForColumn:@"id"];
            NSString *name = [resultSet objectForColumnName:@"name"];
            int age = [resultSet intForColumn:@"age"];
            NSString *sex = [resultSet objectForColumnName:@"sex"];
            [DJHud showMessage:[NSString stringWithFormat:@"学号：%@ 姓名：%@ 年龄：%@ 性别：%@",@(idNum),name,@(age),sex]];
        }
        
    } else if ([label.text containsString:@"删表"]) {
        //如果表格存在 则销毁
        BOOL result = [_db executeUpdate:@"drop table if exists t_student"];
        if (result) {
            [DJHud showMessage:@"删除表成功"];
        } else {
            [DJHud showMessage:@"删除表失败"];
        }

    }
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CollectionReusableView class]) forIndexPath:indexPath];
        view.label.text = @"矮纸斜行闲作草，晴窗细乳戏分茶\n素衣莫起风尘叹，犹及清明可到家";
        view.label.font = [UIFont fontWithName:@"迷你简柏青" size:17];
        return view;
    } else {
        return nil;
    }
}

@end
