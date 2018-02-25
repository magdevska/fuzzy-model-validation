function [data, nConc] = generateLearningData (tEnd)
    conditions = [2,5,10,20];
    nConc = length(conditions);

    initialCond = zeros(23,1);
    start = 1;
    data = zeros(tEnd/6*nConc,24);

    for EGF=conditions
        df = differential(EGF);

        tspan = linspace(0,1800,30);
        [~,y]=ode45(df,tspan,initialCond);
        
        data(start:start+29,:) = [y EGF*ones(30,1)];
        start = start + tEnd/6;
    end 

end
