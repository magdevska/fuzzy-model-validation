function data = generateTestData
    initialCond = zeros(23,1);
    initialC = 20*rand(1);
    
    df = differential(initialC);
    tspan = linspace(0,1800,30);
    [~,y]=ode45(df,tspan,initialCond);
    data = [y initialC*ones(30,1)];
end
