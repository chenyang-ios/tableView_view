//
//  ViewController.m
//  手机区号选择
//
//  Created by 杜晨阳 on 2017/2/17.
//  Copyright © 2017年 飞翔云端的鱼. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView  *myTableView;//列表
    
    NSArray  *sectionTitles;//每个分区的标题
    
    NSArray  *contentsArray;//每行的内容
    
    NSMutableArray  *isShowArray;//存储每个section是否展开int数组，可以标志字，或者bool
    
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    
    sectionTitles = [[NSArray alloc] initWithObjects:
                     @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H", nil];
    
    contentsArray = [[NSArray alloc] initWithObjects:
                     @[@"A1",@"A2",@"A3", @"A4", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX"],
                     @[@"B1",@"B2",@"B3",@"B4",@"B5", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX"],
                     @[@"C1",@"C2",@"C3",@"C4",@"C5", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX"],
                     @[@"D1",@"D2",@"D3",@"D4", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX"],
                     @[@"E1",@"E2",@"E3",@"E4", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX", @"XX"],
                     @[@"F1",@"F2", @"XX", @"XX", @"XX", @"XX"],
                     @[@"G1",@"G2",@"G3", @"XX", @"XX"],
                     @[@"H1",@"H2",@"H3", @"XX", @"XX"],
                     nil];
    
    isShowArray = [[NSMutableArray  alloc]init];
    
    for (int i = 0; i< sectionTitles.count; i++) {
        
        
        [isShowArray addObject:[NSNumber numberWithInt:0]];
        
    }
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    
    myTableView.sectionIndexColor = [UIColor purpleColor]; // 右侧索引的颜色
    myTableView.delegate = self;
    myTableView.dataSource = self;
    [self.view addSubview:myTableView];
    
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return sectionTitles.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger  numberOfRows;
    
    if ([isShowArray[section] integerValue] ==0) {
        
        //隐藏了就显示0行
        
        numberOfRows = 0;
        
    }else{
        
        
        
        numberOfRows = [contentsArray[section] count];
        
    }
    
    return numberOfRows;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView  *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    
    UIButton *titleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, myTableView.frame.size.width, 30)];
    [titleButton setBackgroundColor:[UIColor cyanColor]];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleButton setTitle:sectionTitles[section] forState:UIControlStateNormal];
    [titleButton setTag:1000 + section];
    [view addSubview:titleButton];
    
    [titleButton addTarget:self
                    action:@selector(tableHeaderClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static  NSString *detailIndicated = @"tableCell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:detailIndicated];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailIndicated];
    }
    
    cell.textLabel.text = contentsArray[indexPath.section][indexPath.row];
    
    return cell;
    
}



- (void)tableHeaderClicked:(UIButton *)sender{
    
    NSInteger  section = sender.tag -1000;
    
    if ([isShowArray[section]integerValue]== 0) {
        
        //展开
        
        [isShowArray  replaceObjectAtIndex:section withObject:[NSNumber  numberWithInteger:1]];
        
    }else{
        
        //折叠
        [isShowArray  replaceObjectAtIndex:section withObject:[NSNumber  numberWithInteger:0]];
        
        
    }
    
    //折叠动画效果   NSIndexSet  是个无符号整数集合。集合中的元素不可变的、不可重复。常被用来当作索引使用。就从它字面上理解，就叫做：索引集合。
    /*
     UITableViewRowAnimationFade,//淡入淡出
     UITableViewRowAnimationRight,//从右滑入
     UITableViewRowAnimationLeft,//从左滑入
     UITableViewRowAnimationTop,//从上滑入
     UITableViewRowAnimationBottom,//从下滑入
     UITableViewRowAnimationNone,  //没有动画
     UITableViewRowAnimationMiddle,
     UITableViewRowAnimationAutomatic = 100  // 自动选择合适的动画
     */
    
    [myTableView  reloadSections:[NSIndexSet  indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选中效果
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //获取点击行的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /*
     cell.accessoryType = UITableViewCellAccessoryNone;//cell没有任何的样式
     
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//cell的右边有一个小箭头，距离右边有十几像素；
     
     cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;//cell右边有一个蓝色的圆形button；
     
     cell.accessoryType = UITableViewCellAccessoryCheckmark;//cell右边的形状是对号；
     */
    //如果cell已经被标记
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
        //取消标记
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else{
        
        //未被标记就标记
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
    }
    
    
}

//右侧索引

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [sectionTitles objectAtIndex:section];
    
}

// 索引目录
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    return sectionTitles;
    
}
//点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSLog(@"%ld",(long)index);
    
    return index;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
