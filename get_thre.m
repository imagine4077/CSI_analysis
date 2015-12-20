function [ rt_thres, rt_ind ] = get_thre( hist_data, xRange)
% Find each mu in every Gaussion distribution as initial threshold,
% Then drive them to right side and regard the threshold which get the
% max correct_rate as result.
%   Detailed explanation goes here
    [thre_arr, loc_arr] = get_mu( hist_data, xRange);
    rt_thres = ones(size(thre_arr))*Inf;
    rt_ind = loc_arr;
    max_rate = 0;
    
    for ind = 1:(length(thre_arr)-1)
        for i = loc_arr(ind):loc_arr(ind+1)
            cr = correct_rate( hist_data, i, ind);
            if(cr> max_rate)
               fprintf('%d : %d > %d, %f\n',ind,cr,max_rate, xRange(i));
               rt_thres(ind) = xRange(i);
               rt_ind(ind) = i;
               max_rate = cr;
            end
        end
    end
    
    max_rate = 0;
    for i = loc_arr(length(thre_arr)):length(xRange)
        cr = correct_rate( hist_data, i, length(thre_arr));
        if(cr> max_rate)
            fprintf('%d : %d > %d, %f\n',length(thre_arr),cr,max_rate, xRange(i));
            rt_thres(length(thre_arr)) = xRange(i);
            rt_ind( length(thre_arr)) = i;
            max_rate = cr;
        end
    end
    accuracy = ClassificationAccuracy( hist_data, rt_ind);
    fprintf('threshold: ');
    for i=1:length(rt_thres)
        fprintf('%f ', rt_thres(i));
    end
    fprintf('\naccuracy:%f\n', accuracy);
end

%% % assistant functions
function [ mu, loc_arr] = get_mu( cell_hist_data, xRange)
%   regard each class' distribution as a Gaussian distribution.
%   this function aims at find each mu in every distribution.
    mu = [];
    loc_arr = [];
    for i=1:length(cell_hist_data)-1
        [ val, loc] = max(cell_hist_data{i});
        mu = [mu, xRange(loc)];
        loc_arr = [loc_arr, loc];
    end
    
end

function [ cr] = correct_rate( cell_hist_data, thre_ind, n)
    correct_item_num = 0;
    for i=1:length(cell_hist_data)
        if(i<= n)
           correct_item_num = correct_item_num +  sum( cell_hist_data{i}(1:thre_ind-1));
        else
            correct_item_num = correct_item_num + sum( cell_hist_data{i}(thre_ind:length(cell_hist_data{i})));
        end
    end
    cr = correct_item_num;
end