//
//  MGLAnnotationView.h
//  mbgl
//
//  Created by Minh Nguyen on 2015-03-04.
//
//

#import <UIKit/UIKit.h>

@protocol MGLAnnotation;

@interface MGLAnnotationView : UIImageView

@property (nonatomic, strong) id <MGLAnnotation> annotation;

@end
