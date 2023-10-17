M=4;                                             % Modulation order
set = [0 0; 0 1; 1 0; 1 1]; % Transmitted possibilities
 
% Generate a 10000-by-2 column vector of uniformly distributed random integers from the sample interval [0,1].
B = randi([0 1], 10000,2);
 
% List of symbols
S = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
 
% Convert the binary vector S to decimal value D
D = bi2de(B,'left-msb');
 
% The binary sequence is grouped into pairs of bits, which are mapped into the corresponding signal components
X = S(D+1,:);
 
%SNR in dB
snrdB = 0:8;
 
%Creating a loop
for i = 1:length(snrdB)
    Y = awgn(X,snrdB(i),'measured');% Adding White Gaussian noise to x
end
 
corr=Y*S';                          % Correlataion between Y and trasnpose S
[val,indx] = max(corr,[],2);        % Finding the maximum correlation
R = set(indx,:);                    % Received signal
berEst(i)=  biterr(B,R)./20000;
berTheory = berawgn(snrdB,'fsk',M,'coherent')
semilogy(snrdB,berEst,'*')
hold on
semilogy(snrdB,berTheory,'r');
grid on;
legend('Estimated BER','Theoretical BER')
title('Theoretical Bit Error Rate');
xlabel('Eb/No (dB)');
ylabel('Bit Error Rate');
grid on;