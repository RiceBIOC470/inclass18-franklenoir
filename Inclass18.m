% In class 18
%GB comments
1. 100
2. 100
Overall: 100

%Walter Frank Lenoir

% Problem 1. In this directory, you will find the same image of yeast cells as you used
% in homework 5. First preprocess the image any way you like - smoothing, edge detection, etc. 
% Then, try to find as many of the cells as you can using the
% imfindcircles routine with appropriate parameters. 
% Display the image with the circles drawn on it.  

yeast = imread('yeast.tif');


%preprocessing taken from homework 5
imshow(yeast,[]);
yeast_mask1 = double(yeast > 45);


compliment = ones(size(yeast_mask1));
yeast_mask2 = (compliment - yeast_mask1);

yeast_mask1 = imfill(yeast_mask1,'holes');
compliment = ones(size(yeast_mask1));
yeast_mask1 = (compliment - yeast_mask1);

yeast_mask=imsubtract(yeast_mask1,yeast_mask2);

compliment = ones(size(yeast_mask));
yeast_mask = (compliment - yeast_mask);
yeast_mask = imfill(yeast_mask,'holes');

yeast_mask = imerode(yeast_mask,strel('disk',4));
mask = imdilate(yeast_mask,strel('disk',3));

[centers,radii] = imfindcircles(mask,[15 25],'Sensitivity',0.96);
figure; imshow(yeast,[]); hold on;
for ii = 1:length(centers)
    drawcircle(centers(ii,:),radii(ii),'m');
end

%2 cells had 2 circles, while 3 cells were not detected. 

% Problem 2. (A) Draw two sets of 10 random numbers - one from the integers
% between 1 and 9 and the second from the integers between 1 and 10. Run a
% ttest to see if these are significantly different. (B) Repeat this a few
% times with different sets of random numbers to see if you get the same
% result. (C) Repeat (A) and (B) but this time use 100 numbers in each set
% and then 1000 numbers in each set. Comment on the results. 

%A
x = randi(9,10,1);
y = randi(10,10,1);

[is_sig,pval] = ttest2(x,y);
%when ran, pval > 0.05, and not is_sig

%B - Changing random number set, not range. 
x = randi(9,10,1);
y = randi(10,10,1);

[is_sig,pval] = ttest2(x,y);

x = randi(9,10,1);
y = randi(10,10,1);

[is_sig,pval] = ttest2(x,y);

x = randi(9,10,1);
y = randi(10,10,1);

[is_sig,pval] = ttest2(x,y);

x = randi(9,10,1);
y = randi(10,10,1);

[is_sig,pval] = ttest2(x,y);

%is_sig was significant once, when the code above was ran with a pvalue of 0.01.
%All other p-values were higher than 0.05. P-values < 0.05 were not
%expected with such a small sample size and similar distribution. 

%C

x = randi(9,100,1);
y = randi(10,100,1);

[is_sig,pval] = ttest2(x,y);

%Most results not significant (p=value above 0.05)

x = randi(9,1000,1);
y = randi(10,1000,1);

[is_sig,pval] = ttest2(x,y);

%Most results significant (p=value less than 0.05)

%With larger sample sizes (increasing t-test power), differences of distributions were better
%observed, and the mean between the two samples had a signficant
%difference. This allows us to reject the null hypothesis that the two samples 
%came from the same distribution in the larger sample size tests. 
