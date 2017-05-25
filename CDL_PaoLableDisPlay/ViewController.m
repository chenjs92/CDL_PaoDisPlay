//
//  ViewController.m
//  CDL_PaoLableDisPlay
//
//  Created by ChenJs92 on 17/5/25.
//  Copyright © 2017年 慧居智能. All rights reserved.
//

#import "ViewController.h"
#import "CDL_paoView.h"

@interface ViewController ()<selectPaoViewLableDelegate>{
    CDL_paoView *paoView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    
    paoView = [[CDL_paoView alloc] initWithFrame:CGRectMake(0, 110, 320, 500)];
    paoView.delagate = self;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 270, 50)];
    [btn setTitle:@"插入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchAddLableAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)touchAddLableAction:(id)sender{
    NSMutableArray<CDL_paoMessModel *> *sourceList = [NSMutableArray new];
    for (int i=0; i<50; i++) {
        NSString *name = [NSString stringWithFormat:@"hello_%d",i];
        CDL_paoMessModel *model = [[CDL_paoMessModel alloc] init];
        model.paoTitle = name;
        model.paoType = i%2;
        model.paoSourceId = i;
        [sourceList addObject:model];
    }
    
    paoView.speed = 0.1;
    paoView.sourcesList = sourceList;
    [self.view addSubview:paoView];
}

-(void)selectPaoViewWith:(NSInteger)row{
    NSLog(@"----%ld----",row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
