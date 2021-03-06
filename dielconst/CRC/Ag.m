clear all; close all; clear classes; clc;

%% Silver on pp.144-145 in Section 12 of CRC Handbook of Chemistry and Physics, 92nd Ed., W. M. Haynes (Editor), CRC Press
%% Store data in column vectors.
eV = [
0.10
0.20
0.30
0.40
0.50
1.00
1.50
2.00
2.50
3.00
3.25
3.50
3.60
3.70
3.77
3.80
3.90
4.00
4.10
4.20
4.30
4.50
4.75
5.00
5.50
6.00
6.50
7.00
7.50
8.00
9.00
10.00
11.00
12.00
13.00
14.00
14.50
15.00
16.00
17.00
18.00
19.00
20.00
21.00
21.50
22.00
22.50
23.00
23.50
24.00
24.50
25.00
25.50
26.00
26.50
27.00
27.50
28.00
28.50
29.00
30.00
31.00
32.00
33.00
34.00
35.00
36.00
38.00
40.00
42.00
44.00
46.00
48.00
50.00
52.00
54.00
56.00
58.00
60.00
62.00
64.00
66.00
68.00
70.00
72.00
74.00
76.00
78.00
80.00
85.00
90.00
95.00
100.00
];

n = [
9.91 
2.84 
1.41 
0.91 
0.67 
0.28 
0.27 
0.27 
0.24 
0.23 
0.23
0.21 
0.23 
0.30 
0.53 
0.73 
1.30 
1.61 
1.73 
1.75 
1.73 
1.69 
1.61 
1.55 
1.45 
1.34 
1.25 
1.18 
1.14 
1.16 
1.33 
1.46 
1.52 
1.61 
1.66 
1.72 
1.64 
1.56 
1.42 
1.33 
1.28 
1.27 
1.29 
1.35 
1.37 
1.34 
1.26 
1.17 
1.10 
1.04 
0.99 
0.95 
0.91 
0.90 
0.89 
0.89 
0.89 
0.90 
0.91 
0.92 
0.93 
0.93 
0.92 
0.90 
0.88 
0.86 
0.89 
0.89 
0.90 
0.90 
0.90
0.90 
0.89 
0.88 
0.89 
0.88 
0.87 
0.87 
0.87 
0.88 
0.88 
0.88 
0.87 
0.83 
0.85 
0.85 
0.85 
0.85 
0.85 
0.85 
0.85 
0.86 
0.87
];

k = [90.27 45.70 30.51 22.89 18.32 9.03 5.79 4.18 3.09 2.27 1.86 1.42 1.13 0.77 0.40 0.30 0.36 0.60 0.85 1.06 1.13 1.28 1.34 1.36 1.34 1.28 1.18 1.06 0.91 0.75 0.56 0.56 0.56 0.59 0.64 0.78 0.88 0.92 0.91 0.86 0.80 0.75 0.71 0.75 0.80 0.87 0.93 0.94 0.93 0.90 0.87 0.83 0.78 0.74 0.69 0.65 0.62 0.59 0.57 0.56 0.54 0.53 0.53 0.51 0.49 0.45 0.44 0.39 0.37 0.35 0.33 0.32 0.31 0.29 0.28 0.17 0.26 0.24 0.22 0.21 0.21 0.21 0.21 0.20 0.18 0.17 0.16 0.15 0.14 0.11 0.08 0.06 0.04];
k = k.';

%% Convert the photon energies (in eV) to the wavelengths (in nm).
wvlen = PhysC.h * PhysC.c0 * 1e9 ./ eV;

% %% Reverse the data order, and make them column vectors.
% eV = eV(end:-1:1).';
% n = n(end:-1:1).';
% k = k(end:-1:1).';
% wvlen = wvlen(end:-1:1).';

%% Calculate the permittivity from n and k following the exp(+i w t) time dependence.
eps = (n - 1i*k).^2;

%% Plot real(eps) and imag(eps).  Compare with Fig.3 on p.4375 of Johnson.

nk_wvlen = 1;
eps_eV = 2;
eps_wvlen = 3;
eps_omega = 4;
q_omega = 5;
plotstyle = eps_eV;
figure;
switch plotstyle
    case nk_wvlen  % plot n and k
        loglog(wvlen, n, 'o-', wvlen, k, 'o-')
%         plot(wvlen, n, wvlen, k)
        legend('n', 'k', 'Location', 'SouthEast');
        xlabel 'wavelength (nm)'
%         axis([1e2 1e4 1e-2 1e2])
    case eps_eV  % plot real(eps) and -imag(eps)
        loglog(eV, abs(real(eps)), 'o-', eV, -imag(eps), 'o-')
        legend('\epsilon_1', '\epsilon_2', 'Location', 'SouthEast');
        xlabel 'Photon Energy (eV)'
%         axis([0.5 6.5 -7 7]);
    case eps_wvlen
        plot(wvlen, real(eps), 'o-', wvlen, -imag(eps), 'o-')
        legend('\epsilon_1', '\epsilon_2', 'Location', 'SouthEast');
        xlabel 'wavelength (nm)'
%         axis([1e2 1e4 1e-2 1e2])
    case eps_omega
        plot(2*pi./wvlen, real(eps), 'o-', 2*pi./wvlen, -imag(eps), 'o-')
        legend('\epsilon_1', '\epsilon_2', 'Location', 'SouthEast');
        xlabel '\omega (c/nm)'
    case q_omega
        omega = 2*pi./wvlen;
        deps1 = real(eps(2:end)) - real(eps(1:end-1));
        domega = omega(2:end) - omega(1:end-1);
        eps1_inter = (real(eps(2:end)) + real(eps(1:end-1)))/2;
        omega_inter = (omega(2:end) + omega(1:end-1))/2;
        numer = eps1_inter + omega_inter .* (deps1./domega);
        denom = -(imag(eps(2:end)) + imag(eps(1:end-1)));  % extra factor 2
        plot(2*pi./omega_inter, numer./denom, 'o-');
        xlabel 'wavelength (nm)'
        ylabel 'electric Q';
end
title(mfilename)

%% Save data.
save(mfilename, 'eV', 'n', 'k');
