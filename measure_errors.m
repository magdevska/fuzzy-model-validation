RMSE_pred_fcm = 0;
RMSE_all_fcm = 0;
RMSE_pred_mafts = 0;
RMSE_all_mafts = 0;

MAE_pred_fcm = 0;
MAE_all_fcm = 0;
MAE_pred_mafts = 0;
MAE_all_mafts = 0;

for i=1:50
   y = reshape(s(i,:,:),30,24);
   
   maxValues = [730.809120231592,3199.17467588414,84.8563146039016,0.491588263497978,0.00106795047823270,2.65403312305620,25233.0510165160,52569.4270727394,0.723769543894482,13.2032590230909,72.4095521719415,1307.75375462205,5887.41806382801,0.854402923621506,154393.758071143,867.485708608550,1681.57774878505,47.4871003091952,16.6488157418151,188484.353068319,8.14930657571328,1499553.22260998,2896644.62432426];
   initialCond = y(1, 1:23);
   initialC = y(1,24);
   
   result_fcm = zeros(tEnd/6,24);
   result_mafts = zeros(tEnd/6,24);
   result_fcm(:,24) = initialC * ones(tEnd/6,1);
   result_mafts(:,24) = initialC * ones(tEnd/6,1);
   result_fcm(1,1:23)=initialCond;
   result_mafts(1,1:23)=initialCond;
   
   for t=2:tEnd/6
       result_fcm(t,1:23) = result_fcm(t-1,1:23) + evalfis(result_fcm(t-1,:),resultFis);
       RMSE_pred_fcm = RMSE_pred_fcm + norm((evalfis(y(t-1,:),resultFis)-(y(t,1:23) - y(t-1,1:23))) ./ maxValues)^2;
       MAE_pred_fcm = MAE_pred_fcm + sum((abs(evalfis(y(t-1,:),resultFis)-(y(t,1:23) - y(t-1,1:23))))  ./ maxValues);
       RMSE_all_fcm = RMSE_all_fcm + norm((result_fcm(t,1:23)-y(t,1:23)) ./ maxValues)^2;
       MAE_all_fcm = MAE_all_fcm + sum((abs(result_fcm(t,1:23)-y(t,1:23))) ./ maxValues);
       
       result_mafts(t,1:23) = evalfis(result_mafts(t-1,:),fis);
       RMSE_pred_mafts = RMSE_pred_mafts + norm((evalfis(y(t-1,:),fis)-y(t,1:23)) ./ maxValues)^2;
       MAE_pred_mafts = MAE_pred_mafts + sum((abs(evalfis(y(t-1,:),fis)-y(t,1:23))) ./ maxValues);
       RMSE_all_mafts = RMSE_all_mafts + norm((result_mafts(t,1:23)-y(t,1:23)) ./ maxValues)^2;
       MAE_all_mafts = MAE_all_mafts + sum((abs(result_mafts(t,1:23)-y(t,1:23))) ./ maxValues);
   end
end

RMSE_pred_fcm = sqrt(RMSE_pred_fcm / (23*50*tEnd/6))
RMSE_pred_mafts = sqrt(RMSE_pred_mafts / (23*50*tEnd/6))
RMSE_all_fcm = sqrt(RMSE_all_fcm / (23*50*tEnd/6))
RMSE_all_mafts = sqrt(RMSE_all_mafts / (23*50*tEnd/6))

MAE_pred_fcm = MAE_pred_fcm / (23*50*tEnd/6)
MAE_pred_mafts = MAE_pred_mafts / (23*50*tEnd/6)
MAE_all_fcm = MAE_all_fcm / (23*50*tEnd/6)
MAE_all_mafts = MAE_all_mafts / (23*50*tEnd/6)

