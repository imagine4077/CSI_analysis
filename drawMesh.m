function [ Z, x ] = drawMesh( file_name, low_t_bound, up_t_bound )
%DRAWMESH Summary of this function goes here
%   Detailed explanation goes here
    SEN_ANTENNA = 1;
    REC_ANTENNA = 3;
    SUBCARRIER = 30;
    
    csi_trace = read_bf_file(file_name);
    csi_trace = del_null(csi_trace);
    x = get_time(csi_trace);
    ind = find(x<up_t_bound& x>low_t_bound);
%     [X, Y] = meshgrid(x(ind),10:10:SEN_ANTENNA*REC_ANTENNA*SUBCARRIER*10);
%     X = [];
%     Y = [];
    Z = [];
    %% for each subcarrier
%      COUNT = 1;
     figure
     hold on
     for sed = 1:SEN_ANTENNA
        for rec =1:REC_ANTENNA
            for sub = 1:SUBCARRIER
                z = get_csi(csi_trace, sed, rec, sub);
%                 y = ones(size(z))*COUNT;
%                 COUNT = COUNT +1;
%                 mesh(x(ind),y(ind),z(ind));
%                 X = [X; x];
%                 Y = [Y; y];
                Z = [Z; log(z(ind)')];
             end
          end
     end
     meshc(Z);
     view(0,90);
     hold off;

end

function  [ csi_tr] = del_null( csi_trace)
% delete [] elements in CSI data
    len = length( csi_trace);
    flag = len;
    while( isequal(csi_trace{flag}, []))
        flag = flag- 1;
    end
    csi_tr = csi_trace(1:flag);
end

function [ vec ] = get_time( csi_trace )
    vec=zeros([size(csi_trace,1) 1]);
    base=csi_trace{1}.timestamp_low;
    exp2=2^31;
    for i=1:size(csi_trace,1)
        vec(i)=csi_trace{i}.timestamp_low-base;
        if(vec(i)<0)
            vec(i)=vec(i)+exp2;
        end
    end
    vec=vec/1000000;
end

function [ vec ] = get_csi( csi_trace, tx, rx, sc )
    vec=zeros([size(csi_trace,1) 1]);
    for i=1:size(vec,1)
        vec(i)=abs(csi_trace{i}.csi(tx,rx,sc));
    end 
end

function [ vec_out ] = slide_window( vec_in, w_size )
    vec_out=zeros([size(vec_in,1) 1]);
    half_size=fix(w_size/2);
    for i=1:size(vec_in,1)
        low=max(1,i-half_size+1);
        high=min(size(vec_in,1),i+half_size);
        vec_out(i)=mean(vec_in(low:high));
    end 
end