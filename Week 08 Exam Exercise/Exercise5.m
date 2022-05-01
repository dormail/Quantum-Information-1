% implementation of a n=3 qubit grover search

one_qubit = [0; 1];
zero_qubit = [1; 0];

% input is all qubits set to zero
input = kron(zero_qubit, kron(zero_qubit, kron(zero_qubit, one_qubit)))

% x the the n+1th qubit
hadamard = [1, 1;1, -1] / sqrt(2);
hadamard4 = kron(eye(2), kron(eye(2), kron(eye(2), hadamard)));

% hadamard to all qubits
hadamard_all = kron(hadamard, kron(hadamard, kron(hadamard, hadamard)));

state = hadamard_all * input

% U_f: not operation if f(x)=1 so if th 3 qubits = 1 on the 4th one
% so the cases |1111> and |1110> should result in a not operation,
% the rest untouched
U_f = eye(2^4);
U_f(16,16) = 0;
U_f(15,15) = 0;
U_f(15,16) = 1;
U_f(16,15) = 1;

% now we create the diffusion operator
diffusion = eye(2^3);
diffusion = -1 * diffusion;
diffusion(1,1) = 1;

% the fourth quibit is unchanged
hadamard123 = kron(hadamard, kron(hadamard, hadamard));
diffusion = hadamard123 * diffusion * hadamard123;
diffusion = kron(diffusion, eye(2));


% iteration constist of U_f and diffusion
iteration = diffusion * U_f;

final_after1 = iteration * state
final_after2 = iteration * final_after1
final_after3 = iteration * final_after2
final_after4 = iteration * final_after3
final_after5 = iteration * final_after4
