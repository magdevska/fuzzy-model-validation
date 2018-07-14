result = zeros(4*tEnd/6,24);
result(:,24) = [2*ones(tEnd/6,1); 5*ones(tEnd/6,1); 10*ones(tEnd/6,1); 20*ones(tEnd/6,1)];

initialConc = [2 5 10 20];

delta=0;
for i=1:4
   initialCond = rand(23,1) .* [1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e3 1e3 1e3 1e3 1e3 1e2 1e2 1e4 1e4 1e4 1e4 1e4 1e4 1e4 1e5 1e5]';
   result(delta+1,1:23)=initialCond;
   for t=delta+2:delta+tEnd/6
       result(t,1:23) = evalfis(result(t-1,:),fis);
   end
   delta = delta + tEnd/6;
   
   df = differential(initialConc(i));

   tspan = linspace(0,1800,30);
   [t1,y]=ode45(df,tspan,initialCond);
end
