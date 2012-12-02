import std.stdio;
import expression;
import scanner;
import parser;

void main()
{
    auto tokens=scanfile("sample_list.txt");
    while(tokens.length>0){
	auto exp=parse(tokens);
	write(exp.tostring()~"\n");
    }
}
