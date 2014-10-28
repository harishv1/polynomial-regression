% Clearing Variables, Closing figures, Clear Screen
clear variables
close all
clc
% Loading data
data_matrix= dlmread('database1a.txt', ' ');

% Generating random indices
random_numbers=randperm(200);
train_set_indices=random_numbers(:,1:100);
test_set_indices=random_numbers(:,101:200);

% Forming traning set and testing set
train_set_x= data_matrix(train_set_indices,1);
train_set_y= data_matrix(train_set_indices,2);

test_set_x= data_matrix(test_set_indices,1);
test_set_y= data_matrix(test_set_indices,2);

% Initializing Value of D to iterate through the whle data and running the polyreg
% function for all values of D.
dimensions_max=20;
training_loss_only=zeros(1,dimensions_max);
for i=1:20
    figure;
    [err,poly_coeff] = polyreg(data_matrix(:,1),data_matrix(:,2),i);
end
% Now running the polyreg function with random half of the data as training
% data and the rest 100 values as testing data. Also storing training loss
% and testing loss
training_loss=zeros(1,dimensions_max);
testing_loss=zeros(1,dimensions_max);
for j=1:dimensions_max
    figure;
    [err,poly_coeff,errT] = polyreg(train_set_x,train_set_y,j,test_set_x,test_set_y);
    training_loss(1,j)=err;
    testing_loss(1,j)=errT;
    hold on
end
poly_coeff;
% Plotting training_loss vs testing_loss 
figure;
hold on
plot(training_loss,'r');
plot(testing_loss,'g');
legend('training loss','testing loss');
axis([0,dimensions_max,0,0.8]);
% Printing the order of polynomial which gives the lowest testing loss.
% Printing the training loss and minimum testing loss at minimum testing
% loss.
% Finding the indices of minimum testing_loss
[r,c]=find(testing_loss==min(min(testing_loss)));
fprintf( 'Order of polynomial with lowest testing loss = %d\n', (c-1));
fprintf( 'Training loss at minimum testing loss = %d\n',training_loss(r,c));
fprintf( 'Minimum testing loss = %d\n',testing_loss(r,c));


