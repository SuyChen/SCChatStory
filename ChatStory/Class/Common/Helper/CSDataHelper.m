//
//  CSDataHelper.m
//  ChatStory
//
//  Created by CSY on 2018/12/10.
//  Copyright © 2018 wdys. All rights reserved.
//

#import "CSDataHelper.h"


@implementation CSDataHelper
+ (NSArray *)getDataArrayWithType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:type ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *arr = dic[@"result"][@"stories"];
    
    NSArray *resultArray = [CSListModel mj_objectArrayWithKeyValuesArray:arr];
    
    return resultArray;
}
+ (NSArray *)getComedyListArray
{
    
   return [CSDataHelper getDataArrayWithType:@"All_Comedy_Storys"];
    
}
+ (NSArray *)getHorrorListArray
{
    
    return [CSDataHelper getDataArrayWithType:@"All_Horror_Storys"];
    
}
+ (NSArray *)getMysteryListArray
{
    
    return [CSDataHelper getDataArrayWithType:@"All_Mystery_Storys"];
    
}
+ (NSArray *)getRomanceListArray
{
    
    return [CSDataHelper getDataArrayWithType:@"All_Romance_Storys"];
    
}
+ (NSArray *)getScienceListArray
{
    
    return [CSDataHelper getDataArrayWithType:@"All_Sci-Fi_Storys"];
    
}

+ (NSArray *)carouselArray
{
    NSMutableArray *mutaArray = [NSMutableArray array];
    NSArray *array1 = [CSDataHelper getComedyListArray];
    CSListModel *model1 = array1[3];
    [mutaArray addObject:model1];
    NSArray *array2 = [CSDataHelper getHorrorListArray];
    CSListModel *model2 = array2[4];
    [mutaArray addObject:model2];
    NSArray *array3 = [CSDataHelper getMysteryListArray];
    CSListModel *model3 = array3[2];
    [mutaArray addObject:model3];
    NSArray *array4 = [CSDataHelper getRomanceListArray];
    CSListModel *model4 = array4[9];
    [mutaArray addObject:model4];
    NSArray *array5 = [CSDataHelper getScienceListArray];
    CSListModel *model5 = array5[9];
    [mutaArray addObject:model5];
    return mutaArray.copy;
    
}
+ (NSArray *)FeaturedStoryArray
{
    NSMutableArray *mutaArray = [NSMutableArray array];
    NSArray *array4 = [CSDataHelper getComedyListArray];
    CSListModel *model4 = array4[24];
    [mutaArray addObject:model4];
    
    NSArray *array1 = [CSDataHelper getComedyListArray];
    CSListModel *model1 = array1[15];
    [mutaArray addObject:model1];
    
    NSArray *array2 = [CSDataHelper getHorrorListArray];
    CSListModel *model2 = array2[4];
    [mutaArray addObject:model2];
    
    NSArray *array3 = [CSDataHelper getMysteryListArray];
    CSListModel *model3 = array3[4];
    [mutaArray addObject:model3];
    
    NSArray *array5 = [CSDataHelper getScienceListArray];
    CSListModel *model5 = array5[4];
    [mutaArray addObject:model5];
    
    NSArray *array6 = [CSDataHelper getRomanceListArray];
    CSListModel *model6 = array6[8];
    [mutaArray addObject:model6];
    return mutaArray.copy;
}
+ (NSArray *)NewStoryArray
{
    NSMutableArray *mutaArray = [NSMutableArray array];
    NSArray *array4 = [CSDataHelper getRomanceListArray];
    CSListModel *model4 = array4[11];
    [mutaArray addObject:model4];
    NSArray *array1 = [CSDataHelper getComedyListArray];
    CSListModel *model1 = array1[11];
    [mutaArray addObject:model1];
    NSArray *array2 = [CSDataHelper getHorrorListArray];
    CSListModel *model2 = array2[9];
    [mutaArray addObject:model2];
    NSArray *array3 = [CSDataHelper getMysteryListArray];
    CSListModel *model3 = array3[0];
    [mutaArray addObject:model3];
    NSArray *array5 = [CSDataHelper getScienceListArray];
    CSListModel *model5 = array5[12];
    [mutaArray addObject:model5];
    
    return mutaArray.copy;
}
+ (NSArray *)PopularStoryArray
{
    NSMutableArray *mutaArray = [NSMutableArray array];
    NSArray *array5 = [CSDataHelper getScienceListArray];
    CSListModel *model5 = array5[10];
    [mutaArray addObject:model5];
    NSArray *array2 = [CSDataHelper getComedyListArray];
    CSListModel *model2 = array2[4];
    [mutaArray addObject:model2];
    NSArray *array3 = [CSDataHelper getMysteryListArray];
    CSListModel *model3 = array3[3];
    [mutaArray addObject:model3];
    NSArray *array4 = [CSDataHelper getHorrorListArray];
    CSListModel *model4 = array4[4];
    [mutaArray addObject:model4];
    NSArray *array1 = [CSDataHelper getRomanceListArray];
    CSListModel *model1 = array1[8];
    [mutaArray addObject:model1];
   
    return mutaArray.copy;
}

+ (NSArray *)getAllStory
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    [mutableArray addObjectsFromArray:[CSDataHelper getComedyListArray]];
    [mutableArray addObjectsFromArray:[CSDataHelper getHorrorListArray]];
    [mutableArray addObjectsFromArray:[CSDataHelper getRomanceListArray]];
    [mutableArray addObjectsFromArray:[CSDataHelper getMysteryListArray]];
    [mutableArray addObjectsFromArray:[CSDataHelper getScienceListArray]];
    return mutableArray;
}

+ (NSArray *)getPopularStory
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (CSListModel *model in [CSDataHelper getAllStory]) {
        if (model.loveCount.integerValue > 7000) {
            [mutableArray addObject:model];
        }
    }
    return mutableArray.copy;
}

