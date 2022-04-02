% Grovers.m
% Function and execution to simulate Grover's algorithm
% As a source for the algorithm and initial state I used the original Paper
% from Grover from 1996

close all

% % determining opt_queries(n)
% n_min = 2;
% n_max = 5;
% opt_queries = zeros(n_max - n_min, 1);
% for n = n_min:n_max
%     [queries, probability] = QueriesProbalities(n);
%     
%     opt_queries(n + 1 - n_min) = QueriesForBestProbability(queries, probability);
% end
% 
% hold on
% n_array = n_min:n_max;
% scatter(n_array, opt_queries);
% scatter(n_array, floor(2.^(n_array / 2) * pi / 4));
% scatter(n_array, 2.^n_array);

n = 7;
[probabilities, queries] = GroverImproved(n, 2^(n/2));

scatter(queries, probabilities);



function opt_queries = QueriesForBestProbability(queries, probability)
    [M, I] = max(probability);
    opt_queries = queries(I(1));
end


function [queries, probability] = QueriesProbalities(n)
    probability = zeros(n, 1);
    queries = zeros(n, 1);

    for i = 1:(2^n)
        [state, correct_N] = MyGrover(n, i);

        probability(i) = state(correct_N)^2;
        queries(i) = i;
    end
end

% function that makes up to max_queries on n qubits and returns the
% probabilites
function [probabilities, queries] = GroverImproved(n, max_queries)
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


% n is the amount of input bits
function [state, correct_N] = MyGrover(n, queries)
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

