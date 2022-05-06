% AmplitudeDampening.m
% matthias.maile@kaist.ac.kr

sigma_x = [0, 1;1 0];
sigma_z = [1, 0; 0, -1];

omega = 1;
hbar = 1;

% Hamiltonian
H = -1 * hbar * omega * sigma_z / 2;

% initial state 
% in the exercise |psi> = .5 * |1> + .5 * |0> was given which we will
% represent as a density operatore since the whole lindblad equation uses
% density operators
rho_0 = [1/2 0;0 1/2]; % confirm with the prof because it was given as a state that was not normalized

gamma = 2;
gamma_prime = @(t) 1 - exp(-2 * gamma * t);
E_0 = @(t) [1 0; 0 sqrt(1-gamma_prime(t))];
E_1 = @(t) [0 sqrt(gamma_prime(t)); 0 0];


% initial condition in interaction picture
rho_0_tilde = ctranspose(U(0,H)) * rho_0 * U(0,H);
rho_tilde = @(t) E_0(t) * rho_0_tilde * ctranspose(E_0(t)) + E_1(t) * rho_0_tilde * ctranspose(E_1(t));

rho = @(t) U(t,H) * rho_tilde(t) * ctranspose(U(t,H));

t = linspace(0,1,100);
X = linspace(0,1,length(t));
Z = linspace(0,1,length(t));
for i = 1:100
    X(i) = X_bloch(rho(t(i)));
    Z(i) = Z_bloch(rho(t(i)));
end
c = linspace(1,10,length(t)); % to better see time evolution direction
scatter(X, Z, [], c);
xlabel('X');
ylabel('Z');
colorbar
colormap jet

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

% functions computing x and z coordinates on the bloch sphere
function X = X_bloch(density_matrix)
    sigma_x = [0, 1;1 0];
    X = trace(density_matrix * sigma_x);
end

function Z = Z_bloch(density_matrix)
    sigma_z = [1, 0;0 -1];
    Z = trace(density_matrix * sigma_z);
end