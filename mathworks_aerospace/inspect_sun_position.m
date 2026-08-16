try
    model = 'GASRATS_ADCS_Simulation';
    load_system(model);
    
    block = 'GASRATS_ADCS_Simulation/CubeSat Vehicle/Calculate pointing command/First Constraint/Sun /Sun Position';
    fprintf('Block: %s\n', block);
    
    % Let's get DialogParameters or MaskNames
    dp = get_param(block, 'DialogParameters');
    if ~isempty(dp)
        fields = fieldnames(dp);
        for i = 1:length(fields)
            field = fields{i};
            val = get_param(block, field);
            fprintf('  DialogParam - %s: %s\n', field, char(string(val)));
        end
    end
    
    maskNames = get_param(block, 'MaskNames');
    if ~isempty(maskNames)
        maskValues = get_param(block, 'MaskValues');
        for i = 1:length(maskNames)
            fprintf('  MaskParam - %s: %s\n', maskNames{i}, maskValues{i});
        end
    end
    
    close_system(model, 0);
catch ME
    fprintf('Error: %s\n', ME.message);
    if exist('model', 'var')
        close_system(model, 0);
    end
end
