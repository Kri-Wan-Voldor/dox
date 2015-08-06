package dox.helper;

import haxe.xml.Fast;
import Xml;
import haxe.xml.Fast;
using StringTools;

class XMLHelper
{
    static public function getInnerData(source: Fast, trim: Bool = true): String
    {
        var innerData: String = "";

        try
        {
            innerData = source.innerData;
        }
        catch (err: Dynamic)
        {
            innerData = getFastWithoutInnerNodes(source).innerHTML;
        }

        if (trim) innerData = innerData.trim();

        return innerData;
    }

    static public function getFastWithoutInnerNodes(fast: Fast): Fast
    {
        var childs: Array<Xml> = [];
        var f: Fast = new Fast(Xml.parse(fast.x.toString()).firstElement());

        for (element in f.elements)
        {
            childs.push(cast(element, Fast).x);
        }

        for (child in childs)
        {
            f.x.removeChild(child);
        }

        return f;
    }
}