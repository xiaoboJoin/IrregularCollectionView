//
//  MYCollectionViewLayout.h
//  IrregularCollectionView
//
//  Created by iXiaobo on 14-11-24.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MYCollectionViewLayoutDelegate <NSObject>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MYCollectionViewLayout : UICollectionViewLayout
{
    NSMutableArray *columnHeights;
    NSMutableArray *allItemAttributes;
    NSMutableArray *itemAttributes;
    float minimumColumnSpacing;
    float minimumInteritemSpacing;
    NSInteger columnCount;
    float itemWidth;
    
}

//@property (nonatomic, strong) NSMutableArray *columnHeights;
//@property (nonatomic, strong) NSMutableArray *allItemAttributes;

@property (nonatomic) NSDictionary *layoutInformation;
//@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic) UIEdgeInsets insets;

@property (nonatomic, weak) id <MYCollectionViewLayoutDelegate> delegate;

@end


