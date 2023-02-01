//
//  SYCollectionViewRoundFlowLayout+Alignment.h
//  SYCollectionViewRoundFlowLayout_Example
//
//  Created by Mac on 2023/2/1.
//  Copyright © 2023 sy. All rights reserved.
//

#import "SYCollectionViewRoundFlowLayout.h"
#import "SYCollectionViewFlowLayoutConfig.h"
#import "SYCollectionViewRoundFlowLayout.h"
NS_ASSUME_NONNULL_BEGIN

@interface SYCollectionViewRoundFlowLayout (Alignment)

/// 将相同y位置的cell集合到一个列表中(竖向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;


/// 将相同x位置的cell集合到一个列表中(横向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByXLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;


/// 根据不同对齐方式进行Cell位置计算
/// @param layoutAttributesAttrs 传入需计算的AttributesAttrs集合列表
/// @param toChangeAttributesAttrsList 用来保存所有计算后的AttributesAttrs
/// @param alignmentType 对齐方式
- (NSMutableArray *)evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs toChangeAttributesAttrsList:(NSMutableArray *_Nonnull *_Nonnull)toChangeAttributesAttrsList cellAlignmentType:(SYCollectionViewRoundFlowLayoutAlignmentType)alignmentType;


#pragma mark - alignment

/// 计算AttributesAttrs左对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByLeftWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

/// 计算AttributesAttrs居中对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

/// 计算AttributesAttrs右对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;
@end

NS_ASSUME_NONNULL_END
