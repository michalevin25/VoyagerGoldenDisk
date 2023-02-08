function [locs_max, locs_min, counter_adjust] = AdjustmentsTracePeaks (locs_max, locs_min)

%step 1: difference in number of peaks

%difference in number of peaks shouldnt be big. Raise an error if the
%difference is significant 
diff_L = abs(length(locs_max)-length(locs_min));
if diff_L > 50
    msg = strcat("Error in image number, ", num2str(img_number), ". Check peaks");
    error(msg);
end

%step 2: Make peaks lengths equal. Removing elements from the longer locs array
% in order to create equal locs arrays for future loops.

if length(locs_max) > length(locs_min)
    locs_max = locs_max(1:end-diff_L);
else
    locs_min = locs_min(1:end-diff_L);
end


% step 3: adjust peaks order of appearance: The first min is always before
% the first max. Didn't delete the first loc so the lengths of the locs arrays remain the
% same.

counter_adjust = 0;

if locs_min(1) > locs_max(1)
    counter_adjust = counter_adjust + 1;
end


