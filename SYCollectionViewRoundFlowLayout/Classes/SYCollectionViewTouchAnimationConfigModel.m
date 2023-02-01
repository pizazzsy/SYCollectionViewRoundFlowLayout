//
//  SYCollectionViewTouchAnimationConfigModel.m
//  SYCollectionViewRoundFlowLayout_Example
//
//  Created by Mac on 2023/2/1.
//  Copyright © 2023 sy. All rights reserved.
//

#import "SYCollectionViewTouchAnimationConfigModel.h"

@implementation SYCollectionViewTouchAnimationConfigModel
+ (instancetype)createDefaultModel {
    return [[SYCollectionViewTouchAnimationConfigModel alloc]init];
};

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization {
    _transformScaleSx = 0.98;
    _transformScaleSy = 0.98;
    _startDuration = 0.2;
    _endDuration = 0.2;
    _isCellsAnimationEnable = YES;
}
@end
