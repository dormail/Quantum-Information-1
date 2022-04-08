% QuantumFourierTransformatio.m

clear
close all

q1 = [1;0];
q2 = [0;1];
q3 = [1;0];
input = kron(q1, kron(q2, q3));

output = ThreeQubit(input)

matrix = QFTMatrix(3)
otherOuput = matrix * input

output - otherOuput % approx 0 so it works

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
    ControlledS(4,4) = exp(pi * i / 2);

    % T gate from the lecture, called R_3 in wikipedia
    % here Q3 controlls Q1, so it is already defined as 2^3 dim
    ControlledT = eye(8);
    ControlledT(6,6) = exp(pi * i / 4);

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

% constructs the matrix for the QFT for n qubist
function output = QFTMatrix(n)
    N = 2^n;
    omega = exp(2 * pi * i / N);
    output = ones(N,N);
    % i row j column
    for row=1:N
        for column=1:N
            output(row,column) = omega^((row-1) * (column-1));
        end
    end
    output = output / sqrt(N);
end