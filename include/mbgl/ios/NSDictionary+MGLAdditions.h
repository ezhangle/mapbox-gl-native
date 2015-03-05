#import <Foundation/Foundation.h>

@interface NSDictionary (MGLAdditions)

- (NSMutableDictionary *)deepMutableCopy;

@end

@interface NSMutableDictionary (MGLAdditions)

- (void)mgl_addObject:(id)object toArrayForKey:(id <NSCopying>)key;
- (void)mgl_addObjectsFromArray:(NSArray *)additions toArrayForKey:(id <NSCopying>)key;
- (void)removeObject:(id)removal FromArrayForKey:(id <NSCopying>)key;

@end
