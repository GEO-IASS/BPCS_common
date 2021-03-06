function [Z] = MultSeededHadamardTransposeSquarred(X, J, numBlockL, numBlockC, Mblock, Nblock)
% Multiplication of a squarred seeded Hadamard transposed operator with a vector

if (isrow(X) ); X = X'; X = [X; zeros(Nblock, 1)];
else X = [X; zeros(Nblock, 1)]; end
Z = zeros(numBlockC * Nblock, 1);

lastZ = 1;
for c = 1 : numBlockC
    
    if (c > 2); u = sum(Mblock(1 : c - 2) ) + 1;
    else u = 1; end;
    
    Y = 0;
    for l = c - 1 : numBlockL
        
        if (c == 1); l = l + 1; l = min(l, numBlockL); end
        
        if (J(l, c) == 0); break; end
        
        Y = Y + J(l, c) * sum(X(u : u + Mblock(l) - 1) ) * ones(Nblock, 1);
        u = u + Mblock(l);
    end
    
    Z(lastZ : lastZ + Nblock - 1) = Y;
    lastZ = lastZ + Nblock;
end

if (isrow(X) ); Z = Z'; end

end