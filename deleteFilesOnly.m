% DELETEFILESONLY 删除文件夹内的所有文件（保留子文件夹）
% 1.Function of this function
%     删除指定文件夹中非子文件夹的所有文件
% 2.Input parameters
%     folderPath:文件夹路径字符串
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     folderPath=fullfile(app_root,'example_folder');
%     deleteFilesOnly(folderPath);
%     Results:
%     None (delete corresponding files)
% --------------Implementation goes here---------------------
function deleteFilesOnly(folderPath)
    contents = dir(folderPath); % 获取文件夹内文件及子文件夹信息
    
    for i = 1:length(contents)
        if contents(i).isdir % 对于子文件夹
            % 跳过 '.' 和 '..' 目录
            if ~strcmp(contents(i).name, '.') && ~strcmp(contents(i).name, '..')
                % 递归处理子文件夹
                subFolder = fullfile(folderPath, contents(i).name);
                deleteFilesOnly(subFolder); % 递归调用
            end
        else
            % 删除文件
            [~, ~, ext] = fileparts(contents(i).name);
            if ~strcmp(ext, '.gitkeep')
                filePath = fullfile(folderPath, contents(i).name);
                delete(filePath);
            end
        end
    end
end