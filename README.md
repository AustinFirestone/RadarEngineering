# RadarEngineering
a collection of digital signal processing and radar projects


## Most Notable Project: **PVA**
>  unwrap any radar chrip and use a custom automatic curve fitting algorithm to replicate it

This allows for:

- [x] accurate endpoint recognition
- [x] chirp offset calculations
- [x] determine instant Postion, Velocity, and Acceleration (utilize calculus) ⭐
- [x] solves the aliasing problem of the traditional unwrap function at high frequencies 

Use Cases:
- tolerance calculations for chirp producing equipment
- more accurate Computer Guided Navigation

Plots
----
### 1. Use Digital Signal Processing(DSP) to define usable window of the chirp
*trim noise and cut off imaginary/mirror data(on the right)* 

![image](https://github.com/user-attachments/assets/1fbfdd2b-3964-412a-a862-6be2c7fe2584)

### 2. Resulting chirp after step 1
*chirp stops around 1500 on the x axis*

![image](https://github.com/user-attachments/assets/d6dc0c31-5786-4924-bab1-dcb25c55f85f)


### 3. Chirp replication using AQE algorithm (red = pva equation, blue = radar chirp after DSP)
*Unwrapped chirp replication*

![image](https://github.com/user-attachments/assets/ae6f068e-452a-4eb4-8fb1-51f9d7ceff1c)

### 4. Previous plot but with rewrapped data and New AQE green chirp 
*new chirp(green) generated from instantaneous frequencies of AQE alogrithm(blue)*

**Full View**

![image](https://github.com/user-attachments/assets/466e7fd0-567b-4a6f-87f5-7a8f45ec83db)

**Close Up**
> near perfect replication

![image](https://github.com/user-attachments/assets/141501cf-a56a-4801-bdc9-831bb21294a5)


### 6.. Example of AQE algorithm bypassing alaising problem at high frequencies
*red = AQE (parabolic), blue = raw data(unwrapped -> aliasing), green AQE chirp(very useful but still unwrapped -> aliasing)*

Both parabolic(red) and chirp(green) based replication can be utilized depending on use case

![image](https://github.com/user-attachments/assets/8723e24e-9375-4135-90a9-6198fc39cb0f)

*developed by Austin Firestone and Robb Brown*

