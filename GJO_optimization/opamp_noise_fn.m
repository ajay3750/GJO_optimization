function fposition = opamp_noise_fn(x)
    % Constants
    Vdd = 1;
    Vss = 0;
    Vtn = 0.2;
    Vtp = -0.2;
    mu_p = 4e-3;
    mu_n = 35e-3;
    ep = 8.854e-12;
    ep_ox = 3.9 * ep;
    tox = 2.5e-9;
    Cox = ep_ox / tox;
    k = 1.38e-23;
    T = 300;
    minLength = 100e-9;
    minWidth = 120e-9;
    maxLength = 500e-9;
    maxWidth = 30e-6;
    minWLRatio = 1;
    maxWLRatio = 100;

    % Extract parameters
    W1 = x(1);
    L1 = x(2);
    Vdd_opamp = x(3);
    Vss_opamp = x(4);

    % Calculate C_L
    C_L = x(5) * 1e-12 / 0.35;

    % Calculate Sn_f
    Sn_f = (16 * k * T) / (3 * 2 * pi * x(2) * 1e6 * x(3) * 1e-12) * (1 + (x(1) * 1e6) / (2 * pi * x(2) * 1e6 * (x(4) - Vss - Vtn + Vtp)));

    % Calculate Id_7
    Id_7 = x(1) * 1e6 * ((x(3) * 1e-12) + C_L);

    % Calculate L6
    L6 = sqrt((3 * mu_n * (Vdd_opamp - Vss_opamp) * (x(3) * 1e-12)) / (2 * 2 * pi * x(2) * 1e6 * ((x(3) * 1e-12) + C_L) * tand(x(8)));
    L6 = max(minLength, min(maxLength, L6));
    L6 = max(L6, minLength);

    % Calculate W6
    W6 = (2 * x(1) * 1e6 * ((x(3) * 1e-12) + C_L) * L6) / (mu_n * Cox * (Vdd_opamp - Vss_opamp)^2);
    W6 = max(minWidth, min(maxWidth, W6));
    W6 = max(W6, minWidth);

    % Other calculations for L2, L8, L5, W5, W8, L7, W7, L4, W4, W3, L3

    % Calculate the W/L ratio for various transistors
    WLRatio1 = W1 / max(L1, eps);  % Avoid division by zero by using eps
    WLRatio2 = W2 / max(L2, eps);
    WLRatio3 = W3 / max(L3, eps);
    WLRatio4 = W4 / max(L4, eps);
    WLRatio5 = W5 / max(L5, eps);
    WLRatio6 = W6 / max(L6, eps);
    WLRatio7 = W7 / max(L7, eps);
    WLRatio8 = W8 / max(L8, eps);

    % Apply the W/L ratio constraints
    W1 = max(minWLRatio * L1, min(maxWLRatio * L1, W1));
    W2 = max(minWLRatio * L2, min(maxWLRatio * L2, W2));
    W3 = max(minWLRatio * L3, min(maxWLRatio * L3, W3));
    W4 = max(minWLRatio * L4, min(maxWLRatio * L4, W4));
    W5 = max(minWLRatio * L5, min(maxWLRatio * L5, W5));
    W6 = max(minWLRatio * L6, min(maxWLRatio * L6, W6));
    W7 = max(minWLRatio * L7, min(maxWLRatio * L7, W7));
    W8 = max(minWLRatio * L8, min(maxWLRatio * L8, W8));

    % Calculate fposition
    fposition = (W1 * L1) + (W2 * L2) + (W3 * L3) + (W4 * L4) + (W5 * L5) + (W6 * L6) + (W7 * L7) + (W8 * L8);
end
