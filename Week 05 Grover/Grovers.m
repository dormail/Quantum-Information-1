% Grovers.m
% Function and execution to simulate Grover's algorithm
% As a source for the algorithm and initial state I used the original Paper
% from Grover from 1996

clear
close all
hold on

% the implementation and question 3 is below
% here is the part for question 2 regarding the optimal amount of queries
for n=3:6
    queries_opt = floor(sqrt(2^n)*pi/4);
    [probabilities, queries] = GroverTestQueries(n, 2^(n/2));
    scatter(queries / queries_opt, probabilities);
end

xlabel('queries / $(\sqrt{2^n} \cdot \frac{\pi}{4})$','interpreter','latex');
ylabel('Probability(correct state)')
saveas(gcf, 'OptimalQueries.png')
% the plot is normalized to the optimal queries, and you can see a peak 
% 1, so where amount of queries = optimal queries


% 3rd Question
close all

n_min = 2;
n_max = 11; % keep this one below 15 if you value your lifetime
n = n_min:n_max;
queries_opt = floor(sqrt(2.^n)*pi/4);
runtime = n_min:n_max;

for i=1:(n_max + 1 - n_min)
    tic;
    SimpleGrover(n(i),queries_opt(i));
    runtime(i) = toc;
end

hold on
scatter(n, runtime);
scatter(n, sqrt(2.^n));
set(gca, 'YScale', 'log');
xlabel('n');

legend('runtime', 'sqrt(2^n)');
saveas(gcf, 'Runtime.png');
% you can see in the plot that the actual runtime has a steeper slope
% compared to sqrt(2^n). Since it is a logartihmic plot, we can conclude
% that the runtime is not linear to sqrt(2^n) but much faster growing
close all

% function that makes up to max_queries on n qubits and returns the
% probability of the correct state for each amount of queries 
function [probabilities, queries] = GroverTestQueries(n, max_queries)
    max_queries = floor(max_queries);
    N = 2^n;

    probabilities = zeros(max_queries, 1);
    queries = 1:max_queries;

    correct_N = round(1 + (N - 1) * rand(1));

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
    for i=1:max_queries
        state = U_f * state;
        state = D * state;

        probabilities(i) = state(correct_N)^2;
    end
end





% n is the amount of input bits, queries the amount of queries
function [state, correct_N] = SimpleGrover(n, queries)
    N = 2^n;

    correct_N = round(1 + (N - 1) * rand(1));

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

    %disp(state);
end

