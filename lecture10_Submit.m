data = xlsread('catawba_data');
W = zeros(length(data),1);
losses = zeros(length(data),1);
for i = 1:length(W)
    W(i) = 33.3/(1+exp(0.15*(16.9-data(i,4))))+127/data(i,5);

    if W(i) > 37 && W(i) <= 40
        losses(i) = 0.25*2000*24;
    elseif W(i) > 40 && W(i) <= 42
        losses(i) = 0.50*2000*24;
    elseif W(i) > 42
        losses(i) = 2000*24;
    end
end

losses_dollars = (losses*100)/1000;
annual_losses = zeros(41,1);

for i = 1:41
    annual_losses(i) = sum(losses_dollars((i-1)*365+1:(i-1)*365+365));
end
figure;
histogram(annual_losses,100);
ylabel('Frequency');
xlabel('Losses $1000s');

sorted_losses = sortrows(annual_losses);
% 5 percent of 41 years is roughly 2 years. ergo, the company has a 5
% percent chance of losing a billion dollars.


changedtemps = data(:,4) + 2;
flow = data(:,5);
log_flows = log(flow);
whitened_flows = (log_flows - (mean(log_flows)))/std(log_flows);
changedflow = (whitened_flows+ 0.9*mean(log_flows))*1.2*std(log_flows);
updatedflow = exp(changedflow);

W2 = zeros(length(data),1);
losses2 = zeros(length(data),1);

for i = 1:length(W2)
    W2(i) = 33.3/(1+exp(0.15*(16.9-changedtemps)))+127/updatedflow;

    if W2(i) > 37 && W2(i) <= 40
        losses2(i) = 0.25*2000*24;
    elseif W2(i) > 40 && W2(i) <= 42
        losses2(i) = 0.50*2000*24;
    elseif W2(i) > 42
        losses2(i) = 2000*24;
    end
end

losses_dollars = (losses2*100)/1000;
annual_losses = zeros(41,1);

for i = 1:41
    annual_losses(i) = sum(losses_dollars((i-1)*365+1:(i-1)*365+365));
end
figure;
histogram(annual_losses,100);
ylabel('Frequency');
xlabel('Losses $1000s');


