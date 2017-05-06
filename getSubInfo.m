function subinfo=getSubInfo()
%getSubInfo.m
prompt={'Subject Number', 'Gender[1=male, 2=female]', 'GMFCS level', 'Birth', 'Dominant hand[1=L, 2=R]', 'Block[1, 2, 3, 4, 5]'};
dlg_title='Subject Information';
num_lines=1;
defautanswer={'01', '1', '1', ' ', '2', ' '};
subinfo=inputdlg(prompt, dlg_title, num_lines, defautanswer);
end