%   draw histogram
%%
load('csi_data.mat');
% load('csi_data_1217_n10.mat');
% load('csi_1217_n2.mat');
GAP = 0.02;
% GAP = 0.2;

%%
% log_csi = {log(csi_data{1}), log(csi_data{2}), log(csi_data{3})};
% log_csi = {log(csi_data{3})/log(1.1), log(csi_data{2})/log(1.1), log(csi_data{1})/log(1.1)};
log_csi = {log(csi_data{3}), log(csi_data{2}), log(csi_data{1})}; %
min_csi = min([ log_csi{1}, log_csi{2}, log_csi{3}]); %
max_csi = max([ log_csi{1}, log_csi{2}, log_csi{3}]); %
xRange = ceil( min_csi-1):GAP:ceil( max_csi+GAP);

num_vec = {[],[],[]}; %
figure;
clf;
hold on;
for i=1:length(log_csi)
    num_vec{i} = hist(log_csi{i},xRange);
end
bar(xRange,num_vec{1},'r');
bar(xRange,num_vec{2},'g');
bar(xRange,num_vec{3},'b');
xlabel('log(varience)');
ylabel('count');
legend('static','moving block','moving');

%% % get threshold
[thr_arr, thre_ind_arr] =get_thre(num_vec, xRange);

max_hist = max([num_vec{1},num_vec{2},num_vec{3}]); %
for i=1:length(thr_arr)
    plot([thr_arr(i),thr_arr(i)],[0,max_hist],'-m');
end
hold off;