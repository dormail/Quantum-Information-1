% Grovers.m
% Function and execution to simulate Grover's algorithm


MyGrover(3, 5);

% n is the amount of input bits
function MyGrover(n, queries)
    N = 2^n;

    correct_n = round(1 + (n - 1) * rand(1));
    disp(correct_n);

    % constructing the U_f as a phase shifter for the correct state
    if correct_n > 1
        U_f = eye(2);
        for i = 1:(correct_n - 2)
            U_f = kron(U_f, eye(2));
        end
        U_f = kron(U_f, [1 0; 0 -1]);
    else
        U_f = [1 0;0 -1];
    end
    for i = 1:(n - correct_n)
        U_f = kron(U_f, eye(2));
    end

    % initial state: even distribution
    initial_state = ones(N,1) * 1/sqrt(N);



    disp(U_f * initial_state);

end

