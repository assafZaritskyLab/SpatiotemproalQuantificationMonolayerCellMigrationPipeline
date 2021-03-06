clearvars;
%% Plot PC's of a multiple kymographs
% pathToKymographsFolder = '/pathto_MultipleExperimentKymographs/';
% 
% measure = 'speed';
% [experimentsLabels, kymographsPaths] = getLabelsAndPaths(pathToKymographsFolder, measure);
% 
% 
% params.timePerFrame = 15; % in minutes
% params.maxDistToProcess = 150; % in µm
% params.stripSizeUm = 15; % in µm
% params.maxTimeToProcess = 300; % in minutes
% params.spatialPartition = 3;
% params.timePartition = 4;
% featuresNo = params.spatialPartition * params.timePartition;
% 
% featuresArray = zeros(featuresNo, length(experimentsLabels(:,1)));
% for expIDX=1:length(experimentsLabels(:,1))
%     featuresArray(:, expIDX) = kymographToFeaturesVec(kymographsPaths(expIDX, :), measure, params);
% end
% 
% pcaResultsByMeasure = PCAOnAllExperimentsMeasurements(measure, params, {}, featuresArray);
% 
% pcIndex = 1;
% pcaScores = pcaResultsByMeasure.(measure).score;
% entire_data_variablity = var(pcaScores);
% single_pc_explained_variance = var(pcaScores(:, pcIndex))/ sum(entire_data_variablity);
% 
% 
% pc1Scores = pcaScores(:, 1);
% pc2Scores = pcaScores(:, 2);
% hold on;
% scatter(pc1Scores, pc2Scores);
% title(sprintf('PC #1 about PC#2'));
% xlabel('PC1');
% ylabel('PC2');
% c = cellstr(experimentsLabels); 
% dx = 0.01; dy = 0.05;
% text(pc1Scores+dx, pc2Scores+dy, c, 'Fontsize', 10, 'Interpreter','none');
% hold off;
%% plot velocities 
% main_dir = '/Users/yishaiazabary/Quantifying monolayer cell migration Demo/Dataset from Zenodo/SingleMonolayerEdgeSamples/EXP_16HBE14o_1E_SAMPLE/VF/vf/';
% % main_dir = '/Users/yishaiazabary/Downloads/FOV19/VF/vf/';
% frame_num = 80;
% frame_file = [main_dir sprintf('%03d_vf.mat', frame_num)];
% figure;
% 
% vel_fields = load(frame_file);
% scores = vel_fields.scores;
% sz = size(vel_fields.dxs);
% velocities_amp = zeros(sz);
% velocities_amp = (vel_fields.dxs.^2 + vel_fields.dys.^2).^(1/2);
% % imagesc(velocities_amp); title(sprintf('velocity frame number %03d', frame_num));
% imagesc(scores); title(sprintf('frame %03d match score',frame_num));

%% Exercise 2 solution - calc and plot kymograph under different parameters
% experimentsFilePaths = ['EXP_16HBE14o_1E_SAMPLE.tif' 'EXP_MDCK_HGFSF_1E_SAMPLE.tif'];
% mainDirectoryFN = '/Users/yishaiazabary/Downloads/FOV19/ShortVersions/ready/';
% expsNames = ["EXP_16HBE14o_1E_SAMPLE.tif", "EXP_MDCK_HGFSF_1E_SAMPLE.tif"];
% patchSizes = [15 5];
% maxSpeeds = [90 30];
% pixelSizes = [1.267428 0.879];
% timePerFrames = [5 15];
% for configIdx = 1 : 2
%     for fileIdx = 1 : length(expsNames)
%         clear params;
%         pathToFile = [mainDirectoryFN convertStringsToChars(expsNames(fileIdx))];
%         params.patchSizeUm = patchSizes(configIdx); % calc 
%         params.pixelSize  =  pixelSizes(configIdx); % 2nd file 0.879
%         params.timePerFrame = timePerFrames(configIdx);
%         params.maxSpeed = maxSpeeds(configIdx);
%         [params, dirs] = initParamsDirs(pathToFile, params); % set missing parameters, create output directories
%         calcSpatiotemporalRaw(params, dirs);
%         allMeasuresToProcess = {'speed', 'directionality'};
%         KymographsByMeasure(params, dirs, allMeasuresToProcess);
%         close all;
%     end
% end
%% Exercise 5 solution - subtract two speed kymographs and visualize the resulting kymograph
% speedKymographsFN = '/Users/yishaiazabary/Downloads/FOV19/ShortVersions/safeguardKymos/';
% speedKymo1Path = [speedKymographsFN 'EXP_16HBE14o_1E_SAMPLE_speedKymograph.mat'];
% speedKymo2Path = [speedKymographsFN 'EXP_MDCK_HGFSF_1E_SAMPLE_speedKymograph.mat'];
% speedKymo1 = load(speedKymo1Path).speedKymograph; speedKymo2 = load(speedKymo2Path).speedKymograph;
% maxTimeToCompare = 50;
% subtratcionResult = speedKymo1(:, 1:maxTimeToCompare) - speedKymo2(:, 1:maxTimeToCompare);
% h = figure;
% hold on;
% colormap('jet');
% imagescnan(subtratcionResult);
% haxes = get(h,'CurrentAxes');
% set(h,'Color','w');
% hold off;
% 
