%Project 2 Ankur Kejriwal

%Image IO
file = 'lighthouse.png';
S = im2double(imread(file));
[w1,h1,z1] = size(S);

%Splitting into channel
RedChannelRaw = S(:,:,1);
GreenChannelRaw= S(:,:,2);
BlueChannelRaw = S(:,:,3);

%Scale Factors used when making Scaling the Pattern Matrices
scaleX = w1/2;
scaleY = h1/2;

%Create Matrix of Zeros and Ones matching the rggb pattern
RBayer = repmat ([1 0;0 0], [scaleX,scaleY]);
GBayer = repmat ([0 1;1 0], [scaleX,scaleY]);
BBayer = repmat ([0 0;0 1], [scaleX,scaleY]);
RChannel = S(:,:,1) .* RBayer;
GChannel = S(:,:,2) .* GBayer;
BChannel = S (:,:,3) .* BBayer;

mosaicImage = RChannel(:,:)+GChannel(:,:)+BChannel(:,:);
imwrite(mosaicImage,"mosaick1Channel.png");

mosaic_Padded = padarray(mosaicImage,[3 3],'symmetric');

%Trim to ensure pattern doesn't get messed up
mosaic_Padded(end-2,:) = [];
mosaic_Padded(3,:) = [];
mosaic_Padded(:,end-2) = [];
mosaic_Padded(:,3) = [];

%Pad red or blue and use that to determine which coefficent to use
RChannel_padded = padarray(RChannel,[3 3],'symmetric');

%Trim to ensure pattern doesn't get messed up
RChannel_padded(end-2,:) = [];
RChannel_padded(3,:) = [];
RChannel_padded(:,end-2) = [];
RChannel_padded(:,3) = [];


%Output Matrices (Concatenate when done to get 3 channel image)
final_r = RChannel;
final_b = BChannel;
final_g = GChannel;

%Possible Patterns
rggb =  [0 1 ; 1 1];
bggr =  [1 1 ; 1 0];
grbg = [1 0 ; 1 1];
gbrg = [1 1 ; 0 1];

for row =3:w1+2
    for col =3:h1+2
        patch = im2col(mosaic_Padded(row-2:row+2,col-2:col+2),[1 1])'; %5x5 Window
        check = RChannel_padded(row:row+1,col:col+1); % 2x2 to pull positon of red pixel
        if(isequal(check.*rggb,zeros(2)))%RGGB
            final_b(row-2,col-2) = sum(Ab_rggb.*patch);
            final_g(row-2,col-2)= sum(Ag_rggb.*patch);
        elseif(isequal(check.*bggr,zeros(2)))
            final_g(row-2,col-2) = sum(Ag_bggr.*patch);
            final_r(row-2,col-2)= sum(Ar_bggr.*patch);
        elseif(isequal(check.*grbg,zeros(2)))
            final_r(row-2,col-2) = sum(Ar_grbg.*patch);
            final_b(row-2,col-2)= sum(Ab_grbg.*patch);
        elseif(isequal(check.*gbrg,zeros(2)))
            final_b(row-2,col-2)= sum(Ab_gbrg.*patch);
            final_r(row-2,col-2)= sum(Ar_gbrg.*patch);
        end
    end
end

CompleteImage = cat(3,final_r,final_g,final_b);
imwrite(CompleteImage,"CompleteImage.png");
imshow(CompleteImage);

%Error Calculations
Original = imread(file);
Interpolated = imread('CompleteImage.png');
error = immse(Interpolated,Original)

%Matlab Demosaic
I = imread('mosaick1Channel.png');
J = demosaic(I,'rggb');
imshow(J);
imwrite(J,"DemosaicMatlab.png");

%Error Calculations for Matlab vs GroundTruth
errorMatlab = immse(J,Original)


