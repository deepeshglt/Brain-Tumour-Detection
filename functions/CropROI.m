function varargout = CropROI(varargin)
if(length(varargin)==2)
    i1 = varargin{1};
    i_mask = varargin{2};
    i2 = im2double(i1);
    ix = sum(i2,1);
    iy = sum(i2,2);
    idx = find(ix>10);
    idy = find(iy>10);
    f_out_1 = i2(:,idx);
    varargout{1} = f_out_1(idy,:);
    f_out_1 = i_mask(:,idx);
    varargout{2} = f_out_1(idy,:);
else
    i1 = varargin{1};
    i2 = im2double(i1);
    ix = sum(i2,1);
    iy = sum(i2,2);
    idx = find(ix>10);
    idy = find(iy>10);
    f_out_1 = i2(:,idx);
    varargout{1} = f_out_1(idy,:);
end

end