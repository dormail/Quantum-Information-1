clear all
% Test the gates
assert(X(1) == 0);
assert(X(0) == 1);

assert(CNOT(0,0) == 0);
assert(CNOT(0,1) == 1);
assert(CNOT(1,0) == 1);
assert(CNOT(1,1) == 0);

assert(Toffoli(0,0,0) == 0);
assert(Toffoli(0,0,1) == 1);
assert(Toffoli(0,1,0) == 0);
assert(Toffoli(0,1,1) == 1);
assert(Toffoli(1,0,0) == 0);
assert(Toffoli(1,0,1) == 1);
assert(Toffoli(1,1,0) == 1);
assert(Toffoli(1,1,1) == 0);

fprintf('\n');

for A = 0:1
    for B = 0:1
        [A_out, B_out, res] = NULL(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = IDENTITY(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Transfer_A(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Transfer_B(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = NOT_A(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = NOT_B(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = AND(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = NAND(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = OR(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = NOR(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = XOR(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = XNOR(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Implication_AB(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Implication_BA(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Inhibition_AB(A,B,0);
        fprintf('%d ', res);
        [A_out, B_out, res] = Inhibition_BA(A,B,0);
        fprintf('%d ', res);

        fprintf('\n')
    end
end

fprintf('=> Looks like the table in the exercise\n');

% now define the required gates with the definied gates
% the functions require C=0 to work (as stated in the exercise
function [A_out, B_out, output] = NULL(A, B, C)
    A_out = A;
    B_out = B;
    output = C;
end

function [A_out, B_out, output] = IDENTITY(A, B, C)
    A_out = A;
    B_out = B;
    output = X(C);
end

function [A_out, B_out, output] = Transfer_A(A, B, C)
    A_out = A;
    B_out = B;
    output = CNOT(A, C);
end

function [A_out, B_out, output] = Transfer_B(A, B, C)
    A_out = A;
    B_out = B;
    output = CNOT(B, C);
end

function [A_out, B_out, output] = NOT_A(A, B, C)
    A_out = A;
    B_out = B;
    output = CNOT(A, C);
    output = X(output);
end

function [A_out, B_out, output] = NOT_B(A, B, C)
    A_out = A;
    B_out = B;
    output = CNOT(B, C);
    output = X(output);
end

function [A_out, B_out, output] = AND(A, B, C)
    A_out = A;
    B_out = B;
    output = Toffoli(A,B,C);
end

function [A_out, B_out, output] = NAND(A, B, C)
    A_out = A;
    B_out = B;
    output = Toffoli(A,B,C);
    output = X(output);
end

function [A_out, B_out, output] = OR(A, B, C)
    A_mid = X(A);
    B_mid = X(B);
    output = Toffoli(A_mid,B_mid,C);
    A_out = X(A_mid);
    B_out = X(B_mid);
    output = X(output);
end

function [A_out, B_out, output] = NOR(A, B, C)
    A_mid = X(A);
    B_mid = X(B);
    output = Toffoli(A_mid,B_mid,C);
    A_out = X(A_mid);
    B_out = X(B_mid);
end

function [A_out, B_out, output] = XOR(A, B, C)
    A_out = A;
    B_out = B;
    C_mid = CNOT(A, C);
    output = CNOT(B, C_mid);
end

function [A_out, B_out, output] = XNOR(A, B, C)
    A_out = A;
    B_out = B;
    C_mid = CNOT(A, C);
    output = CNOT(B, C_mid);
    output = X(output);
end


function [A_out, B_out, output] = Inhibition_AB(A, B, C)
    A_out = A;
    B_mid = X(B);
    output = Toffoli(A, B_mid, C);
    B_out = X(B_mid);
end

function [A_out, B_out, output] = Implication_AB(A, B, C)
    A_out = A;
    B_mid = X(B);
    output = Toffoli(A, B_mid,C);
    B_out = X(B_mid);
    output = X(output);
end

function [A_out, B_out, output] = Inhibition_BA(A, B, C)
    A_mid = X(A);
    output = Toffoli(A_mid, B, C);
    A_out = X(A_mid);
    B_out = B;
end

function [A_out, B_out, output] = Implication_BA(A, B, C)
    A_mid = X(A);
    output = Toffoli(A_mid, B, C);
    A_out = X(A_mid);
    B_out = B;
    output = X(output);
end




% defining the used gates
function output = Toffoli(c1, c2, x)
    if c1 == 1
        if c2 == 1
            output = X(x);
        else
            output = x;
        end
    else
        output = x;
    end
end

function output = CNOT(control, x)
    if control == 1
        output = X(x);
    else
        output = x;
    end
end


function X = X(x)
    if x == 1
        X = 0;
    else
        X = 1;
    end
end
