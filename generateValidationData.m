function data = generateValidationData
    tEnd = 180;
    initialConc = [2,5,10,20];
    initialCond = 0.01 * rand(23,1) .* [1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e3 1e3 1e3 1e3 1e3 1e2 1e2 1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e5 1e5]';

    start = 1;
    data = zeros(tEnd/6,24);
    initialC = randi(4);
    
    df = differential(initialConc(initialC));
    tspan = linspace(0,1800,30);
    [~,y]=ode45(df,tspan,initialCond);
    data(start:start+29,:) = [y initialConc(initialC)*ones(30,1)];
end