class Main inherits IO{
		--check if x is observed or not
		flag:Bool;  

		-- given input is stored in "input"
		input:String;

		s:String;
		t1:String;
		t2:String;
		z:String;
		return:String;
		first:StackList;
		stack_number:Int;
		a2iobj:A2I;
		temp:StackList;
		temp1:StackList;
		
	main():Object{{

		--object is created for class A2I
		a2iobj<-new A2I; 

		--initially, stack is empty
		stack_number<-0;

		--initially, set true 
		flag<-true;

		while flag loop{  --continues till stop symbol "x" is observed

			out_string(">");
			input<-in_string();

			if input="x" 
			then 
				{
					--terminates the while loop and program ends.
					flag<-false; 
				}

			-- for evaluation	
			else if input="e"
			then
				{ 
					--top element from the stack is popped
					s<-popup();

					--perform add operation
					if s="+" 
					then
						{   
							--top 2 elements from the stack after removing s
							t1<-popup();
							t2<-popup();

							--convert the integers which are in form of string, to integers using A2I class 
							-- and then perform add operation, and push it into the stack

							push(a2iobj.i2a(a2iobj.a2i(t1)+a2iobj.a2i(t2)));

						}

					--swap operation has to be performed
					else if s="s"
					then 
						{
							--pop out two top most elements
							t1<-popup();
							t2<-popup();

							-- push them in reverse order (equivalent to swapping of strings)
							push(t1);
							push(t2);
						}
					else {
						z<-popup();
						push(z);
					}
					fi fi;

				}

			--print the stack	
			else if input="d" then print()

			-- if the input is integer then push it into the stack
			else push(input)
			fi fi fi;
		}
		pool;
	}
	};


	push(a:String):Object{
		{

			--increase the number of elements in stack
			stack_number<-stack_number+1;

			--object of class StackList
			temp<-new StackList; 

			temp.init(a);
			if stack_number=1 
			then {

				-- make the first element as head
				first<-temp;
			}
			else {

				-- add element to the list and make it the head of the list, rest all stored in next.
				temp.add(first);
				first<-temp;
				}
			fi;
		}
	};


	popup():String{
		{
			--decrement the number of elements in stack by 1
		stack_number<-stack_number-1;

		--pop the head element
		return<-first.get_item();

		-- make the remaining next as head
		first<-first.get_next();

		return;
		}
	};


	print():Object{
		{
			-- temp1 traverses through the stack, starting from top
			temp1<-first;

			--when the stack is not empty
			while not(isvoid temp1)
			loop{
				--print the top most element
				out_string(temp1.get_item());
				out_string("\n");
				-- shift the temp1 downwards
				temp1<-temp1.get_next();
			}
			pool;
		}
	};

};

class StackList{ --List type

	item:String;
	next:StackList;

	init(x:String):Object{

		-- top most element
		item <-x
		
	};
	add(y:StackList):Object{

		-- tail part of the list
		next<-y
	};
	get_item():String{

		-- top most element
		item

	};
	get_next():StackList{

		-- tail part
		next
	};

};