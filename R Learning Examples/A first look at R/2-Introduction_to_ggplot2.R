## Introduction to the ggplot2 plotting package

# The ggplot2 package is tremendously popular because it allows you to create
# beautiful plots by describing the plot structure.
#通过描述图的结构structure，ggplot2包可以制作漂亮的图

# Install and load the packages.
#安装载入包
#options(warn = -1)
suppressWarnings(
    if (!require("ggplot2", quietly = TRUE))
        install.packages("ggplot2", quiet = TRUE))
# mapproj is required for map projections.
suppressWarnings(
    if (!require("mapproj", quietly = TRUE))
        install.packages("mapproj", quiet = TRUE))
#options(warn = 0)

library("ggplot2", quietly = TRUE)
library("mapproj", quietly = TRUE)

# R 有大量的内置数据集
# 在这个实例中你将使用数据集 quakes.
# 这一数据包含了斐济（Fiji）地震的地点.

# 打开R help窗口查看quakes的信息
suppressWarnings(? quakes)

# Inspect the structure of the data (a data frame with 5 columns).
# 观察数据的结构（5列的data frame）
str(quakes)

# 设定字体，内容更加清晰
theme_set(theme_gray(base_size = 18))

# 绘制地震的经纬度
# To create a plot, you have to specify the data, then map aesthetics to 
# columns in your data. In this example, you map the column long to the x-axis
# and lat to the y-axis.
# Then you add a layer with points (geom_point) and a layer to plot maps.
# 要制作一个图表，你必须选定数据，然后将数据一列列的绘制出来，在这个例子中，经度对应x轴，维度对应y轴
# 接着添加含有点的层次(geom_point)，以及一个绘制地图的层次
p0 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point() + 
    coord_map()
p0 

# You can use a number of different aesthetics, for example colour or size
# of the points.

# Map the depth column to the colour aesthetic.

# 你可以使用许多不同的美化，例如点的颜色和大小
# 对列depth使用颜色美化
p1 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth)) + 
    coord_map()
p1

# Add size for magnitude. The bigger the magnitude, the larger the point.
# 用点的大小表示震级，震级越大，点越大
p2 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag)) + 
    coord_map()
p2

# You can control the transparancy of a plot object with the alpha aesthetic.
# High values of alpha (close to 1) are opaque, while low values (close to 0)
# are translucent.
# Add alpha level to hide overplotting, thus revealing detail.
# 使用 alpha美化改变物体的透明度（值为1是完全不透明，值为0时完全透明）
# 添加alpha值缓解overploting（绘画重叠）,同时展现细节 
p3 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag), alpha = 0.25) + 
    coord_map()
p3

# Change colour gradient by adding a gradient scale.
# 添加递变范围改变颜色递减值
p4 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag), alpha = 0.25) + 
    coord_map() +
    scale_colour_gradient(low = "blue", high = "red")
p4

# Add a plot title.
# 添加绘图的标题
p5 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag), alpha = 0.25) + 
    scale_colour_gradient(low = "blue", high = "red") + 
    ggtitle("Distribution of earthquakes near Fiji") +
    coord_map()  
p5

# Now plot multiple plots on the same graphic.
# The package "grid" is built into R and allows you to take control of the 
# plotting area. A grob is the abbreviation for "graphical object", and the 
# function ggplotGrob() in ggplot2 converts a ggplot2 object into a grob.
# You can then use the grid functions to combine your ggplot objects.
#现在在同一个画面内绘制多个图
# grid包支持控制绘画的范围 grob是画面物体（graphical object）的缩写
#ggplot2中的ggplotGrob函数将一个ggplot2对象放入一个grob中
# 然后就可以使用grid函数将你的ggplot对象组合起来

theme_set(theme_grey(12) + theme(legend.key.size  =  unit(0.5, "lines")))

library(grid)
plot.new()
grid.draw(cbind(
    ggplotGrob(p1), 
    ggplotGrob(p2),
    ggplotGrob(p3),
    size = "last"
    ))


#总结：学习了ggplot2 ，mapproj包，grid库的使用
#使用ggplot的各种参数，高效的绘制好看的图画
  # color    size       alpha     scale_colour_gradient ggtitle
  # 颜色     点的大小  透明度    颜色的递变             标题
#在ggplot后加coord_map() :提供mapproj中全方位的地图投影 
#grid库：使用grid.draw()将多个ggplotGrab()画在一起 
