% EntanglementOfFormation.m

sigma_y = [0 -1i; 1i 0];

phi_plus = [1; 0; 0; 1] / sqrt(2);
phi_minus = [1; 0; 0; -1] / sqrt(2);
psi_plus = [0; 1; 1; 0] / sqrt(2);
psi_minus = [0; 1; -1; 0] / sqrt(2);


sigma_y_4 = kron(sigma_y, sigma_y);

phi_plus_dens = phi_plus * transpose(phi_plus);
phi_minus_dens = phi_minus * transpose(phi_minus);
psi_plus_dens = psi_plus * transpose(psi_plus);
psi_minus_dens = psi_minus * transpose(psi_minus);


disp('Phi Plus:')
input = phi_plus_dens;
disp(input)
disp(sigma_y_4 * input * sigma_y_4)

disp('Phi Minus:')
input = phi_minus_dens;
disp(input)
disp(sigma_y_4 * input * sigma_y_4)

disp('Psi Plus:')
input = psi_plus_dens;
disp(input)
disp(sigma_y_4 * input * sigma_y_4)

disp('Psi minus:')
input = psi_minus_dens;
disp(input)
disp(sigma_y_4 * input * sigma_y_4)
