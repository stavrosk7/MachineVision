%askhsh 2
rgb=imread('image.png'); %diabazw thn eikona se mia metablhth
gray=rgb2gray(rgb); %thn metatrepw se grayscale
gray_threshold=graythresh(gray); %briskei to orio anamesa se black&white
bw=im2bw(gray,gray_threshold); %panw apo to orio ginetai aspro, enw katw mavro
% bw_original=im2bw(gray,gray_threshold);

 figure(1); imshow(bw);
% [counts,x] = imhist(gray);
% imhist(gray);
% hold on;
% plot([gray_threshold*255,gray_threshold*255],[0,max(counts)],'r');


% Erosion, h alliws automata me imerode()

eroded_image=uint8(ones(size(bw))); %ftiaxnoume mia asprh eikona sto megethos th bw
SE = [1 1;1 1];  % to filtro poy tha perasei apo olh thn eikona
for i=1:size(bw,1)-1 %to -1 yparxei, gt odhgos tou filtrou to panw aristera
    for j=1:size(bw,2)-1
        if (bw(i,j)==0) %opoy synantw mayro
            for i1=1:2
                for j1=1:2
                    if (SE(i1,j1)==1) %opou to filtro exei assous mavrizw thn eikona
                        eroded_image(i+i1-1,j+j1-1)=0;
                    end
                end
            end
        end
    end
end

bw=eroded_image;
% figure; imshow(eroded_image,[]);
%d=isequal(eroded_image-uint8(imerode(bw,SE)),zeros(size(eroded_image)));

% er=uint8(imerode(bw,SE));
% for i=1:size(bw,1)-1
%     for j=1:size(bw,2)-1
%         er1(i+1,j+1)=er(i,j);
%     end
% end
% imagesc(eroded_image-er1);
% subplot(1,2,1)
% imshow(eroded_image,[0 1]);
% subplot(1,2,2)
% imshow(imerode(bw,SE));

% Dilation, h alliws automata me imdilate()

dilated_image=uint8(zeros(size(bw)));
SE = [1 1;1 1];  % to filtro poy tha perasei apo olh thn eikona
for i=1:size(bw,1)-1
    for j=1:size(bw,2)-1
        if (bw(i,j)==1) %opou yparxei aspro
            for i1=1:2
                for j1=1:2
                    if (SE(i1,j1)==1) 
                        dilated_image(i+i1-1,j+j1-1)=1;
                    end
                end
            end
        end
    end
end
bw=dilated_image;
% figure; imshow(bw,[]);
% imagesc(dilated_image-uint8(imdilate(bw,SE)));
% figure; 
% imshow(dilated_image-uint8(imdilate(bw,SE)));
% isequal(dilated_image-uint8(imdilate(bw,SE)),zeros(size(dilated_image)))
% subplot(1,2,1)
% imshow(dilated_image,[0 1]);
% subplot(1,2,2)
% imshow(imdilate(bw,SE));

% Ksana dilate kai ksana erode, 
% wste na einai etoimo gia filling
bw=imdilate(bw,SE);
%figure; imshow(bw,[]);
bw=imerode(bw,SE);
% figure; imshow(bw,[]);

% Image Filling
BW=imfill(bw,'holes'); %boulwnei trypes me sova (ergatika)
% figure; imshow(BW,[]);

% Image Labeling
[L,Total]=bwlabel(BW); %anagnwrizei ta antikeimena kai ta tagarei ta pixels
figure(2); imagesc(L); %ta mpogiantizei ta mpixel


Area=zeros(Total,2);

for i=1:size(L,1) % to size(L,1) briskei tis grammes tou L
    for j=1:size(L,2) % to size(L,2) briskei tis sthles tou L
        if L(i,j)>0 %ean dn einai to background
            Area(L(i,j),1)=Area(L(i,j),1)+1; %counting pixels for each label
            if i<200    % gia y<200 einai tetragwno, alliws einai kyklos
                Area(L(i,j),2)=1;
            else
                Area(L(i,j),2)=2;
            end
        end
    end
end

pixel_area=(7.4*10^(-6))^2;
distance_dlink=0.76-0.03;
distance_cup=0.76-0.091;
focal_length=0.0038;

for i=1:size(Area,1)
    if Area(i,2)==1
        Area(i,1)=Area(i,1)*pixel_area*(distance_dlink/focal_length)^2;
    else
        Area(i,1)=Area(i,1)*pixel_area*(distance_cup/focal_length)^2;
    end
end
%metatrepw ta pixels pou metrhsa se m^2

'Area in m^2    object type' 
format shortE; disp(Area);
