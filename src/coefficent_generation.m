%Training to generate coefficents 

%Using only 1 Image for now 
%Training Image IO
file = 'ground.jpeg';
S = double(imread(file));
[w1,h1,z1] = size(S);

%Splitting into channel
RedChannelRaw = S(:,:,1);
GreenChannelRaw= S(:,:,2);
BlueChannelRaw = S(:,:,3);


%Padded to use the right pixels when training
R_Padded = padarray(RedChannelRaw,[2 2],'symmetric','both');
G_Padded = padarray(GreenChannelRaw,[2 2],'symmetric','both');
B_Padded = padarray(BlueChannelRaw,[2 2],'symmetric','both');

%All samples in a single column
red_col = im2col(RedChannelRaw,[1 1]);
green_col = im2col(GreenChannelRaw,[1 1]);
blue_col = im2col(BlueChannelRaw,[1 1]);

%Splitting samples into 5 x 5 windows (Should have 1500*1000 columns)
r5 = im2col(R_Padded,[5 5]);
g5 = im2col(G_Padded,[5,5]);
b5 = im2col(B_Padded,[5,5]);

[Ag_bggr,Ar_bggr] = bggr(r5,g5,b5,green_col,red_col);
[Ar_grbg,Ab_grbg] = grbg(r5,g5,b5,red_col,blue_col);
[Ag_rggb,Ab_rggb] = rggb(r5,g5,b5,green_col,blue_col);
[Ab_gbrg,Ar_gbrg] = gbrg(r5,g5,b5,blue_col,red_col);


%MAKING PATCHES AND GETTING COEFFICENTS FUNCTIONS 
function [Ag,Ar] = bggr(XR,XG,XB,GChannel,RChannel)
%BGGR PATTERN
%Generating Patterns for Patches
BBayer = repmat ([1 0;0 0], [3,3]);
BBayer(6,:) = [];
BBayer(:,6) = [];
B_Col = im2col(BBayer,[1,1]);
B_Col = B_Col';

GBayer = repmat ([0 1;1 0], [3,3]);
GBayer(6,:) = [];
GBayer(:,6) = [];
G_Col = im2col(GBayer,[1,1]);
G_Col = G_Col';

RBayer = repmat ([0 0;0 1], [3,3]);
RBayer(6,:) = [];
RBayer(:,6) = [];
R_Col = im2col(RBayer,[1,1]);
R_Col = R_Col';

X = R_Col.*XR+G_Col.*XG+B_Col.*XB;
X = X';
Ag = inv(X'*X)*X'*(GChannel');
Ar = inv(X'*X)*X'*(RChannel');
end

function [Ar,Ab] = grbg(XR,XG,XB,RChannel,BChannel)

%GRBG PATTERN
%Generating Patterns for Patches
GBayer = repmat ([1 0;0 1], [3,3]);
GBayer(6,:) = [];
GBayer(:,6) = [];
G_Col = im2col(GBayer,[1,1]);
G_Col = G_Col';

BBayer = repmat ([0 0;1 0], [3,3]);
BBayer(6,:) = [];
BBayer(:,6) = [];
B_Col = im2col(BBayer,[1,1]);
B_Col = B_Col';

RBayer = repmat ([0 1;0 0], [3,3]);
RBayer(6,:) = [];
RBayer(:,6) = [];
R_Col = im2col(RBayer,[1,1]);
R_Col = R_Col';


X = R_Col.*XR+G_Col.*XG+B_Col.*XB; %Making the mosaic
X = X';
Ar = inv(X'*X)*X'*(RChannel');
Ab = inv(X'*X)*X'*(BChannel');
end

function [Ag,Ab] = rggb(XR,XG,XB,GChannel,BChannel)

%RGGB PATTERN
%Generating Patterns for Patches

RBayer = repmat ([1 0;0 0], [3,3]);
RBayer(6,:) = [];
RBayer(:,6) = [];
R_Col = reshape(RBayer',[],1);

GBayer = repmat ([0 1;1 0], [3,3]);
GBayer(6,:) = [];
GBayer(:,6) = [];
G_Col = reshape(GBayer',[],1);

BBayer = repmat ([0 0;0 1], [3,3]);
BBayer(6,:) = [];
BBayer(:,6) = [];
B_Col = reshape(BBayer',[],1);


X = R_Col.*XR+G_Col.*XG+B_Col.*XB;
X = X';
Ag = inv(X'*X)*X'*(GChannel');
Ab = inv(X'*X)*X'*(BChannel');
end

function [Ab,Ar] = gbrg(XR,XG,XB,BChannel,RChannel)

%gbrg PATTERN
%Generating Patterns for Patches

GBayer = repmat ([1 0;0 1], [3,3]);
GBayer(6,:) = [];
GBayer(:,6) = [];
G_Col = im2col(GBayer,[1 1]);
G_Col = G_Col';

BBayer = repmat ([0 1;0 0], [3,3]);
BBayer(6,:) = [];
BBayer(:,6) = [];
B_Col = im2col(BBayer,[1 1]);
B_Col = B_Col';

RBayer = repmat ([0 0;1 0], [3,3]);
RBayer(6,:) = [];
RBayer(:,6) = [];
R_Col = im2col(RBayer,[1 1]);
R_Col = R_Col';

X = R_Col.*XR+G_Col.*XG+B_Col.*XB;
X = X';
Ab = inv(X'*X)*X'*(BChannel');
Ar = inv(X'*X)*X'*(RChannel');
end

