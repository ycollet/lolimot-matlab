function d = verifDifferencesFinies(this, values)
% LL_Lolimot::verifDifferencesFinies
    
    nbValues = length(values);
    epsilon = 0.001;
    ref = calculeF(this, values);
    for (i = 1 : nbValues)
        values(i) = values(i) + epsilon;
        d(i) = (calculeF(this, values) - ref) / epsilon;
        values(i) = values(i) - epsilon;
    end


