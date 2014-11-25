//
//  MYCollectionViewLayout.m
//  IrregularCollectionView
//
//  Created by iXiaobo on 14-11-24.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import "MYCollectionViewLayout.h"



@implementation MYCollectionViewLayout
//@synthesize itemWidth;
@synthesize delegate;

- (id)init
{
    if (self = [super init])
    {
      //  [self commonInit];
        self.insets = UIEdgeInsetsMake(12, 12, 12, 12);
        minimumColumnSpacing = 12.0f;
        minimumInteritemSpacing =12.0f;
        columnCount = 2;
        columnHeights = [[NSMutableArray alloc] init];
        allItemAttributes = [[NSMutableArray alloc] init];
        itemAttributes = [[NSMutableArray alloc] init];
       
    }
    return self;
}

//- (NSMutableArray *)columnHeights
//{
//    if (!columnHeights)
//    {
//        columnHeights = [NSMutableArray array];
//    }
//    return columnHeights;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
        minimumColumnSpacing = 12.0f;
        minimumInteritemSpacing =12.0f;
        columnCount = 2;
        columnHeights = [[NSMutableArray alloc] init];
        allItemAttributes = [[NSMutableArray alloc] init];
        itemAttributes = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
   
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0)
    {
        return;
    }
    
    self.delegate =  (id <MYCollectionViewLayoutDelegate> )self.collectionView.delegate;

    CGFloat width = self.collectionView.frame.size.width - self.insets.left - self.insets.right;
    itemWidth = floorf((width - (columnCount - 1) * minimumColumnSpacing) / columnCount);
    for (NSInteger idx = 0; idx < columnCount; idx++)
    {
        [columnHeights addObject:@(0)];
    }
    
    UICollectionViewLayoutAttributes *attributes;
    
    
    for (NSInteger i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        for (NSInteger j = 0; j < [self.collectionView numberOfItemsInSection:i] ; j++)
        {
           
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            NSUInteger columnIndex = [self shortestColumnIndex];
            CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
            CGFloat itemHeight = itemSize.height;
            CGFloat xOffset = self.insets.left + (itemWidth + minimumColumnSpacing) * columnIndex;
            CGFloat yOffset = [columnHeights[columnIndex] floatValue];
            attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            attributes.frame = CGRectMake(xOffset, yOffset, itemWidth, itemHeight);
        //    [itemAttributes addObject:attributes];
            [allItemAttributes addObject:attributes];
            columnHeights[columnIndex] = @(CGRectGetMaxY(attributes.frame) + minimumInteritemSpacing);
        }
    }
}

- (CGSize)collectionViewContentSize
{
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    if (numberOfSections == 0)
    {
        return CGSizeZero;
    }
    CGSize contentSize = self.collectionView.bounds.size;
    contentSize.height = [columnHeights[0] floatValue];
    return contentSize;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSMutableArray *layoutAttributes = [NSMutableArray array];
//    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
//    
//    for (NSIndexPath *indexPath in visibleIndexPaths) {
//        
//        UICollectionViewLayoutAttributes *attributes =
//        
//        [self layoutAttributesForItemAtIndexPath:indexPath];
//        
//        [layoutAttributes addObject:attributes];
//        
//    }
//    
//    return layoutAttributes;
    NSMutableArray* elementsInRect = [NSMutableArray arrayWithCapacity:16];
    
    //iterate over all cells in this collection
    for(NSUInteger i = 0; i < [self.collectionView numberOfSections]; i++)
    {
        for(NSUInteger j = 0; j < [self.collectionView numberOfItemsInSection:i]; j++)
        {
            //this is the cell at row j in section i
//            
//            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:j inSection:i];
//            UICollectionViewLayoutAttributes* attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//            //CGRect cellFrame = attr.frame;
            //see if the collection view needs this cell\
            
            UICollectionViewLayoutAttributes* attr = [allItemAttributes objectAtIndex:j];
            NSLog(@"frame:%@",NSStringFromCGRect(attr.frame));
            
           if( CGRectIntersectsRect(rect,attr.frame) )
           {
               [elementsInRect addObject:attr];
           }
            
        }
//    }
//    NSMutableArray* allAttributes = [[NSMutableArray alloc] init];
//    
//    allItemAttributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        
//    }
//    [allItemAttributes enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier, NSDictionary *elementsInfo, BOOL *stop) {
//        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *innerStop) {
//            if (CGRectIntersectsRect(rect, attributes.frame)) {
//                [allAttributes addObject:attributes];
//            }
//        }];
//    }];
    }
//    
    return [NSArray arrayWithArray:elementsInRect];
    
}

//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
//{
//    if (path.section >= [self.sectionItemAttributes count])
//    {
//        return nil;
//    }
//    if (path.item >= [self.sectionItemAttributes[path.section] count])
//    {
//        return nil;
//    }
//    return (self.sectionItemAttributes[path.section])[path.item];
//}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return ([allItemAttributes objectAtIndex:indexPath.item]);
}


//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)path
//{
//    UICollectionViewLayoutAttributes *attributes =
//    
//    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//    
//    
//    return attributes;
//    
//
//    return ([allItemAttributes objectAtIndex:path.item]);
//    
//}


//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind
//                                                                     atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
//                                                                  atIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

- (NSUInteger)shortestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat shortestHeight = MAXFLOAT;
    
    [columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CGFloat height = [obj floatValue];
         if (height < shortestHeight)
         {
             shortestHeight = height;
             index = idx;
         }
     }];
    
    return index;
}


- (NSUInteger)longestColumnIndex
{
    __block NSUInteger index = 0;
    __block CGFloat longestHeight = 0;
    
    [columnHeights enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         CGFloat height = [obj floatValue];
         if (height > longestHeight)
         {
             longestHeight = height;
             index = idx;
         }
     }];
    
    return index;
}




@end
