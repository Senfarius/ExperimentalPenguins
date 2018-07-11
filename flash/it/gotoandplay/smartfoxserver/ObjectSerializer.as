/**
 * Actionscript 2.0 Object Serializer / Deserializer.
 * Supports:
 * primitive datatypes: null, boolean, number, string
 * object datatypes: object, array
 * 
 * @version	3.1.0
 * 
 * @author	The gotoAndPlay() Team
 * 			{@link http://www.smartfoxserver.com}
 * 			{@link http://www.gotoandplay.it}
 * 
 * @exclude
 */
class it.gotoandplay.smartfoxserver.ObjectSerializer
{
	private static var __instance:ObjectSerializer
	
	private var tabs, xmlStr, eof:String
	public var debug:Boolean
	
	private var ascTab, ascTabRev:Array
	private var xmlData:XML
	private var resObj:Object
	
	private var hexTable:Array
	
	
	//--------------------------------------------------------
	// Private Constructor: not used. Singleton class
	//--------------------------------------------------------
	private function ObjectSerializer()
	{
		// No access to external instance creation
		init()
	}
	
	
	
	//--------------------------------------------------------
	// Create the one and only instance of this class
	//--------------------------------------------------------
	public static function getInstance():ObjectSerializer
	{
		if (__instance == null)
			__instance = new ObjectSerializer()
		
		return __instance
	}
	
	
	
	//--------------------------------------------------------
	// Initialize instance
	//--------------------------------------------------------
	private function init():Void
	{
		this.tabs 	= "\t\t\t\t\t\t\t\t\t\t"			// used for debug only, for xml formatting
		this.xmlStr 	= ""						// the final XML text of the serialized obj
		this.debug 	= false						// if true, formats XML in human readable style
		this.eof	= ""						// end of line constant, used only for debug
		
		//--- XML Entities Conversion table ----------------------
		this.ascTab			= []
		this.ascTab[">"] 		= "&gt;"
		this.ascTab["<"] 		= "&lt;"
		this.ascTab["&"] 		= "&amp;"
		this.ascTab["'"] 		= "&apos;"
		this.ascTab["\""] 		= "&quot;"
		
		this.ascTabRev			= []
		this.ascTabRev["&gt;"]		= ">"
		this.ascTabRev["&lt;"] 		= "<"
		this.ascTabRev["&amp;"] 	= "&"
		this.ascTabRev["&apos;"] 	= "'"
		this.ascTabRev["&quot;"] 	= "\""
		
		
		// Char codes in the upper Ascii range
		/*
		for (var i:Number = 127; i <= 255; i++)
		{
			this.ascTab[i] = "&#x" + i.toString(16) + ";"
			this.ascTabRev["&#x" + i.toString(16) + ";"] = String.fromCharCode(i);
		}*/
		
		hexTable = new Array()
		hexTable["0"] = 0
		hexTable["1"] = 1
		hexTable["2"] = 2
		hexTable["3"] = 3
		hexTable["4"] = 4
		hexTable["5"] = 5
		hexTable["6"] = 6
		hexTable["7"] = 7
		hexTable["8"] = 8
		hexTable["9"] = 9
		hexTable["A"] = 10
		hexTable["B"] = 11
		hexTable["C"] = 12
		hexTable["D"] = 13
		hexTable["E"] = 14
		hexTable["F"] = 15
	}
	
	
	
	//--------------------------------------------------------
	// Given an object returns the serialized XML form
	//--------------------------------------------------------
	public function serialize(obj:Object)
	{
		var envelope:Object = {}
		envelope.xmlStr = ""
	
		if (this.debug) 
			this.eof = "\n"
		
		obj2xml(envelope, obj, 0, "")	// Call serializer recursive method
		
		return envelope.xmlStr		// returns the XML text
	}
	
	
	
	//--------------------------------------------------------
	// Create an XML representation of the object
	//
	// envelope is used to incapsulate the final result String
	// Strings are not passed as reference...
	//--------------------------------------------------------
	private function obj2xml(envelope:Object, obj:Object, lev:Number, objn:String)
	{

		// Open root TAG
		// <dataObject></dataObject>
		if (lev == 0)
			envelope.xmlStr += "<dataObj>" + this.eof
		else
		{
			if (this.debug)
				envelope.xmlStr += this.tabs.substr(0, lev) 
			
			// Object type
			var ot:String = (obj instanceof Array) ? "a" : "o"
	
			envelope.xmlStr += "<obj t='" + ot + "' o='" + objn + "'>" + this.eof
		}
		
		// Scan the object recursively
		for (var i in obj)
		{
			var t 	= typeof obj[i]
			var o 	= obj[i]		
			
			//
			// if a primitive type is found
			// generate an xml <var n="name" t="type">value</var> TAG
			//
			// n = name of var
			//
			// t = b: boolean
			//     n: number
			//     s: string
			//     x: null
			//
			// v = value of var
			//
			if ((t == "boolean") || (t == "number") || (t == "string") || (t == "null"))
			{	
				if (t == "boolean")
				{
					o = Number(o)
				}
				else if (t == "null")
				{
					t = "x"
					o = ""
				}
				else if (t == "string")
				{
					o = this.encodeEntities(o)
				}
				
				if (this.debug)
					envelope.xmlStr += this.tabs.substr(0, lev+1)
				
				envelope.xmlStr += "<var n='" + i + "' t='" + t.substr(0,1) + "'>" + o + "</var>" + this.eof
			}
			
			//
			// if an object / array is found
			// recursively scans the new Object
			// and create a <obj o=""></obj> TAG
			//
			// o = object name
			//
			else if (t == "object")
			{
				this.obj2xml(envelope, o, lev + 1, i)
				
				if (this.debug)
					envelope.xmlStr += this.tabs.substr(0, lev + 1)
	
				envelope.xmlStr += "</obj>" + this.eof
			}
		}
		
		// Close root TAG
		if (lev == 0)
			envelope.xmlStr += "</dataObj>" + this.eof
	}
	
	
	
