# CDL_PaoDisPlay
借鉴code4app 一个云标签  实现渐变弹出动画 雨滴冒泡

初始化view 
paoView = [[CDL_paoView alloc] initWithFrame:CGRectMake(0, 110, 320, 500)];
paoView.delagate = self;
[self.view addSubview:paoView];

初始数据源并赋值
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

![image](https://github.com/TinyQ/TQMultistageTableView/blob/master/READMEIMAGE/TQTableView.gif)
