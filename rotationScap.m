load("S3.mat")

rotationPre = S3_PreScapUp;
rotationPost = S3_PostScapUp;

dataSizePre = round(length(rotationPre)/10);
dataSizePost = round(length(rotationPost)/10);

dataPre = reshape(rotationPre,dataSizePre,[]);
dataPost = reshape(rotationPost, dataSizePost, []);

recorridoStartPre = min(dataPre(:,:));
recorridoEndPre= max(dataPre(:,:));
romPre = recorridoEndPre-recorridoStartPre;

recorridoStartPost = min(dataPost(:,:));
recorridoEndPost= max(dataPost(:,:));
romPost = recorridoEndPost-recorridoStartPost;

plot(romPre,'o', 'MarkerSize',12)
hold on
plot(romPost,'*', 'MarkerSize',12)
axis padded
legend({'Pre','Post'},'Location','southwest')