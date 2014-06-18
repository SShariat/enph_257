h = findobj(gca,'Type','line');

X = get(h,'Xdata');
Y = get(h,'Ydata');

lX = length(X);
lY = length(Y);

lx = length(X{1});
ly = length(Y{1});

x = zeros(lx,lX);
y = zeros(ly,lY);

for i = 1:lX
    
    x(:,i) = X{i};
    y(:,i) = Y{i};
    
end

figure
hold on

plot(x(:,6),y(:,6), 'b')
plot(x(:,5),y(:,5), 'g')
plot(x(:,4),y(:,4), 'r')
plot(x(:,3),y(:,3), 'c')
plot(x(:,2),y(:,2), 'm')
plot(x(:,1),y(:,1), 'y')

save('RENAME_THIS.mat', 'x', 'y');