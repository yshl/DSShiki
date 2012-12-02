import expression;
import scanner;

Exp tokentoexp(Token t)
{
    switch(t.type){
	case TokenType.Int:
	    return new Exp(t.intval);
	    break;
	case TokenType.Real:
	    return new Exp(t.realval);
	    break;
	case TokenType.String:
	    return new Exp(t.strval, ExpType.String);
	    break;
	case TokenType.Symbol:
	    return new Exp(t.strval, ExpType.Symbol);
	    break;
	default:
	    throw new Exception("Bad Token");
    }
}

Exp parse(ref Token[] tokens)
{
    if(tokens.length==0){
	return new Exp();
    }
    auto tok=tokens[0];
    tokens=tokens[1..$];
    switch(tok.type){
	case TokenType.LParen:
	    auto e=new Exp();
	    while(true){
		if(tokens.length==0){
		    throw new Exception("Unmatched ( ");
		}
		if(tokens[0].type==TokenType.RParen){
		    tokens=tokens[1..$];
		    break;
		}
		e.addexp(parse(tokens));
	    }
	    return e;
	case TokenType.RParen:
	    throw new Exception("Unmatched ) ");
	default:
	    return tokentoexp(tok);
    }
}
unittest{
    auto toks=scanstring(`(123 ("a\"bc\\" ()))`);
    auto list=parse(toks);
    assert(list.type==ExpType.Expression);
    assert(list.exps.length==2);
    assert(list.exps[0].type==ExpType.Int);
    assert(list.exps[0].intval==123);
    assert(list.exps[1].type==ExpType.Expression);
    assert(list.exps[1].exps.length==2);
    assert(list.exps[1].exps[0].type==ExpType.String);
    assert(list.exps[1].exps[0].strval=="a\"bc\\");
    assert(list.exps[1].exps[1].type==ExpType.Expression);
    assert(list.exps[1].exps[1].exps.length==0);
}
