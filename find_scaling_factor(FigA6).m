clear all
close all

u = -10:0.0011:10;
figure();
subplot(2,1,1);
max_factor = 10;

loss_val = zeros(1, max_factor);

for num_fac = 1:max_factor
    x0 = repmat([0], 1, num_fac);
    A = repmat([1], 1, num_fac);
    b = 10;
    % func = @(x) norm( 1./(1+ exp(-u)) - (1+1/length(x)*sum(erf(x'*u),1))/2 ,2); 
    func = @(x) norm( tanh(u) - 1/length(x) * sum(erf(x'*u),1) ,2); 
    x = fmincon(func, x0, A, b);
    loss = func(x);
    disp(loss);
    loss_val(num_fac) = loss;
    
    
    subplot(2,1,1);
    % plot(u, 1./(1+exp(-u)) - (1+1/length(x)*sum(erf(x'*u),1))/2);
    plot(u, tanh(u) - 1/length(x) * sum(erf(x'*u),1), 'LineWidth', 2);
    hold on;

    
    

end
ylim([-2 2]*1e-3);
ylabel('Error by reformulation');
xlabel('Input location')
legend('1 scaling factors', ...
       '2 scaling factors', ...
       '3 scaling factors', ...
       '4 scaling factors', ...
       '5 scaling factors', ...
       '6 scaling factors', ...
       '7 scaling factors', ...
       '8 scaling factors', ...
       '9 scaling factors', ...
       '10 scaling factors' ...
      );
set(gca, 'FontSize', 20);


subplot(2,1,2);
plot(1:max_factor, loss_val, 'o-', 'LineWidth', 2);
xticks([1:max_factor]);
ylabel('Optimization Loss');
xlabel('Number of scaling factors');
set(gca, 'FontSize', 20, 'YScale', 'log');
