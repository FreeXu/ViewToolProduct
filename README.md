# ViewToolProduct视图工具

1.自定义计算器

首先是界面布局

 使用UICollectionVIew完成界面的布局，每个cell中放button；将collectionview的每个item间距设置为0.5，控制每个cell的大小，模仿苹果自带的计算器界面；
 
 计算器计算模块
 
   想法：使用三个全局变量，分别记录两次输入的数值和运算方法；确认时，就可以进行对应的运算。
