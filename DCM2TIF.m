% test
clc;
clear;
% DICOM�ļ�����·��
ROOTPATH = 'E:\DataSet\ҽѧͼ��ָ�\WWZ\IWOB2LVA\PV1YAB2C';

% ͼƬ���ֵ�������ʽ����Ҫ�޸�
% ƥ�� I9900000 ���͵�
Pattern = 'I\d{7}';

% ƥ��image_29540375455130352.dcm����
% Pattern = 'image_\d+.dcm';

imgPath = [ROOTPATH, '\TIF'];
if ~exist(imgPath, 'dir')
    mkdir(imgPath);
end
numImg = 1;
filelist = dir(ROOTPATH);
for i=1:length(filelist)
    str = filelist(i).name;
    matchStr = regexp(str, Pattern, 'match');
    % ���ƥ�䲻�ɹ���ƥ����һ��
    if isempty(matchStr)
        continue;
    end
    % ���ƥ��ɹ��������ַ�����ƥ���ϣ������ͼƬ����
    if length(matchStr{1}) == length(str)
        img=dicomread([ROOTPATH, '\', matchStr{1}]);
        img(img<0) = 0;
        img(img>2048) = 2047;
        img = uint16(img*2^3);
        fileNum = sprintf('%03d', numImg);
        filePath = [imgPath, '\result', fileNum, '.tif'];
        imwrite(img, filePath, 'Compression','none');
        numImg = numImg + 1;
    end
end