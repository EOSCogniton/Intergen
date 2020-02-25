function track = import_track(X,Y,x)
windowWidth = 25;
polynomialOrder = 2;
smoothX = sgolayfilt(X, polynomialOrder, windowWidth);
smoothY = sgolayfilt(Y, polynomialOrder, windowWidth);
track = [smoothX(1:x),smoothY(1:x)];
end