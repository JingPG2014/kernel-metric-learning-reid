% Test the partition file generated by "Set_Partition" or other functions
% Randomly pick one partition
% By Mengran Gou @ Robust Lab at NEU
%    04/11/2014
%%
clc
clear 
datasetname = 'cuhk03_labeled';
load(['Feature/' datasetname, '_Partition_Random.mat']);
load(['dataset/', datasetname, '_Images.mat'],'gID','camPair');

if strfind(datasetname, 'cuhk')
    gID = gID + camPair*1000;
end
tmpID = randi(10,1,1)
partition = Partition(tmpID);
test = gID(partition.idx_test);
train = gID(partition.idx_train);

% Check the intersection of the test and train individuals, should be 0 
fprintf('Intersection of training and testing identities (should be 0): %d\n',numel(intersect(test,train)));
 

% test debug
uID = unique(test);
tmpGal = zeros(size(partition.ix_test_gallery,1),numel(uID));
tmpPro = zeros(size(partition.ix_test_gallery,1),numel(uID));
for i = 1:numel(uID)
    tmpidx = find(test == uID(i));
    % get the number of gallary images for each test individual
    tmpGal(:,i) = sum(partition.ix_test_gallery(:,tmpidx),2);
    % get the number of prob images for each test individual
    tmpPro(:,i) = sum(~partition.ix_test_gallery(:,tmpidx),2);
end

% 1 for single shot
fprintf('Maximum number of gallery images among the testing set (1 for single shot): %d\n', max(max(tmpGal)));
% >0 
fprintf('Minimum number of prob images among the testing set (>0): %d\n',min(min(tmpPro)));   
    


% train debug
uID = unique(train);
tmpGal = zeros(size(partition.ix_train_gallery,1),numel(uID));
tmpPro = zeros(size(partition.ix_train_gallery,1),numel(uID));
for i = 1:numel(uID)
    tmpidx = find(train == uID(i));
    tmpGal(:,i) = sum(partition.ix_train_gallery(:,tmpidx),2);
    tmpPro(:,i) = sum(~partition.ix_train_gallery(:,tmpidx),2);
end
% 1 for single shot
fprintf('Maximum number of gallery images among the training set (1 for single shot): %d\n', max(max(tmpGal)));
% >0 
fprintf('Minimum number of prob images among the training set (>0): %d\n',min(min(tmpPro)));   


    