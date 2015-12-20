function [ rt_ind_arr ] = dilute( time, nPerSec)
%DILUTE Summary of this function goes here
%   To attenuate the input and get coarse granularity data.
%     upbound = ceil( time( end-1));
    upbound = 15;
    base_ind = 0;
    rt_ind_arr = [];
    for sec =1:upbound
        all_ind = find( time((base_ind+1):end)<sec);
        n = length(all_ind);
        randPermutation = randperm( n);
        fprintf('%d sec ,length:%d \n',sec, n);
        if( n>= nPerSec)
            randInd = randPermutation(1:nPerSec) + base_ind;
        else
           randInd = randPermutation;
        end
        rt_ind_arr = [rt_ind_arr, randInd];
        base_ind = base_ind + length(all_ind);
    end

end