
//
//  UnlockView.m
//  GestureUnlock
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "UnlockView.h"

@implementation UnlockView

- (void)drawRect:(CGRect)rect {
    
    //创建按钮
    for (int i=0; i<9; i++) {
        
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:btn];
    }
}

-(void)layoutSubviews{
    //给按钮布局
    //设置按钮宽高为图片宽高
    CGFloat wH=74;
    //初始化行列
    int col=3;
    int row=3;
    //算出按钮间距
    CGFloat margin=(self.bounds.size.width-wH*col)/(col+1);
    //初始化按钮的横纵左边
    CGFloat x=0;
    CGFloat y=0;
    for (int i=0; i<self.subviews.count; i++) {
        //取出按钮
        UIButton* btn=self.subviews[i];
        //计算位置
        x=margin+i%col*(wH+margin);
        y=margin+i/row*(wH+margin);
        
        btn.frame=CGRectMake(x, y, wH, wH);
        
    }
    
    
}

@end
