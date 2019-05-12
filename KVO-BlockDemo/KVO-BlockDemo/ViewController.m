//
//  ViewController.m
//  KVO-BlockDemo
//
//  Created by AlexGao on 2019/5/12.
//  Copyright © 2019 AlexGao. All rights reserved.
//

#import "ViewController.h"
#import "AGPerson.h"
#import "NSObject+AGKVO.h"
#import "TestRmoveOBController.h"
@interface ViewController ()
@property(nonatomic, strong)AGPerson *person ;
@property(nonatomic, strong)NSString *myName ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[AGPerson alloc] init];
    self.person.name = @"zhansan";
    self.person.isMan = YES;
    _myName = @"";
    [_person AG_addObserver:self forKeyPath:@"name" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    [self.person AG_addObserver:self forKeyPath:@"isMan" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    [self AG_addObserver:self forKeyPath:@"myName" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    

    
    
    // Do any additional setup after loading the view.
}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
//{
//    id newValue = [change objectForKey:@"new"];
//    //执行block
////    ObseverBlock block = self.dict[keyPath];
////    if (self.dict[keyPath]) {
////        id newValue = [change objectForKey:NSKeyValueObservingOptionNew];
////        block(newValue);
////    }
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.person.name = @"lisi";
//    self.person.isMan = NO;
//    self.myName = @"AG";
    //测试移除监听
    TestRmoveOBController *tvc = [TestRmoveOBController new];
    [self.navigationController pushViewController:tvc animated:YES];
    
}

@end
