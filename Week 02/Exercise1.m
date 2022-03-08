% Exercise 1
% all the vectors will be assumed to be out of R^2
disp('--- Exercise 1 ---')
syms f1 f2 g1 g2 h1 h2;
f = [f1 f2];
g = [g1 g2];
h = [h1 h2];

% (a)
disp('(a)');
lhs = kron(f+g, h)
% [h1*(f1 + g1), h2*(f1 + g1), h1*(f2 + g2), h2*(f2 + g2)]
rhs = kron(f,h) + kron(g,h)
% [f1*h1 + g1*h1, f1*h2 + g1*h2, f2*h1 + g2*h1, f2*h2 + g2*h2]

disp('=> They are obviously the same if you compute the products');

% (c) 
% I will assume that it was meant to show
% a (x * y) = ax * y = x * (ay)
% with * being the kronecker (tensor) product
disp('(c)');
syms a;

lhs = a*kron(f, g)
% [a*f1*g1, a*f1*g2, a*f2*g1, a*f2*g2]
mid = kron(a*f, g)
% [a*f1*g1, a*f1*g2, a*f2*g1, a*f2*g2]
rhs = kron(f, a*g)
% [a*f1*g1, a*f1*g2, a*f2*g1, a*f2*g2]

% here even the isequal works
isequal(lhs, rhs) % ans = logical 1
isequal(lhs, mid) % ans = logical 1

% (d)
syms a1 a2 b1 b2 c1 c2 d1 d2;
psi1 = [a1 a2]; % psi 1
phi1 = [b1 b2]; % phi 1
psi2 = [c1 c2]; % psi 2
phi2 = [d1 d2]; % phi 2

lhs1 = kron(psi1, phi1);
lhs2 = kron(psi2, phi2);
lhs = lhs1 * transpose(lhs2)
% a1*b1*c1*d1 + a1*b2*c1*d2 + a2*b1*c2*d1 + a2*b2*c2*d2

rhs1 = phi1 * transpose(phi2);
rhs2 = psi1 * transpose(psi2);
rhs = rhs1 * rhs2
% (a1*c1 + a2*c2)*(b1*d1 + b2*d2)

% they are the same again if you multiply the two terms for the rhs 
% with each other