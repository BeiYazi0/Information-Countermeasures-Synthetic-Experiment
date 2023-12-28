function res = decision_tree(signal)
cnt = feature_extraction_1(signal, 0.75, 0.7, 0.7);
res = 0;
if(cnt(1) == 1)
    res = 1;% "2ASK";
else
    if(cnt(1) == 2)
        res = 2;% "2FSK";
    else
        if(cnt(2) == 1)
            res = 3;% "BPSK";
        else
            if(cnt(3) == 1)
                res = 4;% "QPSK";
            end
        end
    end
end
end