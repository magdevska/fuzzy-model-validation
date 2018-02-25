function data = generateValidationData2
    initialCond = rand(23,1) .* [1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e3 1e3 1e3 1e3 1e3 1e2 1e2 1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e5 1e5]';
    initialC = 20*rand(1);
    
    df = differential(initialC);
    tspan = linspace(0,1800,30);
    [~,y]=ode45(df,tspan,initialCond);
    data = [y initialC*ones(30,1)];
end
