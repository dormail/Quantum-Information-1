% Week 03
% Simulation of the quantum teleportation ciruit

% three initial states
% I am using the convention from Hayashi, that
% |1> = (0,1)^T and |0> = (1,0)^T
% so the basis is in one and zero
zero = [1;0];
one = [0;1];

syms a b;
psi = a * zero + b * one;

% the second and third inputs are given in the lecture,
% this could be done by hand or with our basis as defined before
phi12 = 1/sqrt(2) * (kron(one, one) + kron(zero, zero));

% The initial state is the product state of psi and phi12
% can be computed with the kronecker product
InitialState = kron(psi, phi12)

% first operation:
% CNOT12 and unity on 3 from kronecker
unity = eye(2);
CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0];
CNOT12 = kron(CNOT, [1 0;0 1]);
state1 = CNOT12 * InitialState

% second operation:
% Hadamard on 1, unity on 2 and 3
H = 1/sqrt(2) * [1, 1; 1, -1];
H1 = kron(H, unity);
H1 = kron(H1, unity);

state2 = H1 * state1

% third operation:
% CX on 2,3, unity on 1
% the CX ist doing basically the same as CNOT
% unity coming for 0 because of the operation acting
% on 2 and 1 being the controller
CX12 = kron(unity, CNOT);
state3 = CX12 * state2

% fourth operation:
% CZ on 1,2 a calculation by hand gave me the matrix 
CZ = eye(8);
%CZ(5,5) = -1;
CZ(6,6) = -1;
%CZ(7,7) = -1;
CZ(8,8) = -1;

%disp(CZ);
endstate = CZ * state3

% the vector endstate is alternating between a and b so looking
% at the structure of a product state we see that the third
% output is in the psi initial state 
% in fact it is a new product state
% which we can show by using the kronecker product to reproduce it
endstate_from_lecture = .5 * kron([1;1], kron([1;1], [a;b]))