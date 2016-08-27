#我的练习
#总结：学习了ggplot2 ，mapproj包，grid库的使用
#使用ggplot的各种参数，高效的绘制好看的图画
  # color    size       alpha     scale_colour_gradient ggtitle
  # 颜色     点的大小  透明度    颜色的递变             标题
#在ggplot后加coord_map() :提供mapproj中全方位的地图投影 
#grid库：使用grid.draw()将多个ggplotGrab()画在一起 

if (!require("ggplot2")) {
    install.packages("ggplot2")
}

library("ggplot2")
search()




