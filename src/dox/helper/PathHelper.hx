package dox.helper;

import haxe.io.Path;
import sys.FileSystem;

class PathHelper
{
    static public function removeDirectory(directory : String) : Void
    {
        if (FileSystem.exists(directory))
        {
            var files;
            try
            {
                files = FileSystem.readDirectory(directory);
            }
            catch(e : Dynamic)
            {
                throw "An error occurred while deleting the directory " + directory;
            }

            for (file in FileSystem.readDirectory(directory))
            {
                var path = Path.join([directory, file]);

                try
                {
                    if (FileSystem.isDirectory(path))
                    {
                        removeDirectory(path);
                    }
                    else
                    {
                        try
                        {
                            FileSystem.deleteFile(path);
                        }
                        catch (e:Dynamic)
                        {
                            throw 'An error occurred while deleting the file $path';
                        }
                    }
                }
                catch (e:Dynamic)
                {
                    throw "An error occurred while deleting the directory " + directory;
                }
            }

            try
            {
                FileSystem.deleteDirectory (directory);
            }
            catch (e:Dynamic)
            {
                throw "An error occurred while deleting the directory " + directory;
            }
        }
    }
}