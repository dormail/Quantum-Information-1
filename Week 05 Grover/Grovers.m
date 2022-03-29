% Grovers.m
% Function and execution to simulate Grover's algorithm
% As a source for the algorithm and initial state I used the original Paper
% from Grover from 1996

n = 6;
q = floor(sqrt(2^n) * pi/4)
MyGrover(n, q);
%sqrt(2^n) * pi/4


% n is the amount of input bits
function MyGrover(n, queries)
    N = 2^n;

    correct_N = round(1 + (N - 1) * rand(1))

    % (i)
    % state gets initialised as a even distribution
    state = ones(N,1) * 1/sqrt(N);

    % (ii) a)
    % constructing the U_f as a phase shifter for the correct state
    U_f = eye(N);
    U_f(correct_N, correct_N) = -1;

    % (ii) b)
    % constructing the diffusion matrix D
    D = ones(N,N);
    D = D * 2/N;
    for i = 1:N
        D(i,i) = -1 + 2/N;
    end


    % doing the queries as we defined them before
    for i=1:queries
        state = U_f * state;
        state = D * state;
    end

    disp(state);
    %return state;
end

