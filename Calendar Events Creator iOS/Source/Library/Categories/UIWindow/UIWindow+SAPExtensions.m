//
//  UIWindow+SAPextensions.m
//  IOSProject
//
//  Created by S A P on 1/29/16.
//  Copyright © 2016 SAP. All rights reserved.
//
#import <UIKit/UIScreen.h>

#import "UIWindow+SAPextensions.h"

@implementation UIWindow (SAPextensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)window {
    return [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
