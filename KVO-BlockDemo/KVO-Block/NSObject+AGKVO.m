//
//  NSObject+AGKVO.m
//  TestViewControllerAndViewLayout
//
//  Created by AlexGao on 2019/5/12.
//  Copyright © 2019 AlexGao. All rights reserved.
//

#import "NSObject+AGKVO.h"
#import <objc/runtime.h>
@interface NSObject()
@property (nonatomic , strong) NSMutableDictionary <NSString *,ObseverBlock> *dict;
@property (nonatomic , strong) NSMutableDictionary <NSString *,NSMutableArray *>*kvoDict;

@end
@implementation NSObject (AGKVO)
- (void)AG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath ObseverBlock:(ObseverBlock)block
{
    //observer 观察者
    //keyPath 观察者对象
    observer.dict[keyPath] = block;
    [self addObserver:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
   
    NSMutableArray *arr = self.kvoDict[keyPath];
    NSLog(@"kvoDict-%@",self.kvoDict);
    if (!arr) {
        arr = [NSMutableArray array];
        [self.kvoDict setValue:arr forKey:keyPath];
    }
    NSLog(@"kvoDict-%@",self.kvoDict);
    NSValue *value = [NSValue valueWithNonretainedObject:observer];
    [arr addObject:value];
    NSLog(@"kvoDict-%@",value.nonretainedObjectValue);
    NSLog(@"kvoDict-%@",self.kvoDict);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        method_exchangeImplementations(class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc")),class_getInstanceMethod([self class], @selector(agDealloc)));
    });
}
- (void)agDealloc
{
    if ([self isKvoDict]) {
        [self.kvoDict enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSMutableArray * _Nonnull obj, BOOL * _Nonnull stop) {
        
           NSMutableArray *arr = self.kvoDict[key];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSObject *object = [obj nonretainedObjectValue]; // 监听对象
                [self removeObserver:object forKeyPath:key];
                NSLog(@"移除监听对象%@---属性%@",object,key);
            }];
        }];
    }
    [self agDealloc];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    //执行block
    ObseverBlock block = self.dict[keyPath];
    if (self.dict[keyPath]) {
        id newValue = [change objectForKey:@"new"];
        block(newValue);
    }
}

- (NSMutableDictionary<NSString *,ObseverBlock> *)dict
{
    /*
     objc_setAssocaitedObject 以及objc_getAssocaitedObjects方法 手动实现实例对象的创建
     objc_getAssocaitedObject 参数1:调用者 参数2:关联的键值对象方法
     objc_setAssocatiedObject 参数1:调用者 参数2:关联的键值对象方法 参数3:需要设置对象的属性
     参数4:设置@property <(nonatomic , strong )> 尖括号中的属性
     */
    NSMutableDictionary *tmpDict = objc_getAssociatedObject(self, @selector(dict));
    if (!tmpDict) {
        tmpDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(dict), tmpDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpDict;
}
- (NSMutableDictionary<NSString *,NSMutableArray *> *)kvoDict
{
    NSMutableDictionary *tmpKvoDict =  objc_getAssociatedObject(self, @selector(kvoDict));
    if (!tmpKvoDict) {
        tmpKvoDict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, @selector(kvoDict), tmpKvoDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return tmpKvoDict;
}

- (BOOL)isKvoDict
{
    if (objc_getAssociatedObject(self, @selector(kvoDict))) {
        return YES;
    }else{
        return  NO;
    }
}
@end
