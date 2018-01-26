function subbands_ILD=calculate_subbands_ILD(subbands_data_l,subbands_data_r)
%��������subbands_data_l ��������Ƶ���� �Ӵ����ֺ�� �Ӵ�Ƶ������ frame_number * 25����������������
%��������subbands_data_r ��������Ƶ���� �Ӵ����ֺ�� �Ӵ�Ƶ������ frame_number * 25����������������
%��������subbands_ILD ��֡���Ӵ�ILD                subbands_ILD(i,j)��i֡��j���Ӵ���ILD������������

frame_number=size(subbands_data_l,1);%֡��
subbands_number=size(subbands_data_l,2);%ÿ֡���Ӵ���
    for i=1:frame_number
        for j=1:subbands_number
              il_l(i,j)=sum(subbands_data_l{i,j} .*conj(subbands_data_l{i,j}) );
              il_r(i,j)=sum(subbands_data_r{i,j} .*conj(subbands_data_r{i,j}) );
%���������� il_l ,       il_r������ ������Ϊ0�� ----> eps ����ȡ����ʱ�Ͳ��� ����NaN
              if il_l(i,j)==0
                  il_l(i,j)=eps;
              end
              if il_r(i,j)==0
                  il_r(i,j)=eps;
              end              
              subbands_ILD(i,j)=10*log10(  il_l(i,j)/  il_r(i,j));
        end
    end
end

          