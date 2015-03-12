//
//  MGLAnnotationView.m
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-04.
//
//

#import "MGLAnnotationView.h"
#import "MGLAnnotationView_Private.h"

#import <CoreLocation/CoreLocation.h>

#import "MGLAnnotation.h"

#import "../../calloutview/SMCalloutView.h"

@interface MGLAnnotationView ()

@property (nonatomic, strong) SMCalloutView *calloutView;

@end

@implementation MGLAnnotationView {
    SMCalloutView *_calloutView;
}

@synthesize calloutView = _calloutView;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if (self = [super initWithImage:image highlightedImage:highlightedImage]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.userInteractionEnabled = YES;
}

- (void)setCalloutView:(SMCalloutView *)calloutView {
    // TODO: This is immediate, but we want animation here.
    [_calloutView removeFromSuperview];
    if (calloutView) {
        _calloutView = calloutView;
        [self updateCalloutView];
        [self addSubview:_calloutView];
    } else {
        _calloutView = calloutView;
    }
}

- (void)updateCalloutView {
    if ([self.annotation respondsToSelector:@selector(title)]) {
        _calloutView.title = self.annotation.title;
    }
    if ([self.annotation respondsToSelector:@selector(subtitle)]) {
        _calloutView.subtitle = self.annotation.subtitle;
    }
}

@end
