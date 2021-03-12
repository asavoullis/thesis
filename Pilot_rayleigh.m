clear
clc

%CHANGE SF
%the lower the SF , the lower the noise you need to jam it
% the more chirps you send per second the more resistant is to White noise
SF = 7 ;    % spreading factor 7...12
BW = 125e3 ; %Hz    
fc = 915e6 ; %Hz
Power = 14 ; %dBm

%message

message = 'aaa';
disp(['Message Transmitted = ' char(message)])
message_chr = convertStringsToChars(message) ;
message_dbl = uint8(message_chr) ;
disp(message_dbl);  %coverts it into ascii 

%% Sampling
Fs = 10e6; %sampling frequency
Fc = 921.5e6; %centre frequency

%% Transmit Signal (input)
signalIQ = LoRa_Tx(message,BW,SF,Power,Fs,Fc - fc) ;

save('signalIQ');


%factor = 1e-3;
message_out=message;
temp=0;
%mean_='';
%std_='';
% signal_demod = 0;
% signal_demod1 = 0;
% signal_demod2 = 0;

while char(message_out) == message
    temp = signalIQ;
    
    %randn from a normal distribution
    %noise = randn(size(temp));
    %mean_ = mean(noise);
    %std_ = std(noise);
    %temp = temp +  factor*noise;
    %factor = factor * 5;
    
    Sxx = 10*log10(rms(temp).^2) ;
    disp(['Transmit Power   = ' num2str(Sxx) ' dBm']);
    

    % %% Plots
    figure(1)
    spectrogram(temp,500,0,500,Fs,'yaxis','centered')
    %figure(2)
    %obw(signalIQ,Fs) ;

    %% Received Signal
    %message_out;signal_demod;signal_demod1;signal_demod2 = Lora_RX_rayleigh(temp,BW,SF,2,Fs,Fc - fc) ;
    message_out = Lora_RX_rayleigh(temp,BW,SF,2,Fs,Fc - fc) ;
    Bit_errors_msg = sum(sum(message_dbl~= message_out));
    %% Message Out
    disp(['Message Received = ' char(message_out)])
    break;
end
%disp(factor);
%db = 10*log10(rms(factor*noise).^2) ;
%disp(['Noise Power   = ' num2str(db) ' dBm']); 

 
%disp(factor)
%figure(2)
%spectrogram(factor*randn(size(temp)))
