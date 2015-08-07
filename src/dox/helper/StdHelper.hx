package dox.helper;

import haxe.io.Path;

class StdHelper
{
    static public function createStdDocumention(cfg: Config): Void
    {
        try
        {
            var buildCWD: String = Sys.getCwd();
            var stdPath: String = Path.join([cfg.outputPath]);

            Sys.setCwd(stdPath);
            Sys.command("haxe", ["gen.hxml"]);
            Sys.command("haxe", ["std.hxml"]);
            Sys.setCwd(buildCWD);
        }
        catch(e: Dynamic)
        {
            Sys.println("Failed to rebuild the Haxe Std documentation");
            Sys.println(Std.string(e));
            Sys.exit(1);
        }
    }
}