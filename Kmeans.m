original_rgb=imread('Ask1n.jpg'); %diabazw thn eikona se metablhth

X=zeros(size(original_rgb,1)*size(original_rgb,2),3); %metatrepw ton pinaka ths foto 
%se enan pinaka 3 sthlwn me grammes osa kai ta pixels
count=0;
for i=1:size(original_rgb,1)
    for j=1:size(original_rgb,2)
        count=count+1;
        X(count,1)=original_rgb(i,j,1); %red
        X(count,2)=original_rgb(i,j,2); %green
        X(count,3)=original_rgb(i,j,3); %blue
    end
end

[IDX,C] = kmeans(X,3); %kalw ton kmeans
%eisagw ton pinaka X gia 3 clusters
%eksagei 2 pinakes, o IDX dexnei kathe stoixeio tou pinaka X 
%se poio cluster anhkei
%o pinakas C deixnei ta (xrwmatika)kentra tou kathe cluster

clustered=zeros(size(original_rgb,1),size(original_rgb,2));
%edw ksanasynthetw apo ton rgb seiriako, 
%se 600x800 opws htan h arxikh eikona
count=0;
for i=1:size(original_rgb,1)
    for j=1:size(original_rgb,2)
        count=count+1;
        clustered(i,j)=IDX(count);
    end
end

figure;
subplot(1,2,1)
imshow(original_rgb); %plotarei thn original_rgb
subplot(1,2,2)
imagesc(clustered); %kanei diaforetika xrwmatakia gia kathe cluster 
