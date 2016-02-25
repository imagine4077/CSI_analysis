matlab scripts here are used to analysis CSI data that collected for experiments.

1. "read_bfee.cpp" and "read_bf_file.m" are imported from dhalperi/linux-80211n-csitool-supplementary( https://github.com/dhalperi/linux-80211n-csitool-supplementary)

2. [time, csi] = getCSI('E:\0.当前任务ing\csi\zw\data\151124-223523\csi.dat',1,3,1);

3. [thr_arr, thre_ind_arr] =get_thre(num_vec, xRange);

4. [z,x] = drawMesh('E:\0.正在处理ing\CSI\data\classified_data\moving\151211-222746\csi.dat',7,12);

5. script "draw.m" is used for plotting the histogram, then it computes the thresholds for every section and culculates the accuracy of classification.

**Here contains some data in this repository which were collected by imagine4077. Everyone can use it for research purpose**

+ To compile the .cpp file by matlab, try the command below in matlab CommandWindow:
> mex xxx.cpp
