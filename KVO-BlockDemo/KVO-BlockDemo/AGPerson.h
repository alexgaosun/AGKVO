//
//  AGPerson.h
//  KVO-BlockDemo
//
//  Created by AlexGao on 2019/5/12.
//  Copyright © 2019 AlexGao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AGPerson : NSObject
@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)BOOL isMan;
@end

NS_ASSUME_NONNULL_END
