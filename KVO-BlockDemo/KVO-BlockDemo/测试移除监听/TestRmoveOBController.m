//
//  TestRmoveOBController.m
//  KVO-BlockDemo
//
//  Created by AlexGao on 2019/5/12.
//  Copyright © 2019 AlexGao. All rights reserved.
//

#import "TestRmoveOBController.h"
#import "NSObject+AGKVO.h"
@interface TestRmoveOBController ()
@property(nonatomic, strong)NSString *myName ;
@property(nonatomic, strong)NSString *myTitle ;
@property(nonatomic, strong)NSString *favorite ;

@end

@implementation TestRmoveOBController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self AG_addObserver:self forKeyPath:@"myName" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    [self AG_addObserver:self forKeyPath:@"myTitle" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    [self AG_addObserver:self forKeyPath:@"favorite" ObseverBlock:^(id  _Nullable newValue) {
        if ([newValue isKindOfClass:[NSNumber class]]) {
            NSNumber *number = newValue;
            NSLog(@"%@",number);
        }else{
            NSLog(@"%@",newValue);
        }
    }];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.myName = @"AG";
    self.favorite = @"eat";
    self.myTitle = @"alex";
}
- (void)dealloc
{
    NSLog(@"TestRmoveOBController-dealloc");
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
