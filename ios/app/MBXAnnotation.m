//
//  MBXAnnotation.m
//  mapboxgl-app
//
//  Created by Brad Leege on 3/3/15.
//
//

#import "MBXAnnotation.h"

@implementation MBXAnnotation {
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

+ (instancetype)annotationWithLocation:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    return [[self alloc] initWithLocation:coordinate title:title subtitle:subtitle];
}

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coordinate title:(NSString *)title subtitle:(NSString *)subtitle {
    if (self = [super init]) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    MBXAnnotation *annotation = [(MBXAnnotation *)[[self class] allocWithZone:zone] initWithLocation:_coordinate title:[_title copyWithZone:zone] subtitle:[_subtitle copyWithZone:zone]];
    return annotation;
}

@end

@implementation MBXAnnotationView
@end
