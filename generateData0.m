dataSize = 50;
s = zeros(dataSize,180/6,24);

for i=1:dataSize
    s(i,:,:) = generateTestData();
end

save('testSet1', 's')
