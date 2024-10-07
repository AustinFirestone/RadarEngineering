%Curve Fitting From 3 Points

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%   I NEED TO FIX:
% - MAKE t0,t1,t2 ACCESSIBLE INSIDE MY FUNCTIONS
% - FIGURE OUT HOW TO CALL MY FUNCTIONS FROM COMMAND PROMPT
% - ANALYZE CURVES THAT DONT HAVE EQUALLY SPACED t0,t1,t2 



%Base Equations
% p = t0 + ((4*t1-t2-3*t0)/2)*t - ((2*t1-t2-t0)/2)*t^2;
% v = (4*t1 - t2 -3*t0)/2 - (2*t1-t2-t0)*t;
% a = -(2*t1-t2-t0);

%positions at seconds 0,1,2
t0 = 100;
t1 = 84;
t2 = 36;

%Plot the change in Position, Velocity, and Acceleration with respect to time
t = (0:1:1000000); 
p = t0 + ((4*t1-t2-3*t0)/2).*t - ((2*t1-t2-t0)/2).*t.^2;
v = (4*t1 - t2 -3*t0)/2 - (2*t1-t2-t0)*t;
a = -(2*t1-t2-t0)+t-t;   % added +t -t so it would reference t
plot(t,p,'k','Linewidth',2)
hold on
plot(t,v,'b','Linewidth',2)
hold on
plot(t,a,'r','Linewidth',2)
legend('pos', 'vel', 'acc');
xlabel('Time');


% %Call functions located below
% pos(3)
% vel(3)
% acc(3)
% %Functions for calling individual points
% function pos(t)
% t0 = 495.57;
% t1 = 499.078;
% t2 = 506.162;
% p = t0 + ((4*t1-t2-3*t0)/2)*t - ((2*t1-t2-t0)/2)*t^2;
% display(p);
% end
% function vel(t)
% t0 = 100;
% t1 = 84;
% t2 = 36;
% v = (4*t1 - t2 -3*t0)/2 - (2*t1-t2-t0)*t;
% display(v);
% end
% function acc(t)
% t0 = 100;
% t1 = 84;
% t2 = 36;
% a = -(2*t1-t2-t0)+(t-t);
% display(a);
% end

