## Introduction to the ggplot2 plotting package

# The ggplot2 package is tremendously popular because it allows you to create
# beautiful plots by describing the plot structure.
#ͨ������ͼ�Ľṹstructure��ggplot2����������Ư����ͼ

# Install and load the packages.
#��װ�����
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

# R �д������������ݼ�
# �����ʵ�����㽫ʹ�����ݼ� quakes.
# ��һ���ݰ�����쳼ã�Fiji������ĵص�.

# ��R help���ڲ鿴quakes����Ϣ
suppressWarnings(? quakes)

# Inspect the structure of the data (a data frame with 5 columns).
# �۲����ݵĽṹ��5�е�data frame��
str(quakes)

# �趨���壬���ݸ�������
theme_set(theme_gray(base_size = 18))

# ���Ƶ���ľ�γ��
# To create a plot, you have to specify the data, then map aesthetics to 
# columns in your data. In this example, you map the column long to the x-axis
# and lat to the y-axis.
# Then you add a layer with points (geom_point) and a layer to plot maps.
# Ҫ����һ��ͼ���������ѡ�����ݣ�Ȼ������һ���еĻ��Ƴ���������������У����ȶ�Ӧx�ᣬά�ȶ�Ӧy��
# �������Ӻ��е�Ĳ��(geom_point)���Լ�һ�����Ƶ�ͼ�Ĳ��
p0 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point() + 
    coord_map()
p0 

# You can use a number of different aesthetics, for example colour or size
# of the points.

# Map the depth column to the colour aesthetic.

# �����ʹ�����಻ͬ����������������ɫ�ʹ�С
# ����depthʹ����ɫ����
p1 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth)) + 
    coord_map()
p1

# Add size for magnitude. The bigger the magnitude, the larger the point.
# �õ�Ĵ�С��ʾ�𼶣���Խ�󣬵�Խ��
p2 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag)) + 
    coord_map()
p2

# You can control the transparancy of a plot object with the alpha aesthetic.
# High values of alpha (close to 1) are opaque, while low values (close to 0)
# are translucent.
# Add alpha level to hide overplotting, thus revealing detail.
# ʹ�� alpha�����ı������͸���ȣ�ֵΪ1����ȫ��͸����ֵΪ0ʱ��ȫ͸����
# ����alphaֵ����overploting���滭�ص���,ͬʱչ��ϸ�� 
p3 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag), alpha = 0.25) + 
    coord_map()
p3

# Change colour gradient by adding a gradient scale.
# ���ӵݱ䷶Χ�ı���ɫ�ݼ�ֵ
p4 <- ggplot(quakes, aes(x = long, y = lat)) + 
    geom_point(aes(colour = depth, size = mag), alpha = 0.25) + 
    coord_map() +
    scale_colour_gradient(low = "blue", high = "red")
p4

# Add a plot title.
# ���ӻ�ͼ�ı���
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
#������ͬһ�������ڻ��ƶ��ͼ
# grid��֧�ֿ��ƻ滭�ķ�Χ grob�ǻ������壨graphical object������д
#ggplot2�е�ggplotGrob������һ��ggplot2�������һ��grob��
# Ȼ��Ϳ���ʹ��grid���������ggplot�����������

theme_set(theme_grey(12) + theme(legend.key.size  =  unit(0.5, "lines")))

library(grid)
plot.new()
grid.draw(cbind(
    ggplotGrob(p1), 
    ggplotGrob(p2),
    ggplotGrob(p3),
    size = "last"
    ))


#�ܽ᣺ѧϰ��ggplot2 ��mapproj����grid���ʹ��
#ʹ��ggplot�ĸ��ֲ�������Ч�Ļ��ƺÿ���ͼ��
  # color    size       alpha     scale_colour_gradient ggtitle
  # ��ɫ     ��Ĵ�С  ͸����    ��ɫ�ĵݱ�             ����
#��ggplot���coord_map() :�ṩmapproj��ȫ��λ�ĵ�ͼͶӰ 
#grid�⣺ʹ��grid.draw()�����ggplotGrab()����һ�� 