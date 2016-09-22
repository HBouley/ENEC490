%read data
data = xlsread('natgas.xlsx');
data = data(:,1);
histogram(data);
plot(data);

%log transform
transformed_data = log(data);
histogram(transformed_data);
plot(transformed_data);

%put it into a matrix
years = length(data)/12;
monthly_matrix = reshape(transformed_data,12,years);
monthly_matrix = monthly_matrix';

%find sd stats for each (year?)
stats=zeros(12,2);
for i=1:12
    stats(i,1) = mean(monthly_matrix(:,i));
    stats(i,2) = std(monthly_matrix(:,i));
end
%lower price and highest variance is in April
january=1.4263+(0.4657*randn(100,1))
plot(january)
histogram(january)

july = 1.3884+(0.4753*randn(100,1))
histogram(july)

%number5 option 3 (hightest standard deviation) 
montly_stds = std(monthly_matrix,0,1);
%from this matrix, the 3rd column has the largest standard deviation
third = monthly_matrix(:,3);
synthetic = mean(third)+(randn(1000)*std(third));
%number6
real_data = exp(transformed_data);
histogram(real_data);
xlabel('Natural Gas Price');
ylabel('Frequency of Price');
%number8
yearly_matrix = reshape(transformed_data, 12, years);
subset1 = yearly_matrix(:,1:11)
reshape(subset1, 180, 1)
subset2 = yearly_matrix(:,12:15)
fitdist(max2vec2(subset1),'lognormal')
fitdist(subset2)
pdf()