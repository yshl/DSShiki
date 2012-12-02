module scanner;
import std.stdio;
import std.conv;
import std.ascii;
import std.regex;

enum TokenType{
    LParen, RParen, Int, Real, String, Symbol
}

class Token{
    TokenType type;
    union{
	long intval;
	real realval;
	string strval;
    }
    this(TokenType t, string s){
	type=t;
	switch(type){
	    case TokenType.LParen:
		break;
	    case TokenType.RParen:
		break;
	    case TokenType.Int:
		intval=to!(long)(s);
		break;
	    case TokenType.Real:
		realval=to!(real)(s);
		break;
	    case TokenType.String:
		strval=s;
		break;
	    case TokenType.Symbol:
		strval=s;
		break;
	    default:
		assert(0);
		break;
	}
    }
}

Token[] scanfile(string filename)
{
    auto file=File(filename,"r");
    return scanfile(file);
}

Token[] scanfile(File file)
{
    string buffer;
    foreach(string line; lines(file)){
	buffer~=line;
    }
    return scanstring(buffer);
}

Token[] scanstring(string buffer)
{
    Token[] tokens;
    while(buffer.length>0){
	auto m=match(buffer,regex(r"^\s+"));
	if(m){
	    buffer=m.post;
	}else if(m=match(buffer,regex(r"^\("))){
	    tokens~=new Token(TokenType.LParen, m.hit);
	    buffer=m.post;
	}else if(m=match(buffer,regex(r"^\)"))){
	    tokens~=new Token(TokenType.RParen, m.hit);
	    buffer=m.post;
	}else if(m=match(buffer,regex(
			r"^[+-]?(\d+\.(\d*)?|\.\d+)([eE][+-]?\d+)?"))){
	    tokens~=new Token(TokenType.Real, m.hit);
	    buffer=m.post;
	}else if(m=match(buffer,regex(r"^[+-]?\d+"))){
	    tokens~=new Token(TokenType.Int, m.hit);
	    buffer=m.post;
	}else if(m=match(buffer,regex(`^"([^"\\]|\\\\|\\")+"`))){
	    string s="";
	    bool escaped=false;
	    foreach(c; m.hit[1..$-1]){
		if(!escaped && c=='\\'){
		    escaped=true;
		}else{
		    s~=c;
		    escaped=false;
		}
	    }
	    tokens~=new Token(TokenType.String, s);
	    buffer=m.post;
        }else if(m=match(buffer,regex(r"^[0-9A-Za-z.+*/-]+"))){
	    tokens~=new Token(TokenType.Symbol, m.hit);
	    buffer=m.post;
	}else{
	    if(buffer.length>32){
		buffer=buffer[0..32];
	    }
	    throw new Exception("Scanner Error "~buffer);
	}
    }
    return tokens;
}

unittest{
    Token[] t;
    t=scanstring(`(1234 1.234 "abcd\"\\e" abcd a+b)`);
    assert(t.length==7);
    assert(t[0].type==TokenType.LParen);
    assert(t[1].type==TokenType.Int && t[1].intval==1234);
    assert(t[2].type==TokenType.Real && t[2].realval==1.234);
    assert(t[3].type==TokenType.String && t[3].strval=="abcd\"\\e");
    assert(t[4].type==TokenType.Symbol && t[4].strval=="abcd");
    assert(t[5].type==TokenType.Symbol && t[5].strval=="a+b");
    assert(t[6].type==TokenType.RParen);
}
