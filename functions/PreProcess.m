function out = PreProcess(i)
i1 = imadjust(i);
out = CropROI(i1);
end