% Image Printing Based on Halftoning
% Cody A. Ray, codyaray@drexel.edu
% April 29, 2010
%
% This program rewrites an image based on halftoning.
%
% For halftoning, we use ten shades of gray approximated by dot patterns
% (see below).  Each gray level is represented by a 3 x 3 pattern of black
% and white dots.  A 3 x 3 area full of black dots is the approximation to
% gray-level black, or 0.  Similarly, a 3 x 3 area of white dots represents
% gray level 9, or white.  The other dot patterns are approximations to 
% gray levels in between these two extremes.  A gray-level printing scheme
% based on dots patterns such as these is called  "halftoning."  Note that
% each pixel in an input image will correspond to 3 x 3 pixels on the
% printed image, so spatial resolution will be reduced to 33% of the
% original in both the vertical and horizontal direction.

% Algorithm:
%  (1) Read in monochromatic image
%  (2) Scale gray levels to span full half-toning range
%  (3) Map gray levels to halftones
%  (4) Store corresponding half-tone for each pixel
%  (5) Return halftone image

function out_img = halftone(in_img)

% Scale gray levels to span full half-toning range

mini = min(min(in_img));
maxi = max(max(in_img));
step = (maxi-mini)/10;

mid_img = zeros(size(in_img));
for k = 0:9
    lmin = mini+step*k;
    lmax = lmin+step;
    [i,j] = ind2sub(size(in_img),find(in_img>=lmin&in_img<=lmax));
    for l = 1:length(i)
        mid_img(i(l),j(l)) = k;
    end
end

mid_img

% Map gray levels to halftones

w = 1;
b = 0;

gray0 = [b,b,b;b,b,b;b,b,b];
gray1 = [b,w,b;b,b,b;b,b,b];
gray2 = [b,w,b;b,b,b;b,b,w];
gray3 = [w,w,b;b,b,b;b,b,w];
gray4 = [w,w,b;b,b,b;w,b,w];
gray5 = [w,w,w;b,b,b;w,b,w];
gray6 = [w,w,w;b,b,w;w,b,w];
gray7 = [w,w,w;b,b,w;w,w,w];
gray8 = [w,w,w;w,b,w;w,w,w];
gray9 = [w,w,w;w,w,w;w,w,w];

% Store corresponding half-tone for each pixel

out_img = zeros(size(mid_img)*3);
for i = 1:size(mid_img,1)
    for j = 1:size(mid_img,2)
        switch mid_img(i,j)
            case 0
                level = gray0;
            case 1
                level = gray1;
            case 2
                level = gray2;
            case 3
                level = gray3;
            case 4
                level = gray4;
            case 5
                level = gray5;
            case 6
                level = gray6;
            case 7
                level = gray7;
            case 8
                level = gray8;
            case 9
                level = gray9;
        end
        
        new_i = i + 2*(i-1);
        new_j = j + 2*(j-1);
        out_img(new_i:new_i+2,new_j:new_j+2) = level;
    end
end