I = imread('lena.jpg');

%in case it is not gray scale
if length(size(I)) > 2
    I = rgb2gray(I);
end 

FI = fftshift((fft2(I)));

[rows, columns, numchannels] = size(FI);

center_x = columns/2;
center_y = rows/2;

radius_x = columns/20;
radius_y = rows/20;

radius = 0;

if radius_x > radius_y
    radius = radius_x;
else
    radius = radius_y;
end

for i = 1:rows
    for j = 1:columns
        dist = sqrt((center_y - i)^2+(center_x - j)^2);
        if dist <= radius
            FI(i,j) = 0;
        end
    end
end

FI = ifftshift(FI);

I = ifft2(FI);
I = uint8(I);

imshow(I, []);
