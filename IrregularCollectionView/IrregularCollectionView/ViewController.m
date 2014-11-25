//
//  ViewController.m
//  IrregularCollectionView
//
//  Created by iXiaobo on 14-11-24.
//  Copyright (c) 2014年 iXiaobo. All rights reserved.
//

#import "ViewController.h"
#import "MYCollectionViewCell.h"
#import "MYRedCollectionViewCell.h"
#import "MYBlueCollectionViewCell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *_myCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self._myCollectionView setDelegate:self];
    [self._myCollectionView setDataSource:self];
    
//    MYCollectionViewLayout *mylayout = [[MYCollectionViewLayout alloc] init];
//    self._myCollectionView.collectionViewLayout = mylayout;
    
    [self._myCollectionView registerClass:[MYCollectionViewCell class] forCellWithReuseIdentifier:@"MYCollectionViewCell"];
//    [self._myCollectionView registerClass:[MYCollectionViewCell class] forCellWithReuseIdentifier:@"MYRedCollectionViewCell"];
//    [self._myCollectionView registerClass:[MYCollectionViewCell class] forCellWithReuseIdentifier:@"MYBlueCollectionViewCell"];
    
    // Do any additional setup after loading the view, typically from a nib.
    [self._myCollectionView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 120;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MYCollectionViewCell *cell = (MYCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"MYCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row%3==0)
    {
        cell.contentView.backgroundColor = [UIColor greenColor];
    }
    else if (indexPath.row%3==1)
    {
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    else if (indexPath.row%3==2)
    {
         cell.contentView.backgroundColor = [UIColor blueColor];
    }
    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row%3==0)
    {
        return CGSizeMake(142, 90);
    }
    else if (indexPath.row%3==1)
    {
        return CGSizeMake(142, 150);
    }
    else if (indexPath.row%3==2)
    {
        return CGSizeMake(142, 180);
    }
    else
    {
        return CGSizeMake(142, 180);
    }
}


//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    
//    
//    return UIEdgeInsetsMake(12, 12, 12, 12);
//    
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//     return 50.0f;
//}

//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//
//{
//    return 0.0f;
//}



@end
