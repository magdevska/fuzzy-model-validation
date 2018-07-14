tEnd = 48;
time = linspace(1,tEnd,tEnd);

periodCases = [24, 23.5, 26];
periods = size(periodCases, 2);

data = zeros(3*tEnd, 5);
for i=1:periods
    period = periodCases(i);
    data((i-1)*tEnd+1:i*tEnd, :) = [1.15*cos(2*pi/period*time-1.4)+1.05
         1.5*cos(2*pi/period*time-7.7)+1.4
         0.9*cos(2*pi/period*time-17.7)+1.1
         1.0*cos(2*pi/period*time-22.1)+1.2
         1.55*cos(2*pi/period*time-11.0)+1.45]';
end

data = data + data .* (0.0001 .* rand(3*tEnd, 5));

center = zeros(3,5);
U = zeros(3,tEnd*periods,5);
for i=1:5
    fcn = NaN;
    while any(isnan(fcn))
        [center(:,i),U(:,:,i), fcn] = fcm(data(:,i), 3);
    end
end

[Y,I] = max(U,[],'includenan');
I = reshape(I,[periods*tEnd 5]);

rules = [I(1:tEnd-4,1) I(3:tEnd-2,2) I(2:tEnd-3,3) I(1:tEnd-4,4) I(2:tEnd-3,5) I(5:tEnd,:)]; 


rules = unique(rules, 'rows');
nRules = size(rules,1);

fis = newfis('fis','mamdani');

for i=1:5
    fis = addvar(fis, 'input', int2str(i), [0 max(data(:,i))]);
    fis = addvar(fis, 'output', int2str(i), [0 max(data(:,i))]);
    
    Y = sort(center(:,i));
    
    for j=1:3
        nameIndex = find(Y==center(j,i));
        switch nameIndex(1)
            case 1
                name = 'S';
            case 2
                name = 'M';
            case 3
                name = 'L';
        end
            
        fis = addmf(fis, 'input',i, name, 'gaussmf', [0.008*max(data(:,i)) center(j,i)]);
        fis = addmf(fis, 'output',i, name, 'gaussmf', [0.008*max(data(:,i)) center(j,i)]);
    end
end

fis = addrule(fis, [rules ones(nRules,2)]);

tEnd=24;
result = zeros(tEnd,5);
result(1:4,:) = data(1:4,:) + data(1:4,:) .* rand(4,5) * 0.35;
for t=5:tEnd
   result(t,:) = evalfis([result(t-4,1) result(t-2,2) result(t-3,3) result(t-4,4) result(t-3,5)],fis);
end
