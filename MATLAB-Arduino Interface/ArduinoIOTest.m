delete(instrfindall)

a = arduino('COM10');

av = zeros(1, 10);

for t=1:10
    av(1,t) = a.analogRead(1);
    pause(1);
end

x = linspace(0,10,10);
plot(x,av);

delete(a);