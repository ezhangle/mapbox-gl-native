//
//  MBXAnnotation.m
//  mapboxgl-app
//
//  Created by Brad Leege on 3/3/15.
//
//

#import "MBXAnnotation.h"

#import "SMCalloutView.h"

@implementation MBXAnnotation {
    CLLocationCoordinate2D _coordinate;
}

@synthesize coordinate = _coordinate;

+ (instancetype)annotationWithLocation:(CLLocationCoordinate2D)coordinate {
    return [[self alloc] initWithLocation:coordinate];
}

- (instancetype)initWithLocation:(CLLocationCoordinate2D)coordinate {
    if (self = [super init]) {
        _coordinate = coordinate;
    }
    return self;
}

@end

@implementation MBXAnnotationView

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super initWithCoder:aDecoder]) {
//        [self commonInit];
//    }
//    return self;
//}
//
//- (void)commonInit {
//    
//}
//
//- (void)didMoveToSuperview {
//    [super didMoveToSuperview];
//}

@end
