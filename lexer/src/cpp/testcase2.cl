--In line 5, as first letter in "TRUE" is uppercase letter, it is interpreted as typeid.

class Main{
	x:Bool;
	x<-True;
	main():Obj{
		if(x) then out_string("true")
		else out_string("false")
		fi
	};
};