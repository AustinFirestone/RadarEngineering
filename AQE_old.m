

RTD = 180/pi;
SRATE = 4e9;
filename_root = 'C:\Users\austi\OneDrive\Documents\RadarEngineering\My-Stuff\SAR_File';  
datafile = cat(2,filename_root,'\cal_data_1511');
load(datafile);
Data1 = mean(Band_1_X_Band_Cal_Data,2);
%SRATE = numel(datafile)/datafile(end)-datafile(1);

%Data1_size = size(Data1,1);

Nsam = size(Band_1_X_Band_Cal_Data,1);
NewSamp = 2^ceil(log2(Nsam));

%%
%Convert Data1 from real only to complex using fft
pulse_length_s = 1.4395e-06;
nTp = ceil(pulse_length_s*SRATE);
front_noise = 2600; %AARR - Derived from visual inpection       %2595
back_noise = 7100;  %AARR - Derived from visual inpection %5703
Data1 = Data1(front_noise:back_noise);
Data1 = [ Data1.' zeros(1,NewSamp - numel(Data1)) ];
figure;
plot(Data1);


Data1_fft = fft(Data1);
figure;
plot(abs(Data1_fft));
Data1_size = size(Data1,1);
Data1_fft((Data1_size+1)/2:Data1_size) = 0; %2457,7373, usable window
Data1_fft(1:170) = 0;
Data1_fft(2441:end) = 0;
hold on;
plot(abs(Data1_fft),'r');
Data1 = ifft(Data1_fft);

Data1_angle = angle(Data1);
figure;
plot(Data1_angle);
Data1_angle_unwrapped = unwrap(Data1_angle);
Data1_angle_unwrapped_deg = unwrap(Data1_angle_unwrapped)*RTD ;
figure;
plot(Data1_angle_unwrapped_deg);
%%
t1 = 1;
p1 = Data1_angle_unwrapped_deg(t1);
t3 = 5677;             
p3 = Data1_angle_unwrapped_deg(t3); 
t2 = round((t1 + t3)/2);   
p2 = Data1_angle_unwrapped_deg(t2);              
  
t = (1:32768);

c = ((p1*t2*t3*(t3-t2))-(p2*t1*t3*(t3-t2))+(p3*t1*t2*(t2-t1))-(p2*t1*t3*(t2-t1)))/((t2*t3*(t3-t2))-(t1*t3*(t3-t2))+(t1*t2*(t2-t1))-(t1*t3*(t2-t1)));
a = 2*((t1*(p2-c))+(t2*(c-p1)))/((t1*((t2)^2))-(t2*((t1)^2))); 
b = ((((t1)^2)*(c-p2))+(((t2)^2)*(p1-c)))/((t1*((t2)^2))-(t2*((t1)^2)));

p = c + b.*t + 0.5*a.*(t.^2);
f = (b + a.*t)*SRATE/360;

hold on;
plot(t,p,'r','Linewidth',1)
%%
starting_frequency = f(1); %= 3.0312e+08
end_of_chirp_frequency = f(5686); %=8.96e+08
ending_frequency = f(32768); %= 3.7203e+09

AA_chirp = robb_chirp((t-1)/SRATE,starting_frequency,(32768-1)/SRATE,ending_frequency);
AA_chirp_angle = angle(AA_chirp);
AA_chirp_angle_unwrapped = unwrap(AA_chirp_angle);
AA_chirp_angle_unwrapped_deg = unwrap(AA_chirp_angle_unwrapped)*RTD+p(1) ;
hold on;
plot(AA_chirp_angle_unwrapped_deg,'g');
%***********When trying to chirp at high frequencies the unwrap function
%***********wont be able to handle the aliasing of the signal(you need AQE)

%%
%Plot the same signals wrapped

figure;
%plot signal wrapped
plot(angle(Data1)*RTD,'r') 

p_wrapped = mod(p,360);
p_wrapped_180 = p_wrapped;
p_wrapped_180(p_wrapped_180 > 180) =...
    p_wrapped_180(p_wrapped_180 > 180)-360;
hold on
%plot AQE wrapped
plot(p_wrapped_180,'b','Linewidth', 2)

AA_chirp_wrapped = mod(p,360);
AA_chirp_wrapped_180 = AA_chirp_wrapped;
AA_chirp_wrapped_180(AA_chirp_wrapped_180 > 180) =...
    AA_chirp_wrapped_180(AA_chirp_wrapped_180 > 180)-360;
hold on
%plot AQE chirp wrapped
plot(AA_chirp_wrapped_180,'g')

legend('Raw Data','AQE','AQE Chirp')

%%
%Error Calculation

%Wrapped
error_wrapped_AQE = (angle(Data1)*RTD) - p_wrapped_180;
error_wrapped_AQE_chirp = (angle(Data1)*RTD) - AA_chirp_wrapped_180;

if(error_wrapped_AQE > 180)
    error_wrapped_AQE = error_wrapped_AQE - 360;
end
if(error_wrapped_AQE < -180)
    error_wrapped_AQE = error_wrapped_AQE + 360;
end
    
figure;
plot(abs(error_wrapped_AQE))
figure;
plot(abs(error_wrapped_AQE_chirp))

%Unwrapped
error_unwrapped_AQE = Data1_angle_unwrapped_deg - p;
error_unwrapped_AQE_chirp = Data1_angle_unwrapped_deg - AA_chirp_angle_unwrapped_deg;

figure;
plot(1:5400,error_unwrapped_AQE(1:5400))
figure;
plot(1:5400,error_unwrapped_AQE_chirp(1:5400))

plot(error_unwrapped_AQE - error_unwrapped_AQE_chirp)


