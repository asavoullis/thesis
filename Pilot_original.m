clear
clc

SF = 7 ;    % spreading factor 6...12
BW = 125e3 ; %Hz 
fc = 915e6 ; %Hz
Power = 14 ; %dBm

message = "Hello";
disp(['Message Transmitted = ' char(message)])
message_chr = convertStringsToChars(message) ;
message_dbl = uint8(message_chr) ;

%% Sampling
Fs = 10e6; %sampling frequency
Fc = 921.5e6; %centre frequency
%% Transmit Signal
signalIQ = LoRa_Tx(message,BW,SF,Power,Fs,Fc - fc) ;
Sxx = 10*log10(rms(signalIQ).^2) ;
disp(['Transmit Power   = ' num2str(Sxx) ' dBm'])
% %% Plots
% figure(1)
% spectrogram(signalIQ,500,0,500,Fs,'yaxis','centered')
% figure(2)
% obw(signalIQ,Fs) ;
%% Received Signal
message_out = LoRa_Rx(signalIQ,BW,SF,2,Fs,Fc - fc) ;
Bit_errors_msg = sum(sum(message_dbl~=message_out));
%% Message Out
disp(['Message Received = ' char(message_out)])

