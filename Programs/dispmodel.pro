pro dispmodel, X,A,F,pder
bx = Alog10(A(1)^(2*X/3)+(1-A(1))^(2*X/3))/alog10(2)
F = (-3.5+1.5*A(0))*(2*X/3)+1-bx
pder = [[X],[-(2*X/3)*(A(1)^(2*X/3-1)-(1-A(1))^(2*X/3-1))/(Alog(2)*(A(1)^(2*X/3)+(1-A(1))^(2*X/3)))]]
end