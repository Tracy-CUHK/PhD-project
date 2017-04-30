function pno_data = HandData(di)
% HandData.m

pno_data = {};
while true
     % get time stamp
     ts = tetio_localTimeNow();
     
     % skip #bytes in header to station number
     tmp = zeros(1,1);
     di.read(tmp,0,1);
     
       % get station number
       snum = single(di.readByte) - 48;
       
       % skip more of the header
       tmp = zeros(1,1);
       di.read(tmp,0,1);
       
       % get pno data
       pno = zeros(1,6,'single');
       for i = 1:6
           pno(i) = swapbytes(single(di.readFloat) );
       end
       
       % skip crlf
       tmp = zeros(1,2);
       di.read(tmp,0,2);
       
       % create row with data
       pno_row = {ts snum pno(1) pno(2) pno(3) pno(4) pno(5) pno(6)};
       
       % append row to pno_data
       pno_data = cat(1,pno_data,pno_row);
catch err
    fprintf(1, err.message() );
    sca;
end
end
            