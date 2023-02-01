//
//  SYCollectionViewRoundFlowLayout+Alignment.m
//  SYCollectionViewRoundFlowLayout_Example
//
//  Created by Mac on 2023/2/1.
//  Copyright © 2023 sy. All rights reserved.
//

#import "SYCollectionViewRoundFlowLayout+Alignment.h"
#import "SYCollectionViewFlowLayoutUtils.h"

@implementation SYCollectionViewRoundFlowLayout (Alignment)

/// 将相同y位置的cell集合到一个列表中(竖向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr  in layoutAttributesAttrs) {
        
        NSMutableArray *dictArr = allDict[@(CGRectGetMidY(attr.frame))];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(CGRectGetMidY(attr.frame))] = arr;
        }
    }
    return allDict.allValues;
}

/// 将相同x位置的cell集合到一个列表中(横向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByXLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        NSMutableArray *dictArr = allDict[@(attr.frame.origin.x)];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(attr.frame.origin.x)] = arr;
        }
    }
    return allDict.allValues;
}

/// 根据不同对齐方式进行Cell位置计算
/// @param layoutAttributesAttrs 传入需计算的AttributesAttrs集合列表
/// @param toChangeAttributesAttrsList 用来保存所有计算后的AttributesAttrs
/// @param alignmentType 对齐方式
- (NSMutableArray *)evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs toChangeAttributesAttrsList:(NSMutableArray *_Nonnull *_Nonnull)toChangeAttributesAttrsList cellAlignmentType:(SYCollectionViewRoundFlowLayoutAlignmentType)alignmentType{
    NSMutableArray *toChangeList = *toChangeAttributesAttrsList;
    [toChangeList removeAllObjects];
    for (NSArray *calculateAttributesAttrsArr in layoutAttributesAttrs) {
        switch (alignmentType) {
            case SYCollectionViewFlowLayoutAlignmentTypeByLeft:{
                [self evaluatedCellSettingFrameByLeftWithWithSYCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case SYCollectionViewFlowLayoutAlignmentTypeByCenter:{
                [self evaluatedCellSettingFrameByCentertWithWithSYCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case SYCollectionViewFlowLayoutAlignmentTypeByRight:{
                NSArray* reversedArray = [[calculateAttributesAttrsArr reverseObjectEnumerator] allObjects];
                [self evaluatedCellSettingFrameByRightWithWithSYCollectionLayout:self layoutAttributesAttrs:reversedArray];
            }break;
            case SYCollectionViewFlowLayoutAlignmentTypeByRightAndStartR:{
                [self evaluatedCellSettingFrameByRightWithWithSYCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            default:
                break;
        }
        [toChangeList addObjectsFromArray:calculateAttributesAttrsArr];
    }
    return toChangeList;
}

#pragma mark - alignment

/// 计算AttributesAttrs左对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByLeftWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    //left
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = [SYCollectionViewFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].left;
            }
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [SYCollectionViewFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

/// 计算AttributesAttrs居中对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    
    //center
    UICollectionViewLayoutAttributes *pAttr = nil;
    
    CGFloat useWidth = 0;
            NSInteger theSection = ((UICollectionViewLayoutAttributes *)layoutAttributesAttrs.firstObject).indexPath.section;
            for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
                useWidth += attr.bounds.size.width;
            }
    CGFloat firstLeft = (self.collectionView.bounds.size.width - useWidth - ([SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:theSection]*layoutAttributesAttrs.count))/2.0;
    
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = firstLeft;
            }
            attr.frame = frame;
            pAttr = attr;
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [SYCollectionViewFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}


/// 计算AttributesAttrs右对齐
/// @param layout SYCollectionViewRoundFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithSYCollectionLayout:(SYCollectionViewRoundFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
//    right
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x - [SYCollectionViewFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section] - frame.size.width;
            }else{
                frame.origin.x = layout.collectionView.bounds.size.width - [SYCollectionViewFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].right - frame.size.width;
            }
        }else{
            
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

@end
