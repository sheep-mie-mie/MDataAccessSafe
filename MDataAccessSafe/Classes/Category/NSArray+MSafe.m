//
//  NSArray+MSafe.m
//  Masonry
//
//  Created by sheep on 2022/10/12.
//

#import "NSArray+MSafe.h"
#import <objc/runtime.h>

@implementation NSArray (MSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method oldMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method newMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(swizzled_objectAtIndex:));
        // 交换方法
        method_exchangeImplementations(oldMethod, newMethod);
    });
}

/// 数组下标越界处理
/// - Parameter index: index
- (id)swizzled_objectAtIndex:(NSUInteger)index {
    // 1.判断下标是否越界
    if ((self.count - 1) < index) {
        @try {
            return [self swizzled_objectAtIndex:index];
        } @catch (NSException *exception) {
            // 打印报错可本地保存或上传服务器
            NSLog(@"%@", [exception callStackSymbols]);
            // 越界时返回空串
            return @"";
        } @finally {
            
        }
    } else {
        return [self swizzled_objectAtIndex:index];
    }
}


@end



@implementation NSMutableArray (MSafe)

+ (void)load {
    
}

@end


