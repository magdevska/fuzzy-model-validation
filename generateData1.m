dataSize = 50;
s = zeros(dataSize,180/6,24);

for i=1:dataSize
    s(i,:,:) = generateValidationData();
end

save('validationSet1', 's')