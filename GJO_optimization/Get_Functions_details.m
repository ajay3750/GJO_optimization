function [lb, ub, dim, fobj] = Get_Functions_details(F)

switch F
    case 'F23'
        fobj = @F23;
        lb = [1, 10, 2, 0.2, -0.4, 1, 500, 1000, 0];
        ub = [5, 15, 5, 0.4, -0.2, 3, 600, 1100, 1];
        dim = 9;
        
    % Add cases for other functions if needed
    
    otherwise
        error('Invalid function name.');
end

end


% F23 - Your opamp noise function
function o = F23(x)
Vdd = 1;
Vss = 0;
Vtn = 0.2;
Vtp = -0.2;
mu_p = 4*10^(-3);
mu_n = 35*10^(-3);

ep = 8.854*10^(-12);
ep_ox = 3.9*ep;
tox = 2.5*10^(-9);
Cox = ep_ox/tox;

k = 1.38*10^(-23);
T = 300;

C_L = (x(3)*10^(-12))/0.35;
Sn_f = (16*k*T)/(3*2*pi*x(2)*10^6*x(3)*10^(-12))*(1+(x(1)*10^6)/(2*pi*x(2)*10^6*(x(4)-Vss-Vtn+Vtp)));

Id_7 = x(1)*10^6*((x(3)*10^(-12))+C_L);

%constraint
minLength = 100e-9;
minWidth = 120e-9;
maxLength = 120e-9; 
maxWidth = 30e-6; 

L6 = sqrt((3*mu_n*(x(7)-Vss)*(x(3)*10^(-12)))/(2*2*pi*x(2)*10^6*((x(3)*10^(-12))+C_L)*tand(x(8))));
L6 = max(minLength, min(maxLength, L6));
if (L6 < minLength)
    L6 = minLength;
elseif (L6 > maxLength)
    L6 = maxLength;
end

W6 = (2*x(1)*10^6*((x(3)*10^(-12))+C_L)*L6)/(mu_n*Cox*(x(7)-Vss)^2);
W6 = max(minWidth, min(maxWidth, W6)); % Ensure W6 is within limits
if (W6 < minWidth)
    W6 = minWidth;
elseif (W6 > maxWidth)
    W6 = maxWidth;
end

Id_5 = (x(3)*10^(-12))*x(1)*10^6;

L1 = 0.5*L6;
L1 = max(minLength, min(maxLength, L1))
L2 = L1;

W1 = (((2*pi*x(2)*10^6)^2)*(x(3)*10^(-12))*L1)/(mu_p*Cox*x(1)*10^6);

if(W1 < minLength)
    W1 = minLength;
elseif(W1 > maxWidth)
    W1 = maxWidth;
end
W2 = W1;
L8 = L1;
L8 = max(minLength, min(maxLength, L8));
L5 = L8;
L5 = max(minLength, min(maxLength, L5));
W5 = (2*x(1)*10^6*(x(3)*10^(-12))*L5)/(mu_p*Cox*(Vdd-x(5)-Vtp-((x(1)*10^6)/x(2)*10^6))^2);

if(W5 < 2*minLength)
    W5 = 2*minLength;
elseif(W5 > maxWidth)
    W5 = maxWidth;
end
W8 = W5;
L7 = L1;
L7 = max(minLength, min(maxLength, L7));
W7 = (W5/L5)*((L7*((x(3)*10^(-12))+C_L))/(x(3)*10^(-12)));

if(W7 < minLength)
    W7 = minLength;
elseif(W7 > maxWidth)
    W7 = maxWidth;
end

L4 = L1;
L4 = max(minLength, min(maxLength, L4));
W4 = (L4*(W6/L6)*(W5/L5))/(2*(W7/L7));

if(W4 < minLength)
    W4 = minLength;
elseif(W4 > maxWidth)
    W4 = maxWidth;
end

W3 = W4;
L3 = L4;
L3 = max(minLength, min(maxLength, L3));
disp('Width and Length Values:');
disp(['W1: ', num2str(W1), ', L1: ', num2str(L1)]);
disp(['W2: ', num2str(W2), ', L2: ', num2str(L2)]);
disp(['W3: ', num2str(W3), ', L3: ', num2str(L3)]);
disp(['W4: ', num2str(W4), ', L4: ', num2str(L4)]);
disp(['W5: ', num2str(W5), ', L5: ', num2str(L5)]);
disp(['W6: ', num2str(W6), ', L6: ', num2str(L6)]);
disp(['W7: ', num2str(W7), ', L7: ', num2str(L7)]);
disp(['W8: ', num2str(W8), ', L8: ', num2str(L8)]);

fposition = (W1*L1) + (W2*L2) + (W3*L3) + (W4*L4) + (W5*L5) + (W6*L6) + (W7*L7) + (W8*L8);
 o=fposition;

end

% Define getH function (no need to change)
function H = getH(g)
    if g <= 0
        H = 0;
    else
        H = 1;
    end
end
