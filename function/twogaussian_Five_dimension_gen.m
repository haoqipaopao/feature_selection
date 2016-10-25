function [X, Y, n1] = twogaussian_Five_dimension_gen(num, interval1, interval2, var1, var2, noiseFn, var3)

n1 = floor(num/2);
m = [-interval1,interval2];
C = [var1,0;0,var2];
x1 = mvnrnd(m,C,n1);

m = [interval1,-interval2];
x2 = mvnrnd(m,C,n1);


if noiseFn>0
    z = var3*randn(num,noiseFn);
    X = [[x1;x2], z];
else
    X = [x1;x2];
end
Y=zeros(2*n1,1)
Y(1:n1)=1;
Y(n1+1:2*n1)=2;