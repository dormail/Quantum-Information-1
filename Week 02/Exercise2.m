% Exercise 2
disp('--- Exercise 2 ---')

I = eye(2);
H = 1 / sqrt(2) * [1 1;1 -1];
Rx = [0 -i; -i 0]

disp('(a)');
kron(I, H)
disp('(b)');
kron(H, I)
disp('(c)');
kron(I, Rx)
disp('(d)');
kron(Rx, I)
disp('(e)');
kron(Rx, Rx)
