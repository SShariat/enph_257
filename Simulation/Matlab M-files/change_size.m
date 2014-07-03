function [ rd_t4_new ] = change_size( rd_t4 )
    [r,x_size]=size(rd_t4);
    rd_t4_new = zeros(1,x_size*2);
    for i=1:x_size-1
        j=(i-1)*2+1;
        rd_t4_new(1,j) = rd_t4(1,i);
        rd_t4_new(1,j+1)= (rd_t4(1,i)+rd_t4(1,i+1))/2;
    end
    rd_t4_new(1,x_size*2)=rd_t4(1,x_size);
    rd_t4_new(1,x_size*2-1)=(rd_t4(1,x_size-1)+rd_t4(1,x_size))/2;
end

