//
//  NSObject+AGKVO.h
//  TestViewControllerAndViewLayout
//
//  Created by AlexGao on 2019/5/12.
//  Copyright © 2019 AlexGao. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ObseverBlock)(id _Nullable newValue);
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AGKVO)
- (void)AG_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath ObseverBlock:(ObseverBlock)block;
@end

NS_ASSUME_NONNULL_END
