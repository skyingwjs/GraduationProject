%���������type����ȡ��ͬ�Ӵ���������µ���ʼ����ֹ����
%type��25��32��49��64��128��256��512��1024
%start_end_index�� ���Ӵ���ʼ����ֹ���ߵ�index

function start_end_index=subbands_type(type)
%���Ӵ�����ʼ������� �� ��ֹ�������

switch type
    
    case 14
        
        
    case 25
        start_index=[1 4 6 8 11 13 16 19 23 27 31 36 41 48 55 64 75 87 104 125 150 180 222 280 361];
        end_index= [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];
        start_end_index=[start_index' end_index'];
        
    case 49
        
    case 128
        
    case 513
        start_index=1:513;
        end_index=1:513;
        start_end_index=[start_index' end_index'];
              
    otherwise
             
end

end