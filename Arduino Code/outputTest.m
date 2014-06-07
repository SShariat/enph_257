outputs = zeros(1,6);
to_voltage = (5.0 / 1023.0);

for i = 0:5
    outputs(1,(i+1)) = a.analogRead(i) * to_voltage;
end
