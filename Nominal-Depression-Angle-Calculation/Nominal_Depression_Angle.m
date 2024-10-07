
%Constants
RTD = 180/pi; %Radians to Degrees
R_E = 6378137.0; %Earths Radius in Meters
A = 19812.0; %Altitude in Meters
SD = 80000.0; %Slant Distance in Meters

%Determined using Algerba (refer to PDF)
Y_A = (SD^2 + (A*(A + 2*R_E)))/(2*(R_E + A));
X_A = sqrt(SD^2 - (Y_A)^2);
NDA = acos(X_A / SD);

%print('Altitude =A,'meters')
%print('Slant Distance =',SD,'meters')
%print('Nominal Depression Angle =',(NDA*RTD),'degrees')
NDA*RTD

%%

%Target Location
x1 = 0;
y1 = 0;

%Ground Point
x2 = x1 - X_A;
y2 = y1 + (Y_A - A);
x2, y2
%print('Ground Point =', x2, ',', y2);