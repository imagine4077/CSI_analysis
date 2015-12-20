function [ accuracy ] = ClassificationAccuracy( cell_hist_data, thre_ind_arr )
%CLASSIFICATIONACCURACY Summary of this function goes here
%   Culculate the accuracy of classification on training data
    sum_items = 0;
    correct_items = 0;
    intervals = length(thre_ind_arr);
    
    % _1_|_2_|_3 .. n-2_|_n-1_|_n_
    correct_items = correct_items + sum( cell_hist_data{1}(1:thre_ind_arr(1)));
    sum_items = sum_items + sum( cell_hist_data{1});
    fprintf('class 1: %f\n',sum( cell_hist_data{1}(1:thre_ind_arr(1)))/sum( cell_hist_data{1}));
    
    for i= 2:intervals
        correct_items = correct_items + sum( cell_hist_data{i}(thre_ind_arr(i-1):thre_ind_arr(i)));
        sum_items = sum_items + sum( cell_hist_data{i});
        fprintf('class %d: %f\n',i,sum( cell_hist_data{i}(thre_ind_arr(i-1):thre_ind_arr(i)))/sum( cell_hist_data{i}));
    end
    
    correct_items = correct_items + sum(cell_hist_data{ length(cell_hist_data)}( thre_ind_arr( intervals):end));
    sum_items = sum_items + sum( cell_hist_data{ end});
    fprintf('class 3: %f\n',sum(cell_hist_data{ length(cell_hist_data)}( thre_ind_arr( intervals):end))/sum( cell_hist_data{ end}));
    
    accuracy = correct_items/ sum_items;
end

