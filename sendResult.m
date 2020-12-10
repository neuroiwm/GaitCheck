%% 
result = cell(num_metrics,1);
fprintf('\n')
count_var = 0;
for i_metrics = 1 : num_metrics
    tmp = list_mongon{i_metrics,1};
    tmp = tmp{1,1};
    num_var =  sum(tmp == 'g');
    count_var = count_var + 1;
    if num_var == 1
        fprintf(tmp,round(eval(list_metrics{count_var,1}),2));
        result{i_metrics,1} = round(eval(list_metrics{count_var,1}),2);
    elseif num_var == 2
        metrics = eval(list_metrics{count_var,1});
        fprintf(tmp,round(metrics(1),2),round(metrics(2),2));
        result{i_metrics,1} = [round(metrics(1),2),round(metrics(2),2)];
    end
    fprintf('\n')
end

%%

% 
% sendolmail('iwama@brain.bio.keio.ac.jp',...
%      'Test link','Test message including a <A HREF=<http://www.mathworks.com>>Link</A>',...
%      {'C:\eula.1028.txt'});