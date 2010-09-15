function image_hist(in_img)

mini = min(min(in_img));
maxi = max(max(in_img));
step = (maxi-mini)/10;

x = double(mini:step:maxi);
hist(double(in_img(:)'),x)