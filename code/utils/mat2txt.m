%将矩阵保存到txt文件中
function back = mat2txt( file_name, matrix ) 
    
    fop = fopen( file_name, 'wt' );
    [M,N] = size(matrix);
    for m = 1:M
        for n = 1:N
            fprintf( fop, ' %s', mat2str( matrix(m,n) ) );
        end
        fprintf(fop, '\n' );
    end
    back = fclose( fop ) ;
end