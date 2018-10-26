function varargout = ExtractFeature(varargin)
if(length(varargin)==1)
    i = varargin{1};
    i = imresize(i,[128,128]);
    if(size(i)==3)
        i_gray = rgb2gray(i);
    else
        i_gray = i;
    end
    [i_crop] = PreProcess(i_gray);
    feature = ExtractGLCMFeature(i_crop);
    varargout{1} = feature;
    varargout{2} = i_crop;
elseif(length(varargin)==2)
    i = varargin{1};
    i_mask = varargin{2};
    i=imresize(i,[128,128]);
    i_mask=imresize(i_mask,[128,128]);
    if(size(i,3)==3)
        i_gray = rgb2gray(i);
    else
        i_gray = i;
    end
    [i_crop,i_mask] = PreProcess(i,i_mask);
    feature = ExtractGLCMFeature(i_crop);
    i_mask = i_mask(:);
    %----------set target--------------------%
    for i=1:length(i_mask)
        p = i_mask(i);
        if(p>=1)
            target_pixel(i,:)=1;
        else
            target_pixel(i,:)=0;
        end
    end
    varargout{1} = feature;
    varargout{2} = target_pixel;
end
end
