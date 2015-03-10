//
//  MGLUserLocationAnnotationView.m
//  mbgl
//
// Copyright (c) 2008-2013, Route-Me Contributors
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice, this
//   list of conditions and the following disclaimer.
// * Redistributions in binary form must reproduce the above copyright notice,
//   this list of conditions and the following disclaimer in the documentation
//   and/or other materials provided with the distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

#import "MGLUserLocationAnnotationView.h"
#import "MGLAnnotation.h"
#import "MGLMapView.h"

@implementation MGLUserLocationAnnotation

- (instancetype)init {
    if (self = [super init]) {
        _coordinate = CLLocationCoordinate2DMake(MAXFLOAT, MAXFLOAT);
    }
}

- (id)copyWithZone:(NSZone *)zone {
    MGLUserLocationAnnotation *annotation = [(MGLUserLocationAnnotation *)[[self class] allocWithZone:zone] init];
    if (annotation) {
        annotation->_coordinate = _coordinate;
    }
    return annotation;
}

@end

@interface MGLUserLocationAnnotationView ()

@property (nonatomic, assign) BOOL hasCustomLayer;
@property (nonatomic, weak) MGLMapView *mapView;

@end

#pragma mark -

@implementation MGLUserLocationAnnotationView

@synthesize updating = _updating;
@synthesize location = _location;
@synthesize heading = _heading;
@synthesize hasCustomLayer = _hasCustomLayer;

- (MGLUserLocationAnnotation *)annotation {
    return [super annotation];
}

- (void)setAnnotation:(MGLUserLocationAnnotation *)annotation {
    NSAssert([annotation isKindOfClass:[MGLUserLocationAnnotation class]], @"MGLUserLocationAnnotationView may only have an MGLUserLocationAnnotation as its annotation.");
    [super setAnnotation:annotation];
}

- (BOOL)isUpdating
{
    return self.mapView.userTrackingMode != MGLUserTrackingModeNone;
}

- (void)updateTintColor
{
    if ( ! self.hasCustomLayer && CLLocationCoordinate2DIsValid(self.annotation.coordinate))
    {
        // white dot background with shadow
        //
        CGFloat whiteWidth = 24.0;

        CGRect rect = CGRectMake(0, 0, whiteWidth * 1.25, whiteWidth * 1.25);

        UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextSetShadow(context, CGSizeMake(0, 0), whiteWidth / 4.0);

        CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
        CGContextFillEllipseInRect(context, CGRectMake((rect.size.width - whiteWidth) / 2.0, (rect.size.height - whiteWidth) / 2.0, whiteWidth, whiteWidth));

        UIImage *whiteBackground = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        // pulsing, tinted dot sublayer
        //
        CGFloat tintedWidth = whiteWidth * 0.7;

        rect = CGRectMake(0, 0, tintedWidth, tintedWidth);

        UIGraphicsBeginImageContextWithOptions(rect.size, NO, [[UIScreen mainScreen] scale]);
        context = UIGraphicsGetCurrentContext();

        CGContextSetFillColorWithColor(context, [self.mapView.tintColor CGColor]);
        CGContextFillEllipseInRect(context, CGRectMake((rect.size.width - tintedWidth) / 2.0, (rect.size.height - tintedWidth) / 2.0, tintedWidth, tintedWidth));

        UIImage *tintedForeground = UIGraphicsGetImageFromCurrentImageContext();

        UIGraphicsEndImageContext();

        CALayer *dotLayer = [CALayer layer];
        dotLayer.bounds = CGRectMake(0, 0, tintedForeground.size.width, tintedForeground.size.height);
        dotLayer.contents = (id)[tintedForeground CGImage];
        dotLayer.position = CGPointMake(super.layer.bounds.size.width / 2.0, super.layer.bounds.size.height / 2.0);

        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.repeatCount = MAXFLOAT;
        animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
        animation.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8, 0.8, 1.0)];
        animation.removedOnCompletion = NO;
        animation.autoreverses = YES;
        animation.duration = 1.5;
        animation.beginTime = CACurrentMediaTime() + 1.0;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

        [dotLayer addAnimation:animation forKey:@"animateTransform"];

        [super.layer addSublayer:dotLayer];
    }
}

- (void)setLocation:(CLLocation *)newLocation
{
    if ([newLocation distanceFromLocation:_location] && newLocation.coordinate.latitude != 0 && newLocation.coordinate.longitude != 0)
    {
        [self willChangeValueForKey:@"location"];
        _location = newLocation;
        MGLUserLocationAnnotation *annotation = self.annotation;
        annotation.coordinate = _location.coordinate;
        [self didChangeValueForKey:@"location"];
    }
}

- (void)setHeading:(CLHeading *)newHeading
{
    if (newHeading.trueHeading != _heading.trueHeading)
    {
        [self willChangeValueForKey:@"heading"];
        _heading = newHeading;
        [self didChangeValueForKey:@"heading"];
    }
}

- (BOOL)isUserLocationAnnotation
{
    return YES;
}

@end
