% QuantumFourierTransformatio.m

clear
close all

% testing the three qubit system
[eC, eM] = TestThreeQubit(0,1,1)
[eC, eM] = TestThreeQubit(1,1,1)
[eC, eM] = TestThreeQubit(1,0,1)
[eC, eM] = TestThreeQubit(0,0,1)

% a function which tests the circuit and matrix implementation for a 
% three qubit system
% i1 i2 i3 should be one or zero in this test
function [errorCircuit, errorMatrix] = TestThreeQubit(i1, i2,i3)
    % constructing the input
    if i1==1
        q1 = [0;1];
    else
        q1 = [1;0];
    end
    if i2==1
        q2 = [0;1];
    else
        q2 = [1;0];
    end
    if i3==1
        q3 = [0;1];
    else
        q3 = [1;0];
    end
    input = kron(q1, kron(q2, q3));

    % constructing the expected output
    o1 = [1; exp(2 * pi * 1i * 0.5 * i3)] / sqrt(2);
    o2 = [1; exp(2 * pi * 1i * (.5 * i2 + .25 * i3))] / sqrt(2);
    o3 = [1; exp(2 * pi * 1i * (.5 * i1 + .25 * i2 + .125 * i3))] / sqrt(2);
    expectedOutput = kron(o1, kron(o2, o3));

    CircuitResult = ThreeQubit(input);
    MatrixResult = QFTMatrix(3) * input;

    %CircuitResult - expectedOutput

    errorCircuit = norm(CircuitResult - expectedOutput);
    errorMatrix = norm(MatrixResult - expectedOutput);
end


% implementation of the Three Qubit Circuit (so every gate has a single
% matrix 
function output = ThreeQubit(input)
    H = [1 1;1 -1] / sqrt(2);
    H1 = kron(H, eye(4));
    H2 = kron(eye(2), kron(H, eye(2)));
    H3 = kron(eye(4), H);

    % This gate has been introduced as S gate in the lecture
    % wikipedia calls it R_2
    % because we use it between qubit 1 and 2 and 2 and 3, I only 
    % defined it as 2^2 dim and apply kron later
    ControlledS = eye(4);
    ControlledS(4,4) = exp(pi * 1i / 2);

    % T gate from the lecture, called R_3 in wikipedia
    % here Q3 controlls Q1, so it is already defined as 2^3 dim
    ControlledT = eye(8);
    ControlledT(6,6) = exp(pi * 1i / 4);
    ControlledT(8,8) = exp(pi * 1i / 4);

    % swap gate for 1 and 3
    Swap13 = eye(8);
    Swap13(2,2) = 0;
    Swap13(5,5) = 0;
    Swap13(4,4) = 0;
    Swap13(7,7) = 0;
    Swap13(2,5) = 1;
    Swap13(5,2) = 1;
    Swap13(4,7) = 1;
    Swap13(7,4) = 1;
    
    

    % operation
    output = H1 * input;
    output = kron(ControlledS, eye(2)) * output;
    output = ControlledT * output;
    
    output = H2 * output;
    output = kron(eye(2), ControlledS) * output;

    output = H3 * output;

    output = Swap13 * output;
end

% constructs the matrix for the QFT for n qubits
function output = QFTMatrix(n)
    N = 2^n;
    omega = exp(2 * pi * i / N);
    output = ones(N,N);
    for row=1:N
        for column=1:N
            output(row,column) = omega^((row-1) * (column-1));
        end
    end
    output = output / sqrt(N);
end