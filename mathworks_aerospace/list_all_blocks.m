try
    model = 'GASRATS_ADCS_Simulation';
    load_system(model);
    
    blocks = find_system(model);
    fprintf('Total blocks: %d\n', length(blocks));
    
    % Let's find blocks with specific keywords or Aerospace Blockset blocks
    for i = 1:length(blocks)
        b = blocks{i};
        try
            bt = get_param(b, 'BlockType');
            maskType = get_param(b, 'MaskType');
            name = get_param(b, 'Name');
            
            % If it is an aerospace block or might use ephemeris
            if ~isempty(maskType) || strcmp(bt, 'S-Function') || strcmp(bt, 'MATLABSystem')
                fprintf('Block: "%s"\n  Path: "%s"\n  Type: "%s", MaskType: "%s"\n', name, b, bt, maskType);
            end
        catch
            % ignore blocks we can't query
        end
    end
    
    close_system(model, 0);
catch ME
    fprintf('Error: %s\n', ME.message);
    if exist('model', 'var')
        close_system(model, 0);
    end
end
