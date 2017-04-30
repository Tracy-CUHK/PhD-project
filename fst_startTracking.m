% used to connect to fserver and parse frames, assumes default output
% records and that the tracker is a Fastrak (any version)
function di_stream = fst_startTracking(host_str, port_num)

    % use java Socket and DataInputStream classes
    import java.net.Socket
    import java.io.*    
    
    % connect to the socket and open the data stream
    for attempt = 1:5
        try
            fprintf(1, 'Attempt #%d to connect...', attempt);
            socket = Socket(host_str, port_num);
            stream = socket.getInputStream;
            di_stream = DataInputStream(stream);
            fprintf(1, 'Success\n');
            break;
        catch
            fprintf(1, 'Failure\n');
            if ~isempty(socket)
                socket.close;
            end
            if attempt == 5
                error('Failed all attempts to connect');
            end
            pause(1);
        end % try
    end % for
end