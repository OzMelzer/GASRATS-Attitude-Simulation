try
    model = 'GASRATS_ADCS_Simulation';
    load_system(model);
    
    blocks = find_system(model, 'LookUnderMasks', 'all', 'FollowLinks', 'on');
    fprintf('Total blocks (with links/masks): %d\n', length(blocks));
    
    for i = 1:length(blocks)
        b = blocks{i};
        try
            params = get_param(b, 'ObjectParameters');
            fields = fieldnames(params);
            for j = 1:length(fields)
                field = fields{j};
                val = get_param(b, field);
                if ischar(val) && (contains(val, 'eph') || contains(val, '421') || contains(val, 'Ephemeris'))
                    fprintf('Block: "%s"\n  Param: "%s" = "%s"\n', b, field, val);
                end
            end
        catch
            % ignore
        end
    end
    
    close_system(model, 0);
catch ME
    fprintf('Error: %s\n', ME.message);
    if exist('model', 'var')
        close_system(model, 0);
    end
end
