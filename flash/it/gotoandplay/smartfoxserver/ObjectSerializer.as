class it.gotoandplay.smartfoxserver.ObjectSerializer
{
    var tabs, xmlStr, debug, eof, ascTab, ascTabRev, hexTable;
    static var __instance;
    function ObjectSerializer()
    {
        this.init();
    } // End of the function
    static function getInstance()
    {
        if (it.gotoandplay.smartfoxserver.ObjectSerializer.__instance == null)
        {
            __instance = new it.gotoandplay.smartfoxserver.ObjectSerializer();
        } // end if
        return (it.gotoandplay.smartfoxserver.ObjectSerializer.__instance);
    } // End of the function
    function init()
    {
        tabs = "\t\t\t\t\t\t\t\t\t\t";
        xmlStr = "";
        debug = false;
        eof = "";
        ascTab = [];
        ascTab[">"] = "&gt;";
        ascTab["<"] = "&lt;";
        ascTab["&"] = "&amp;";
        ascTab["\'"] = "&apos;";
        ascTab["\""] = "&quot;";
        ascTabRev = [];
        ascTabRev["&gt;"] = ">";
        ascTabRev["&lt;"] = "<";
        ascTabRev["&amp;"] = "&";
        ascTabRev["&apos;"] = "\'";
        ascTabRev["&quot;"] = "\"";
        hexTable = new Array();
        hexTable["0"] = 0;
        hexTable["1"] = 1;
        hexTable["2"] = 2;
        hexTable["3"] = 3;
        hexTable["4"] = 4;
        hexTable["5"] = 5;
        hexTable["6"] = 6;
        hexTable["7"] = 7;
        hexTable["8"] = 8;
        hexTable["9"] = 9;
        hexTable.A = 10;
        hexTable.B = 11;
        hexTable.C = 12;
        hexTable.D = 13;
        hexTable.E = 14;
        hexTable.F = 15;
    } // End of the function
    function serialize(obj)
    {
        var _loc2 = {};
        _loc2.xmlStr = "";
        if (debug)
        {
            eof = "\n";
        } // end if
        this.obj2xml(_loc2, obj, 0, "");
        return (_loc2.xmlStr);
    } // End of the function
    function obj2xml(envelope, obj, lev, objn)
    {
        if (lev == 0)
        {
            envelope.xmlStr = envelope.xmlStr + ("<dataObj>" + eof);
        }
        else
        {
            if (debug)
            {
                envelope.xmlStr = envelope.xmlStr + tabs.substr(0, lev);
            } // end if
            var _loc8 = obj instanceof Array ? ("a") : ("o");
            envelope.xmlStr = envelope.xmlStr + ("<obj t=\'" + _loc8 + "\' o=\'" + objn + "\'>" + eof);
        } // end else if
        for (var _loc7 in obj)
        {
            var _loc2 = typeof(obj[_loc7]);
            var _loc4 = obj[_loc7];
            if (_loc2 == "boolean" || _loc2 == "number" || _loc2 == "string" || _loc2 == "null")
            {
                if (_loc2 == "boolean")
                {
                    _loc4 = Number(_loc4);
                }
                else if (_loc2 == "null")
                {
                    _loc2 = "x";
                    _loc4 = "";
                }
                else if (_loc2 == "string")
                {
                    _loc4 = this.encodeEntities(_loc4);
                } // end else if
                if (debug)
                {
                    envelope.xmlStr = envelope.xmlStr + tabs.substr(0, lev + 1);
                } // end if
                envelope.xmlStr = envelope.xmlStr + ("<var n=\'" + _loc7 + "\' t=\'" + _loc2.substr(0, 1) + "\'>" + _loc4 + "</var>" + eof);
                continue;
            } // end if
            if (_loc2 == "object")
            {
                this.obj2xml(envelope, _loc4, lev + 1, _loc7);
                if (debug)
                {
                    envelope.xmlStr = envelope.xmlStr + tabs.substr(0, lev + 1);
                } // end if
                envelope.xmlStr = envelope.xmlStr + ("</obj>" + eof);
            } // end if
        } // end of for...in
        if (lev == 0)
        {
            envelope.xmlStr = envelope.xmlStr + ("</dataObj>" + eof);
        } // end if
    } // End of the function
    function deserialize(xmlObj)
    {
        var _loc2 = new XML(xmlObj);
        _loc2.ignoreWhite = true;
        var _loc3 = new Object();
        this.xml2obj(_loc2, _loc3);
        return (_loc3);
    } // End of the function
    function xml2obj(xmlNode, currObj)
    {
        var _loc2 = 0;
        var _loc3 = xmlNode.firstChild;
        while (_loc3.childNodes[_loc2])
        {
            if (_loc3.childNodes[_loc2].nodeName == "obj")
            {
                var _loc4 = _loc3.childNodes[_loc2].attributes.o;
                var _loc8 = _loc3.childNodes[_loc2].attributes.t;
                if (_loc8 == "a")
                {
                    currObj[_loc4] = [];
                }
                else if (_loc8 == "o")
                {
                    currObj[_loc4] = {};
                } // end else if
                this.xml2obj(new XML(_loc3.childNodes[_loc2]), currObj[_loc4]);
            }
            else
            {
                _loc4 = _loc3.childNodes[_loc2].attributes.n;
                var _loc6 = _loc3.childNodes[_loc2].attributes.t;
                var _loc9 = _loc3.childNodes[_loc2].firstChild.nodeValue;
                var _loc5;
                if (_loc6 == "b")
                {
                    _loc5 = function (b)
                    {
                        return (Boolean(Number(b)));
                    };
                }
                else if (_loc6 == "n")
                {
                    _loc5 = Number;
                }
                else if (_loc6 == "s")
                {
                    _loc5 = String;
                }
                else if (_loc6 == "x")
                {
                    _loc5 = function (x)
                    {
                        return (null);
                    };
                } // end else if
                currObj[_loc4] = _loc5(_loc9);
            } // end else if
            ++_loc2;
        } // end while
    } // End of the function
    function encodeEntities(st)
    {
        var _loc2 = "";
        for (var _loc5 = 0; _loc5 < st.length; ++_loc5)
        {
            var _loc3 = st.charAt(_loc5);
            var _loc4 = st.charCodeAt(_loc5);
            if (_loc4 == 9 || _loc4 == 10 || _loc4 == 13)
            {
                _loc2 = _loc2 + _loc3;
                continue;
            } // end if
            if (_loc4 >= 32 && _loc4 <= 126)
            {
                if (ascTab[_loc3] != undefined)
                {
                    _loc2 = _loc2 + ascTab[_loc3];
                }
                else
                {
                    _loc2 = _loc2 + _loc3;
                } // end else if
                continue;
            } // end if
            _loc2 = _loc2 + _loc3;
        } // end of for
        return (_loc2);
    } // End of the function
    function decodeEntities(st)
    {
        var _loc4;
        var _loc6;
        var _loc3;
        var _loc5;
        var _loc8;
        var _loc2 = 0;
        _loc4 = "";
        while (_loc2 < st.length)
        {
            _loc6 = st.charAt(_loc2);
            if (_loc6 == "&")
            {
                _loc3 = _loc6;
                do
                {
                    ++_loc2;
                    _loc5 = st.charAt(_loc2);
                    _loc3 = _loc3 + _loc5;
                } while (_loc5 != ";")
                _loc8 = ascTabRev[_loc3];
                if (_loc8 != undefined)
                {
                    _loc4 = _loc4 + _loc8;
                }
                else
                {
                    _loc4 = _loc4 + String.fromCharCode(this.getCharCode(_loc3));
                } // end else if
            }
            else
            {
                _loc4 = _loc4 + _loc6;
            } // end else if
            ++_loc2;
        } // end while
        return (_loc4);
    } // End of the function
    function getCharCode(ent)
    {
        var _loc1 = ent.substr(3, ent.length);
        _loc1 = _loc1.substr(0, _loc1.length - 1);
        return (Number("0x" + _loc1));
    } // End of the function
} // End of Class