	//--------------------------------------------------------
	// Return an object from an xml serialized form
	//--------------------------------------------------------
	public function deserialize(xmlObj:String):Object
	{
		var xmlData:XML			= new XML(xmlObj)		// xml Object
		xmlData.ignoreWhite 		= true				// this does not work as it is declared AFTER the XML Object is populated
		
		var resObj:Object		= new Object()			// holds result Object
	
		this.xml2obj(xmlData, resObj)					// calls recursive xml parser
		
		return resObj							// Delete local object
	}
	
	
	
	//--------------------------------------------------------
	// Take an XML object representation and re-creates
	// the original object
	//--------------------------------------------------------
	private function xml2obj(xmlNode:XMLNode, currObj:Object)
	{		
		// counter
		var i:Number = 0
		
		// take first child inside XML object
		var node:XMLNode = xmlNode.firstChild
		
		// Main recursion loop
		while(node.childNodes[i])
		{	
			// If an object definition is found
			// create the new Object in the current Object and recursively scan the xml data
			//if(node.childNodes[i].childNodes.length > 0)
			if (node.childNodes[i].nodeName == "obj")
			{
				// Get Object name
				var n:String = node.childNodes[i].attributes.o
				
				// Get Object type
				var ot:String = node.childNodes[i].attributes.t
				
				//trace("{ found object = " + node.childNodes[i].attributes.o + "}\n")
				//trace("nodeName: " + node.childNodes[i].nodeName)
				
				// Create the right type of Object
				if (ot == "a")
					currObj[n] = []
				else if (ot == "o")
					currObj[n] = {}
					
				//trace("node:" + node.childNodes[i])
				// Recursion
				this.xml2obj(new XML(node.childNodes[i]), currObj[n]);
			} 
			
			// If a primitive type is found
			// create the variable inside the current Object casting its value to the original datatype
			else
			{
				// Found a variable
				var n:String = node.childNodes[i].attributes.n
				var t:String = node.childNodes[i].attributes.t
				var v:String = node.childNodes[i].firstChild.nodeValue
				
				// Dynamically cast the variable value to its original datatype
				var fn:Function
				
				if (t == "b")
					fn = function (b) { return Boolean(Number(b)) }
				else if (t == "n")
					fn = Number
				else if (t == "s")
					fn = String
				else if (t == "x")
					fn = function(x) { return null; }
	
				currObj[n] = fn(v)
				
				//if (fn == String)
					//currObj[n] = this.decodeEntities(currObj[n])
					

			}
			
			// next xml node
			i++;
		}
		
	}
	
	
	
	//---------------------------------------------------------
	// Helper methods -- v 0.2
	// 
	// Encode/Decode xml entities
	//---------------------------------------------------------
	public function encodeEntities(st:String):String
	{
		var strbuff:String = ""
	
		// char codes < 32 are ignored except for tab,lf,cr
		
		for (var i:Number = 0; i < st.length; i++)
		{
			var ch:String = st.charAt(i)
			var cod:Number = st.charCodeAt(i)
			
			if (cod == 9 || cod == 10 || cod == 13)
			{
				strbuff += ch
			}
			else if (cod >= 32 && cod <=126)
			{
				if (this.ascTab[ch] != undefined)
				{
					strbuff += this.ascTab[ch]
				}
				else
					strbuff += ch
			}
			/*
			else if (cod > 126 && cod <= 255)
			{
				strbuff += this.ascTab[cod]
			}
			else if (cod > 255)
			{
				strbuff += "&#x" + cod.toString(16) + ";"
			}*/
			else
				strbuff += ch
		}
	
		return strbuff
	}
	
	
	
	public function decodeEntities(st:String):String
	{
		var strbuff, ch, ent, chi, item:String
		var i:Number = 0

		strbuff = ""

		while(i < st.length)
		{
			ch = st.charAt(i)

			if (ch == "&")
			{
				ent = ch
				
				// read the complete entity
				do
				{
					i++
					chi = st.charAt(i)
					ent += chi
					//trace(ent)
				} 
				while (chi != ";" && i < st.length)
				
				item = this.ascTabRev[ent]

				if (item != undefined)
					strbuff += item
				else
					strbuff += String.fromCharCode(getCharCode(ent))
			}
			else
				strbuff += ch
				
			i++
		}
		
		return strbuff
	}
	
	
	//-----------------------------------------------
	// Transform xml code entity into hex code
	// and return it as a number
	//-----------------------------------------------
	public function getCharCode(ent:String):Number
	{
		var hex:String = ent.substr(3, ent.length)	
		hex = hex.substr(0, hex.length - 1)
		
		return Number("0x" + hex)
	}
}

