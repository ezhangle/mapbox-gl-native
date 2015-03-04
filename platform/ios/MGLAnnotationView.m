//
//  MGLAnnotationView.m
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-04.
//
//

#import "MGLAnnotationView.h"

#import "../../calloutview/SMCalloutView.h"

@interface MGLAnnotationView ()

//! The callout view that pops up when the receiver is selected.
@property (nonatomic) SMCalloutView *calloutView;

@end

@implementation MGLAnnotationView

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
    self.calloutView = [SMCalloutView platformCalloutView];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    [self.superview addSubview:self.calloutView];
}

- (NSString *)title {
    return self.calloutView.title;
}

- (void)setTitle:(NSString *)title {
    self.calloutView.title = title;
}

- (NSSet *)keyPathsForValuesAffectingTitle {
    return [NSSet setWithObject:@"calloutview.title"];
}

- (NSString *)subtitle {
    return self.calloutView.subtitle;
}

- (void)setSubtitle:(NSString *)subtitle {
    self.calloutView.subtitle = subtitle;
}

- (NSSet *)keyPathsForValuesAffectingSubtitle {
    return [NSSet setWithObject:@"calloutview.subtitle"];
}

@end
