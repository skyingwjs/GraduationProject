%spectrum: Ƶ������,ÿ��Ϊһ֡��Ƶ������
%start_index:���Ӵ���ʼ������� ������
%end_index:���Ӵ���ֹ������� ������
%subbands:���ֺ���Ӵ�����,��Ԫ����subbands{i,j}�洢�ŵ�i֡����j�Ӵ���Ƶ������

function subbands=subbands_divide(spectrum,start_end_index)

%�����Ӵ�
    for i=1:size(spectrum,2)%size(spectrum,2)��ʾ֡��Ŀ һ��Ϊһ֡
        one_frame_spectrum_data= spectrum(:,i);
        for j=1:length(start_end_index)
            subbands{i,j}=one_frame_spectrum_data(start_end_index(j,1):start_end_index(j,2));
        end
    end
    subbands=subbands';
end

