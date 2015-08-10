package dox;

import haxe.io.Path;
import Map;

@:keep
class Config {
	public var theme:Theme;
	public var rootPath:String;
	public var homePath:String;
	public var toplevelPackage:String;

	public var outputPathRoot(default, set): String;
	public var outputPath(default, set):String;
	public var xmlPath(default, set):String;
	public var pathFilters(default, null):haxe.ds.GenericStack<Filter>;

	public var platforms:Array<String>;
	public var resourcePaths:Array<String>;
	public var templatePaths(default, null):haxe.ds.GenericStack<String>;

	public var defines:Map<String, String>;
	public var pageTitle:String;

	public var packageDefinePath:String;

	public var templatePath(default, null): String;

	public var stdScriptRoot(get, never): String;
	public var docsRoot(get, never): String;

	public var rebuildStd: Bool;

	function set_outputPathRoot(v) {
		return outputPathRoot = haxe.io.Path.removeTrailingSlashes(v);
	}

	function set_outputPath(v) {
		return outputPath = haxe.io.Path.removeTrailingSlashes(v);
	}

	function set_xmlPath(v) {
		return xmlPath = haxe.io.Path.removeTrailingSlashes(v);
	}

	function get_stdScriptRoot(): String {
		return "std";
	}

	function get_docsRoot(): String {
		return "docs";
	}

	public function new() {
		homePath = "";
		outputPath = "";
		platforms = [];
		resourcePaths = [];
		toplevelPackage = "";
		defines = new Map();
		pathFilters = new haxe.ds.GenericStack<Filter>();
		templatePaths = new haxe.ds.GenericStack<String>();
		packageDefinePath = "";
		templatePath = Path.join([Sys.getEnv("PWD"), "template", "std"]);
		rebuildStd = false;
	}

	public function addFilter(pattern:String, isIncludeFilter:Bool) {
		pathFilters.add(new Filter(pattern, isIncludeFilter));
	}

	public function removeAllFilter(): Void	{
		pathFilters = new haxe.ds.GenericStack<Filter>();
	}

	public function addTemplatePath(path:String) {
		templatePaths.add(haxe.io.Path.removeTrailingSlashes(path));
	}

	public function loadTemplate(name:String) {
		for (tp in templatePaths) {
			if (sys.FileSystem.exists(tp + "/" +name)) return templo.Template.fromFile(tp + "/" + name);
		}
		throw "Could not resolve template: " +name;
	}

	public function setRootPath(path:String) {
		var depth = path.split(".").length - 1;
		rootPath = "";
		for (i in 0...depth) {
			rootPath += "../";
		}
		if (rootPath == "") rootPath = "./";
	}

	public function getHeaderIncludes() {
		var buf = new StringBuf();
		for (inc in theme.headerIncludes) {
			var path = new haxe.io.Path(inc);
			var s = switch(path.ext) {
				case 'css': '<link href="$rootPath${path.file}.css" rel="stylesheet" />';
				case 'js': '<script type="text/javascript" src="$rootPath${path.file}.js"></script>';
				case 'ico': '<link rel="icon" href="$rootPath${path.file}.ico" type="image/x-icon"></link>';
				case s: throw 'Unknown header include extension: $s';
			}
			buf.add(s);
		}
		return buf.toString();
	}

	public function getPackages(): Array<String>
	{
		return sys.io.File.getContent(packageDefinePath).split(":");
	}

	public function toString(): String
	{
		return 'Config: Theme name => ${theme.name}, rootPath => $rootPath, topLevelPackage => $toplevelPackage,
				outputPath => $outputPath, xmlPath => $xmlPath, pathFilters => ${pathFilters.toString()},
				platforms => ${platforms.toString()}, resourcePaths => ${resourcePaths.toString()},
				templatePaths => ${templatePaths.toString()}, defines => ${defines.toString()},
				pageTitle => $pageTitle';
	}
}

private class Filter {
	public var r(default, null):EReg;
	public var isIncludeFilter(default, null):Bool;

	public function new(pattern: String, isIncludeFilter:Bool) {
		r = new EReg(pattern, "");
		this.isIncludeFilter = isIncludeFilter;
	}
}
