I = imread('lena.jpg');
I = rgb2gray(I);
x1 = input("Enter the x coordinate of desired left top coordinate rate\n");
y1 = input("Enter the y coordinate of desired left top coordinate rate\n");
x2 = input("Enter the x coordinate of desired right bottom coordinate rate\n");
y2 = input("Enter the y coordinate of desired right bottom coordinate rate\n");

if y2 >= y1 || x1 >= x2
    fprintf("%s", "x2 must be greaten than x1 and y1 must be greater then y2");
else 
    blurred_image = blurImage(I, x1, y1, x2, y2);
    imshow(blurred_image);
end

%(x1, y1) : Left top, (x2, y2) : Right bottom
function blurred_image = blurImage(image, x1, y1, x2, y2)
    [height, width, ~] = size(image);
        
    %desired area coordinates
    c_x1 =  floor(width * x1);
    c_y1 = floor(height * (1-y1));
    c_x2 =  floor(width * x2);
    c_y2 = floor(height * (1-y2));
    
    %first blurred segment
    b_x1 = floor(abs(c_x1 - c_x1/2));
    b_y1 = floor(abs(c_y1 - c_y1/2));
    b_x2 = floor(abs(c_x2 + (width - c_x2)/2));
    b_y2 = floor(abs(c_y2 + (height - c_y2)/2));
    
    %second blurred segment
    d_x1 = floor(abs(b_x1 - b_x1/2));
    d_y1 = floor(abs(b_y1 - b_y1/2));
    d_x2 = floor(abs(b_x2 + (width - b_x2)/2));
    d_y2 = floor(abs(b_y2 + (height - b_y2)/2)); 
 
    %third blurred segment
    e_x1 = floor(abs(d_x1 - d_x1/2));
    e_y1 = floor(abs(d_y1 - d_y1/2));
    e_x2 = floor(abs(d_x2 + (width - d_x2)/2));
    e_y2 = floor(abs(d_y2 + (height - d_y2)/2)); 
    
    focus = imcrop(image, [c_x1 c_y1 (c_x2-c_x1) (c_y2-c_y1)]);
    
    first_blurred_segment = imcrop(image, [b_x1 b_y1 (b_x2-b_x1) (b_y2-b_y1)]);
    first_blurred_segment = imgaussfilt(first_blurred_segment,2);
    
    second_blurred_segment = imcrop(image, [d_x1 d_y1 (d_x2-d_x1) (d_y2-d_y1)]);
    second_blurred_segment = imgaussfilt(second_blurred_segment,4);
    
    third_blurred_segment = imcrop(image, [e_x1 e_y1 (e_x2-e_x1) (e_y2-e_y1)]);
    third_blurred_segment = imgaussfilt(third_blurred_segment,6);
    
    image = imgaussfilt(image,8);
    
    image(e_y1:e_y2, e_x1:e_x2) = third_blurred_segment;
    image(d_y1:d_y2, d_x1:d_x2) = second_blurred_segment;
    image(b_y1:b_y2, b_x1:b_x2) = first_blurred_segment;
    image(c_y1:c_y2, c_x1:c_x2) = focus;
   
    blurred_image =  image;  
end 