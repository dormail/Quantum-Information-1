% AmplitudeDampening.m
% matthias.maile@kaist.ac.kr

sigma_z = [1, 0; 0, -1];
omega = 1;

% Hamiltonian
H = -1 * hbar * omega * sigma_z / 2;

rho_0 = [.5 0;0 .5]; % confirm with the prof because it was given as a state that was not normalized


% Time evolution operator
% matlab does some weird operation in exp() and expm() so I wrote it myself
% The hamiltonian is diagonal so the exp(H) is just the exp of the
% diagonale
function U = U(t, H) 
    hbar = 1; % lazy
    
    U = eye(2);
    U(1,1) = exp(-1i * H(1,1) * t / hbar);
    U(2,2) = exp(-1i * H(2,2) * t / hbar);
end