tEnd = 180;
[data, nConc] = generateLearningData(tEnd);

% generate the FCM model, save it in resultFis
input = zeros(nConc*tEnd/6-1,24);
output = zeros(nConc*tEnd/6-1,23);
for k=0:nConc-1
    input(k*tEnd/6+1:(k+1)*tEnd/6-1, :) = data(k*tEnd/6+1:(k+1)*tEnd/6-1,:);
    output(k*tEnd/6+1:(k+1)*tEnd/6-1, :) = data(k*tEnd/6+2:(k+1)*tEnd/6,1:23) - data(k*tEnd/6+1:(k+1)*tEnd/6-1,1:23);
end

cluster = 20;
pogoj = Inf;
for k=1:10
    fis = genfis3(input,output,'mamdani', cluster);

    result = zeros(nConc*tEnd/6,24);
    result(:,24) = data(:,24);
    delta = 0;
    for i=1:nConc
       result(delta+1,:) = data(delta+1,:);
       for t=delta+2:delta+tEnd/6
           result(t,1:23) = result(t-1,1:23) + evalfis(result(t-1,:),fis);
       end
       delta = delta + tEnd/6;
    end

    if norm(result-data,'fro') < pogoj
        resultFis = fis;
        pogoj = norm(result-data,'fro');
    end
end

% generate the MAFTS model, save it in fis
center = zeros(5,24);
U = zeros(5,nConc*tEnd/6,24);
for i=1:24
    fcn = NaN;
    while any(isnan(fcn))
        [center(:,i),U(:,:,i), fcn] = fcm(data(:,i), 5);
    end
end

[Y,I] = max(U,[],'includenan');
I = reshape(I,[nConc*tEnd/6 24]);

rules = zeros(nConc*(tEnd/6-2),24+23);

for k=0:nConc-1
   rules(k*(tEnd/6-2)+1:(k+1)*(tEnd/6-2),:) = [I([k*tEnd/6+1 k*tEnd/6+3:(k+1)*tEnd/6-1],:) I([k*tEnd/6+2 k*tEnd/6+4:(k+1)*tEnd/6],1:23)]; 
end

rules = unique(rules, 'rows');
nRules = size(rules,1);

fis = newfis('fis','mamdani');

for i=1:24
    fis = addvar(fis, 'input', int2str(i), [0 max(data(:,i))]);
    if i < 24
        fis = addvar(fis, 'output', int2str(i), [0 max(data(:,i))]);
    end
    
    Y = sort(center(:,i));
    
    for j=1:5
        nameIndex = find(Y==center(j,i));
        switch nameIndex(1)
            case 1
                name = 'VS';
            case 2
                name = 'S';
            case 3
                name = 'M';
            case 4
                name = 'L';
            case 5
                name = 'VL';
        end
            
        fis = addmf(fis, 'input',i, name, 'gaussmf', [0.035*max(data(:,i)) center(j,i)]);
        if i < 24
            fis = addmf(fis, 'output',i, name, 'gaussmf', [0.035*max(data(:,i)) center(j,i)]);
        end
    end
end

fis = addrule(fis, [rules ones(nRules,2)]);

