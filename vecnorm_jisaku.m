function mat = vecnorm_jisaku(matrix,dim) % matlab.ver<2017b,
sizemat = size(matrix);
if numel(sizemat) ~= 2
    fprintf('Dimension must be 2\n');
    return
end
if dim == 1
    size_DIO = sizemat(2);
    mat = zeros(size_DIO,1);
    for i_vec = 1 : size_DIO
        mat(i_vec) = norm(matrix(:,i_vec));
    end
else
    size_DIO = sizemat(1);
    mat = zeros(size_DIO,1);
    for i_vec = 1 : size_DIO
        mat(i_vec) = norm(matrix(i_vec,:));
    end
end
