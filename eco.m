clear

%% adicionando eco
     [x,Fs] = audioread('./songdir/audio0.wav');  
     delay = 0.5; % 0.5s delay  
     alpha = 0.8; % echo strength  
     D = delay*Fs;  
     eco = zeros(size(x));  
     eco(1:D) = x(1:D);  
    
     for i=D+1:length(x)  
         eco(i) = x(i) + alpha*x(i-D);  
     end  
     
     %% por filtros
     % b = [1,zeros(1,D),alpha];  
     % y = filter(b,1,x);  
      
     sound(eco,Fs);
