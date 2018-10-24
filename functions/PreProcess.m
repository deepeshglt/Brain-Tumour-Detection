function varargout = PreProcess(varargin)
if(length(varargin)==2)
    i = varargin{1};
    i_mask = varargin{2};
    i1 = imadjust(i);
    [io1,io2] = CropROI(i1,i_mask);
    varargout{1} = io1;
    varargout{2} = io2;
else
    i = varargin{1};
    i1 = imadjust(i);
    varargout{1} = CropROI(i1);
end

end