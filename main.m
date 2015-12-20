% Aim to read all CSI data

%%
moving_file = 'E:\0.正在处理ing\CSI\data\classified_data\moving';
mb_file = 'E:\0.正在处理ing\CSI\data\classified_data\moving_block';
stati_file = 'E:\0.正在处理ing\CSI\data\classified_data\static';
SEN_ANTENNA = 1;
REC_ANTENNA = 3;
SUBCARRIER = 30;
SUBCARRIER = 1;
nPerSec = 2;
TOTAL = SEN_ANTENNA*REC_ANTENNA*SUBCARRIER;

%%
file_class = {moving_file; mb_file; stati_file};
csi_data = {[],[],[]};
time_data = {[],[],[]};

for i=1:3
    fprintf('%s\n',file_class{i});
    files = dir(file_class{i});
    for j=3:length(files)
       fi = fullfile(file_class{i},files(j).name,'csi.dat');
       %% for each subcarrier
       COUNT = 1;
       for sed = 1:SEN_ANTENNA
          for rec =1:REC_ANTENNA
             for sub = 1:SUBCARRIER
                 fprintf('%s,\n sub:%d of %d\n', fi, COUNT, TOTAL);
                 tic
                 [time, csi]=getCSI(fi,sed,rec,sub); %,0);
                 toc
                 selected_ind = dilute(time, nPerSec);
                 csi_data{i} = [ csi_data{i}, var(csi(selected_ind))];
                 time_data{i} = [ time_data{i}; time(selected_ind)];
                 COUNT = COUNT +1;
                 toc
             end
          end
       end
    end
end

% function draw()