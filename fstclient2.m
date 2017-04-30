% used to connect to fserver and parse frames, assumes default output
% records and that the tracker is a Fastrak (any version)
function pno_data = fstclient2(host_str, port_num, seconds)

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
    
    pno_data = {};
    
    % collect data and store it in the array
    t1 = tic;
    while toc(t1) < seconds
        try
            % get time stamp
            ts = tetio_localTimeNow();
            
            % skip #bytes in header to station number
            tmp = zeros(1,1);
            di_stream.read(tmp,0,1);

            % get station number
            snum = single(di_stream.readByte) - 48;
        
            % skip more of the header
            tmp = zeros(1,1);
            di_stream.read(tmp,0,1);
            
            % get pno data
            pno = zeros(1,6,'single');
            for i = 1:6
                pno(i) = swapbytes(single(di_stream.readFloat) );
            end
            
            % skip crlf
            tmp = zeros(1,2);
            di_stream.read(tmp,0,2);
        
            % create row with data
            pno_row = {ts snum pno(1) pno(2) pno(3) pno(4) pno(5) pno(6)};
        
            % append row to pno_data
            pno_data = cat(1,pno_data,pno_row);
        catch err
            fprintf(1, err.message() );
            break;
        end
    end
    
    % disconnect from the socket
    fprintf(1, 'Disconnected...\n');
    socket.close();
end