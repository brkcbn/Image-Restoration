close all;

noisy_image=imread('pout_noisy.tif');

subplot(3,2,1);
imshow(noisy_image)
title('Noisy Image')

PQ = paddedsize(size(noisy_image));

D0 = 35;

H = bandreject('btw', PQ(1), PQ(2), D0, 20);

F=fft2(double(noisy_image),size(H,1),size(H,2));

bs_noisy_image= H.*F;

b_noisy_image=real(ifft2(bs_noisy_image)); 

b_noisy_image=b_noisy_image(1:size(noisy_image,1), 1:size(noisy_image,2));

subplot(3,2,4);
imshow(b_noisy_image, [])
title('Inverse FFT')

Fc=fftshift(F);
Fcf=fftshift(bs_noisy_image);

S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));

subplot(3,2,2); 
imshow(S1,[]);
title('FFT of Noisy Image')

subplot(3,2,3);
imshow(S2,[]);
title('Bandreject Filtered Image')
%--------------------------------------------------------------------------
H1 = notch('gaussian', PQ(1), PQ(2), 10, 17, 32);
H2 = notch('gaussian', PQ(1), PQ(2), 10, 465, 552);

F=fft2(double(noisy_image),PQ(1),PQ(2));

FS_noisy_image = F.*H1.*H2;

F_noisy_image=real(ifft2(FS_noisy_image)); 

F_noisy_image=F_noisy_image(1:size(noisy_image,1), 1:size(noisy_image,2));

subplot(3,2,6);
imshow(F_noisy_image,[]);
title('Inverse FFT')

Fc=fftshift(F);
Fcf=fftshift(FS_noisy_image);

S1=log(1+abs(Fc)); 
S2=log(1+abs(Fcf));

subplot(3,2,5);
imshow(S2,[]);
title('Notch Filtered Image')