+ (NSArray *)moreStoryWithSameType:(NSString *)type
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSMutableArray *numArray = [NSMutableArray array];
    NSArray *arr = [NSArray array];
    if ([type isEqualToString:@"Romance"]) {
        arr = [CSDataHelper getRomanceListArray];
      
    }else if ([type isEqualToString:@"Comedy"]){
        arr = [CSDataHelper getComedyListArray];
       
    }else if ([type isEqualToString:@"Sci-Fi"]){
        arr = [CSDataHelper getScienceListArray];
     
    }else if ([type isEqualToString:@"Mystery"]){
        arr = [CSDataHelper getMysteryListArray];
       
    }else if ([type isEqualToString:@"Horror"]){
        arr = [CSDataHelper getHorrorListArray];
    }
    for (int i=0; i<arc4random()%3+2; i++) {
        int randomNum = arc4random()%(arr.count);
        if (![numArray containsObject:@(randomNum)]) {
            [numArray addObject:@(randomNum)];
            [mutableArray addObject:arr[randomNum]];
        }
    }
    return mutableArray.copy;
}

+ (CSStoryModel *)transferListModelToStoryModel:(CSListModel *)model
{
    NSString *str = model.uid;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    CSStoryModel *storymodel = [CSStoryModel mj_objectWithKeyValues:dic[@"result"]];
    BOOL isLeft = NO;
    CSMessageModel *lastModel = nil;
    for (NSInteger i = 0; i < storymodel.messages.count; i++) {
        
        CSMessageModel *model = storymodel.messages[i];
        if ([storymodel.story.genre isEqualToString:@"Romance"]) {
            model.storyType = CSStoryType_Romance;
            
        }else if ([storymodel.story.genre isEqualToString:@"Comedy"]){
            model.storyType = CSStoryType_Comedy;
            
        }else if ([storymodel.story.genre isEqualToString:@"Sci-Fi"]){
            model.storyType = CSStoryType_Science;
            
        }else if ([storymodel.story.genre isEqualToString:@"Mystery"]){
            model.storyType = CSStoryType_Mystery;
            
        }else if ([storymodel.story.genre isEqualToString:@"Horror"]){
            model.storyType = CSStoryType_Horror;
        }
        if (model.sender == nil) {
            model.cellType = CSCellType_Middle;
        }else{
            if (![lastModel.sender.name isEqualToString:model.sender.name]) {
                lastModel = model;
                isLeft = !isLeft;
                if (isLeft) {
                    model.cellType = CSCellType_Left;
                }else{
                    model.cellType = CSCellType_Right;
                }
            }else{
                if (isLeft) {
                    model.cellType = CSCellType_Left;
                }else{
                    model.cellType = CSCellType_Right;
                }
            }
        }
    }
    
    return storymodel;
}
//获取每个章节的数据
+ (NSArray *)getStoryEpisodeWithModel:(CSStoryModel *)model
{
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSInteger episodeCount = model.story.episodeCount.integerValue;
    NSString *str = model.story.uid;
    NSString *tempindex = model.story.episodeIndex.stringValue;
    for (NSInteger i = 1; i < episodeCount + 1; i++) {
        
        str = [str substringToIndex:str.length - 1];
        str = [str stringByAppendingString:@(i).stringValue];
        tempindex = @(i).stringValue;
        NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"json"];
        if (path) {
            NSData *data = [[NSData alloc] initWithContentsOfFile:path];
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            
            CSStoryModel *model = [CSStoryModel mj_objectWithKeyValues:dic[@"result"]];
            model = [CSDataHelper transferListModelToStoryModel:model.story];
            [mutableArray addObject:model];
        }
        
    }
    
    return mutableArray.copy;
}
//获取下一个章节的数据
+ (CSStoryModel *)getNextModelWithLastModel:(CSStoryModel *)storyModel
{
    NSString *str = storyModel.story.uid;
    NSString *tempindex = storyModel.story.episodeIndex.stringValue;
    
    NSInteger i = tempindex.integerValue + 1;
    str = [str stringByReplacingOccurrencesOfString:tempindex withString:@(i).stringValue];
    NSString *path = [[NSBundle mainBundle] pathForResource:str ofType:@"json"];
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    CSStoryModel *model = [CSStoryModel mj_objectWithKeyValues:dic[@"result"]];
     model = [CSDataHelper transferListModelToStoryModel:model.story];
    
    return model;
}

//保存本地
+ (void)saveReadingWithStoryModel:(CSStoryModel *)storyModel
{
    NSDictionary *dic = [storyModel mj_keyValues];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:CSReadingRecords];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    if (array.count > 0) {
        __block BOOL isCompare = NO;
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *uid = obj[@"story"][@"uid"];
            if ([uid isEqualToString:storyModel.story.uid]) {
                [mutableArray replaceObjectAtIndex:idx withObject:dic];
                isCompare = YES;
                *stop = YES;
            }
        }];
        if (!isCompare) {
            [mutableArray insertObject:dic atIndex:0];
        }
    }else{
        
        [mutableArray addObject:dic];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutableArray.copy forKey:CSReadingRecords];
    
}
+ (CSStoryModel *)getReadingWithStoryModel:(CSStoryModel *)storyModel
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:CSReadingRecords];
    __block CSStoryModel *model = nil;
    if (array.count > 0) {
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *uid = obj[@"story"][@"uid"];
            if ([uid isEqualToString:storyModel.story.uid]) {
                model = [CSStoryModel mj_objectWithKeyValues:obj];
                *stop = YES;
            }
        }];
        if (model) {
            return model;
        }else{
            return storyModel;
        }
    }else{
        
        return storyModel;
    }
    
}
@end
