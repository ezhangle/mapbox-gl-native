#import "NSDictionary+MGLAdditions.h"

@implementation NSDictionary (MGLAdditions)

- (NSMutableDictionary *)deepMutableCopy
{
    return (NSMutableDictionary *)CFBridgingRelease(CFPropertyListCreateDeepCopy(kCFAllocatorDefault, (CFDictionaryRef)self, kCFPropertyListMutableContainersAndLeaves));
}

@end

@implementation NSMutableDictionary (MGLAdditions)

- (void)mgl_addObject:(id)addition toArrayForKey:(id <NSCopying>)key {
    id array = [self objectForKey:key];
    if (!array) {
        array = [NSMutableArray arrayWithObject:addition];
        [self setObject:array forKey:key];
    } else if ([array isKindOfClass:[NSMutableArray class]]) {
        [array addObject:addition];
    } else if ([array isKindOfClass:[NSArray class]]) {
        array = [array mutableCopy];
        [array addObject:addition];
        [self setObject:array forKey:key];
    } else {
        NSAssert(NO, @"Object associated with key %@ must be an instance of NSArray or NSMutableArray, not %@.", key, [array class]);
    }
}

- (void)mgl_addObjectsFromArray:(NSArray *)additions toArrayForKey:(id <NSCopying>)key {
    id array = [self objectForKey:key];
    if (!array) {
        array = [additions copy];
        [self setObject:array forKey:key];
    } else if ([array isKindOfClass:[NSMutableArray class]]) {
        [array addObjectsFromArray:additions];
    } else if ([array isKindOfClass:[NSArray class]]) {
        array = [array mutableCopy];
        [array addObjectsFromArray:additions];
        [self setObject:array forKey:key];
    } else {
        NSAssert(NO, @"Object associated with key %@ must be an instance of NSArray or NSMutableArray, not %@.", key, [array class]);
    }
}

- (void)removeObject:(id)removal FromArrayForKey:(id <NSCopying>)key {
    id array = [self objectForKey:key];
    if (!array) {
    } else if ([array isKindOfClass:[NSMutableArray class]]) {
        [array removeObject:removal];
    } else if ([array isKindOfClass:[NSArray class]]) {
        array = [array mutableCopy];
        [array removeObject:removal];
        [self setObject:array forKey:key];
    } else {
        NSAssert(NO, @"Object associated with key %@ must be an instance of NSArray or NSMutableArray, not %@.", key, [array class]);
    }
}

@end
