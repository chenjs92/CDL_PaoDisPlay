//
//  CDL_paoView.h
//  JingFM-RoundEffect
//
//  Created by ChenJs92 on 17/5/24.
//  Copyright © 2017年 isaced. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDL_paoMessModel.h"
@protocol selectPaoViewLableDelegate <NSObject>

-(void)selectPaoViewWith:(NSInteger)row;

@end

@interface CDL_paoView : UIView

@property (strong, nonatomic) id<selectPaoViewLableDelegate>delagate;
@property (strong, nonatomic) NSArray<CDL_paoMessModel *> *sourcesList;
@property (assign, nonatomic) float speed;

@end
