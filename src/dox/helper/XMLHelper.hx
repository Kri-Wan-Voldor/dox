/*Copyright (c) 2003-2015, GameDuell GmbH
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/

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