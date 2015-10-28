//
//  ViewController.m
//  Coredata
//
//  Created by lanou on 15/10/26.
//  Copyright (c) 2015年 刘瑞超. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import "AppDelegate.h"

@interface ViewController ()

//上下文, 临时数据库
@property(nonatomic, retain) NSManagedObjectContext *context;

@property(nonatomic, retain) NSMutableArray *arr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取到 appDelegate 中的临时数据库
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.context = appDelegate.managedObjectContext;
    
    self.arr = [NSMutableArray array];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)add:(id)sender
{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    student.name = @"lrc";
    student.gender = @"女";
    student.hobby = @"玩";
    student.age = @"18";
    
    [self.arr addObject:student];
    
    [self.context save:nil];
}

- (IBAction)delete:(id)sender
{
    if (self.arr.count != 0)
    {
        Student *student = [self.arr lastObject];
        
        [self.context deleteObject:[self.arr lastObject]];
     
        [self.arr removeObject:student];
    }
    
    [self.context save:nil];
}
- (IBAction)change:(id)sender
{
    
}
- (IBAction)search:(id)sender
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS 'lrc'"];
    request.predicate = predicate;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    NSSortDescriptor *sort1 =[NSSortDescriptor sortDescriptorWithKey:@"hobby" ascending:YES];
    request.sortDescriptors = @[sort, sort1];
    
    NSError *error;
    //执行这个请求 得到结果
    NSArray *array = [self.context executeFetchRequest:request error:&error];
    NSLog(@"%@", error);
    //把查询的结果放在 self.arr 里面
    self.arr = [NSMutableArray arrayWithArray:array];
    
    for (Student *student in array)
    {
        NSLog(@"%@", student.name);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
