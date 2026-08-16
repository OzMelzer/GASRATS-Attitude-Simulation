try
    model = 'GASRATS_ADCS_Simulation';
    load_system(model);
    
    block = 'GASRATS_ADCS_Simulation/CubeSat Vehicle/Calculate pointing command/First Constraint/Sun /Sun Position';
    fprintf('Block: %s\n', block);
    
    % Get port connectivity
    ports = get_param(block, 'PortConnectivity');
    for i = 1:length(ports)
        p = ports(i);
        fprintf('Port %d (%s):\n', i, p.Type);
        if ~isempty(p.DstBlock)
            for j = 1:length(p.DstBlock)
                try
                    dstName = get_param(p.DstBlock(j), 'Name');
                    fprintf('  -> Connects to Block: "%s" (Port %d)\n', dstName, p.DstPort(j));
                catch
                end
            end
        end
        if ~isempty(p.SrcBlock)
            try
                srcName = get_param(p.SrcBlock, 'Name');
                fprintf('  <- Connected from Block: "%s" (Port %d)\n', srcName, p.SrcPort);
            catch
            end
        end
    end
    
    close_system(model, 0);
catch ME
    fprintf('Error: %s\n', ME.message);
    if exist('model', 'var')
        close_system(model, 0);
    end
end
