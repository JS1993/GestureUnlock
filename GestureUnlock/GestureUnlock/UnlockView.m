
//
//  UnlockView.m
//  GestureUnlock
//
//  Created by  江苏 on 16/4/23.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "UnlockView.h"

@interface UnlockView ()
@property(nonatomic,strong)NSMutableArray* seletedBtns;
@property(nonatomic,assign)CGPoint curP;
@end

@implementation UnlockView

-(NSMutableArray *)seletedBtns{
    
    if (_seletedBtns==nil) {
        _seletedBtns=[NSMutableArray array];
    }
    return _seletedBtns;
}

-(IBAction)pan:(UIPanGestureRecognizer*)pan{
    
    _curP=[pan locationInView:self];
    
    for (UIButton* btn in self.subviews) {
        //如果点在按钮内且未被选中，则加入选中数组，并且重新布局
        if (CGRectContainsPoint(btn.frame, _curP)&&btn.selected==NO) {
            
            btn.selected=YES;
            
            [self.seletedBtns addObject:btn];
        }
    }
    [self setNeedsDisplay];
    
    //手势结束时还原界面（这个手势结束的时候系统也会自动调用drawRect方法）
    if (pan.state==UIGestureRecognizerStateEnded) {
        
        NSMutableString* strM=[NSMutableString string];
        
        for (UIButton* btn in self.seletedBtns) {
            [strM appendFormat:@"%ld",btn.tag];
            btn.selected=NO;
        }
        
        //可以做密码匹配
        NSLog(@"密码：%@",strM);
        //清除选中按钮数组
        [self.seletedBtns removeAllObjects];
    }
}

-(void)awakeFromNib{
    
    //创建按钮
    for (int i=0; i<9; i++) {
        
        UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        btn.userInteractionEnabled=NO;
        btn.tag=i;
        [self addSubview:btn];
    }
    
}

- (void)drawRect:(CGRect)rect {
    
    if (self.seletedBtns.count==0) return;
    
    UIBezierPath* path=[UIBezierPath bezierPath];
    
    //把所有选中按钮之间连好线
    for (int i=0; i<self.seletedBtns.count; i++) {
        UIButton* btn=self.seletedBtns[i];
        if (i==0) {
           
            [path moveToPoint:btn.center];
            
        }else{
            
            [path addLineToPoint:btn.center];
            
        }
    }
    
    [path addLineToPoint:_curP];
    
    //设置线头样式
    path.lineCapStyle=kCGLineCapRound;
    //设置连接点样式
    path.lineJoinStyle=kCGLineJoinRound;
    path.lineWidth=8;
    [[UIColor greenColor] set];
    [path stroke];
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
