clear all;
close all;
clc;

left = imread('left_tsu.png'); %diavazei thn left             
right = imread('right_tsu.png'); %diavazei thn right
left = rgb2gray(left); %kanei se apoxrwseis tou gri tin left
right = rgb2gray(right);%kanei se apoxrwseis tou gri tin right
% figure; %dhmiourgei keno para8uro
% subplot(1,2,2); %dhmiourgei dexio grafiko apotypoma
% imshow(right); %opou emfanizei thn right
% subplot(1,2,1); %dhmiourgei aristero grafiko apotypoma
% imshow(left);


disparity = zeros(size(left)); %gemizei ena pinaka me mhdenika opou 8a dixnei gia ka8e pixel thn diafora tou apo thn allh eikona
dispMin = 0; %ka8orizei to orio tou disparity (to ka8orizw me to xeri)
dispMax = 17; %ka8orizei to orio tou disparity
wind_size = 3; %kanei ena para8uro opou exei mhkos 3 pixel(mono monoi ari8moi kai oso mikroteroi ginetai)
if mod(wind_size,2)==0
    wind_size=wind_size+1;
end
w_s_temp = (wind_size-1)/2; %gia eukolia
for i = w_s_temp + 1 : size(left,1)-w_s_temp %epeidh to window diatrexei oles tis grammes (stereo sel.13)
    for j = w_s_temp+1+dispMax : size(left,2)-w_s_temp % to j trexei sthles se mia grammh
        l_w = left(i -w_s_temp:i+w_s_temp, j-w_s_temp:j+w_s_temp); %apothhkeuei to trexwn aristero parathyro to opoio einai shmeio anaforas gia to deksi parathyro
        d_temp = 255*wind_size*wind_size; % einai h megisth timh toy athroismatos twn stoixeiwn tou pinaka [l_w-r_w] ths diaforas
        for k = dispMin:dispMax %mexri na tautistoun oi theseis twn parathyrwn
            r_w = right(i-w_s_temp:i+w_s_temp,j-k-w_s_temp:j-k+w_s_temp); %to deksi parathyro metabaletai ws pros to aristero logw tou k
            d=sum(sum(abs(l_w-r_w)+abs(r_w-l_w))); % athroizei olo ton pinaka [l_w-r_w]
            if d < d_temp %ean d mikrotero toy elaxistoy athroismatos
                d_temp = d; %to elaxisto athroisma na ginei d
                disparity_selection=k; %krataei to disparity to opoio elaxistopoiei to parapanw athroisma
            end
        end
        disparity(i,j) = disparity_selection; %apo8hkeuei ston pinaka disparity(i,j) to
    end
end
figure; %anoigei ena para8uro
%imagesc(disparity); %teliko disparity gia ka8e pixel(imagesc kanei kai scale kai plot)
%imshow(uint8(255/dispMax.*(disparity)));% oso pio konta sto aspro einai toso pio konta sthn kamera eimaste!
imshow(uint8(255/(dispMax-dispMin).*(disparity-dispMin.*ones(size(disparity)))));% anagoume to megisto disparity sto-
%leuko kai to elaxisto disparity sto mauro
