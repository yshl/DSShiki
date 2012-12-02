module expression;
import std.conv;

enum ExpType{
    Expression, Int, Real, String, Symbol
}

class Exp{
    ExpType type;
    union{
	long intval;
	real realval;
	string strval;
	Exp[] exps;
    }
    this(){
	type=ExpType.Expression;
	exps=[];
    }
    this(long l){
	type=ExpType.Int;
	intval=l;
    }
    this(real r){
	type=ExpType.Real;
	realval=r;
    }
    this(string s, ExpType t){
	if(t!=ExpType.String && t!=ExpType.Symbol){
	    throw new Exception("Bad Type");
	}
	type=t;
	strval=s;
    }
    void addexp(Exp e){
	if(type!=ExpType.Expression){
	    throw new Exception("Bad Type");
	}
	exps~=e;
    }
    string tostring(){
	switch(type){
	    case ExpType.Expression:
		string s="[";
		foreach(e; exps){
		    s~=" "~e.tostring();
		}
		return s~" ]";
		break;
	    case ExpType.Int:
		return to!(string)(intval);
		break;
	    case ExpType.Real:
		return to!(string)(realval);
		break;
	    case ExpType.String:
		return "\""~strval~"\"";
		break;
	    case ExpType.Symbol:
		return strval;
		break;
	    default:
		assert(0);
		break;
	}
    }
}
unittest{
    Exp i=new Exp(0);
    Exp r=new Exp(1.0);
    Exp st=new Exp("abc",ExpType.String);
    Exp sy=new Exp("def",ExpType.Symbol);
    Exp e=new Exp();
    e.addexp(i);
    e.addexp(r);
    e.addexp(st);
    e.addexp(sy);
    assert(e.type==ExpType.Expression);
    assert(e.exps.length==4);
    assert(e.exps[0].type==ExpType.Int && e.exps[0].intval==0);
    assert(e.exps[1].type==ExpType.Real && e.exps[1].realval==1.0);
    assert(e.exps[2].type==ExpType.String && e.exps[2].strval=="abc");
    assert(e.exps[3].type==ExpType.Symbol && e.exps[3].strval=="def");
}
