% 1. Load the OpenNeuro Alzheimer's dataset
data = readtable('participants.txt', 'FileType', 'text');

% 2. Clean the data: Strip rows where MMSE or Group columns are missing
cleanedData = rmmissing(data, 'DataVariables', {'Group', 'MMSE'});

% 3. Calculate basic clinical summary metrics for your pitch
categories = unique(cleanedData.Group);
fprintf('\n--- Dataset Summary Info ---\n');
for i = 1:length(categories)
    subGroup = cleanedData(strcmp(cleanedData.Group, categories{i}), :);
    avgAge = mean(subGroup.Age);
    avgMMSE = mean(subGroup.MMSE);
    fprintf('Group: %s | Count: %d | Avg MMSE: %.1f\n', categories{i}, height(subGroup), avgMMSE);
end

% 4. Export the clean matrix as a standard CSV file for R
writetable(cleanedData, 'cleaned_alzheimers_data.csv');
fprintf('\nSuccess! "cleaned_alzheimers_data.csv" is saved and ready.\n');
