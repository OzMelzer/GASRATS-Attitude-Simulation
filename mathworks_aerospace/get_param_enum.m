try
    model = 'GASRATS_ADCS_Simulation';
    load_system(model);
    block = 'GASRATS_ADCS_Simulation/CubeSat Vehicle/Calculate pointing command/First Constraint/Sun /Sun Position';
    dp = get_param(block, 'DialogParameters');
    if isfield(dp, 'ephemerisModel') && isfield(dp.ephemerisModel, 'Enum')
        for i = 1:length(dp.ephemerisModel.Enum)
            fprintf('%s\n', dp.ephemerisModel.Enum{i});
        end
    else
        fprintf('No enum field found\n');
    end
    close_system(model, 0);
catch ME
    fprintf('Error: %s\n', ME.message);
    if exist('model', 'var')
        close_system(model, 0);
    end
end
