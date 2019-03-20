(* ::Package:: *)

(* ::Input:: *)
(*s1={{{1,0,1},{0,1,0},{0,0,1},{1,1,0},{0,1,1},{1,0,0},{1,1,1},{0,0,0}},{{0,0,1},{1,0,0},{1,1,0},{0,1,0},{0,0,0},{1,1,1},{1,0,1},{0,1,1}}}; (*First s-box*)*)
(**)
(**)
(*s2={{{1,0,0},{0,0,0},{1,1,0},{1,0,1},{1,1,1},{0,0,1},{0,1,1},{0,1,0}},*)
(*{{1,0,1},{0,1,1},{0,0,0},{1,1,1},{1,1,0},{0,1,0},{0,0,1},{1,0,0}}}; (*Second s-box*)*)
(**)
(*lexigraphical[x_List]:=Which[x== {0,0,0},1,x=={0,0,1},2,x=={0,1,0},3,x=={0,1,1},4,x=={1,0,0},5,x=={1,0,1},6,x=={1,1,0},7,x=={1,1,1},8]; (* defines a function that takes a vector x \[Element] \[DoubleStruckCapitalZ]^3 with entires Subscript[x, i] \[Element] Subscript[\[DoubleStruckCapitalZ], 2] as input, and outputs the lexigraphical equivalent. *)*)
(**)
(*stringtoarray[x_String]:= ToExpression[Characters[x]]; (* Turns the input 101010101001010101 into "101010101001010101", then into {"1","0",....}, then into {1,0,...} *)*)
(**)
(*keygen[x_String,rounds_Integer]:=Flatten[ToExpression[Characters[StringRepeat[x,rounds]]]]; (*Does what stringtoarray does, in addition to generating a repeated list of the keys to allow us to find the roundkeys, garunteed to be much longer than the number of rounds asked for. Can be made more efficient *)*)
(**)
(*arraytostring[x_List]:=StringJoin[Map[ToString,x ]]; (*Reverses stringtoarray[]*)*)
(**)
(*split[x_List]:={x[[1;;6]],x[[7;;]]}; (*Splits the 12-bit list into two 6-bit parts*)*)
(**)
(*expandchars[y_List]:=Flatten[{y[[1;;2]],y[[4;;3;;-1]],y[[4;;3;;-1]],y[[5;;6]]}]; (*Performs the expander function within SDES*)*)
(**)
(*sbox1[x_List]:=s1[[x[[1]]+1,lexigraphical[x[[2;;4]]]]]; (* Grabs the output from the first Substitution box*)*)
(**)
(*sbox2[x_List]:=s2[[x[[5]]+1,lexigraphical[x[[6;;8]]]]]; (* Grabs the output from the second Substitution box*)*)
(**)
(*sboxoutput[x_List]:=Flatten[{sbox1[x],sbox2[x]}]; (*Combines the outputs from the substituion boxes into a new list *)*)
(**)
(*roundkey[keychars_,i_]:=keychars[[i;;i+7]]; (*Generates the i-th roundkey *)*)
(**)
(*encryption[ptxt_,keylist_,rounds_]:=Module[{ptxtt,rkey,output,Lold,Rold,expanded,Lnew,Rnew},ptxtt=ptxt;Do[*)
(*rkey=roundkey[keylist,p];*)
(*{Lold,Rold}=split[ptxtt];*)
(*Lnew=Rold;*)
(*expanded=BitXor[expandchars[Rold],rkey];*)
(*Rnew=BitXor[sboxoutput[expanded],Lold];*)
(*ptxtt=Flatten[{Lnew,Rnew}];*)
(* ,{p,1,rounds}];*)
(*ptxtt]; (*The actual process of encryption via SDES*)*)
(**)
(*decryption[ptxt_,keylist_,rounds_]:=Module[{ptxtt,rkey,output,Lold,Rold,expanded,Lnew,Rnew},ptxtt=ptxt;{Rold,Lold}=split[ptxtt];*)
(*ptxtt=Flatten[{Lold,Rold}];*)
(*Do[*)
(*rkey=roundkey[keylist,rounds+1-p];*)
(*{Lold,Rold}=split[ptxtt];*)
(*Lnew=Rold;*)
(*expanded=BitXor[expandchars[Rold],rkey];*)
(*Rnew=BitXor[sboxoutput[expanded],Lold];*)
(*ptxtt=Flatten[{Lnew,Rnew}];*)
(* ,{p,1,rounds}];*)
(*ptxtt=Flatten[{ptxtt[[7;;]],ptxtt[[1;;6]]}] (*Same as encryption, but for decryption*)*)
(*];*)
(**)
(*sdes[plaintxt_String/;(Length[stringtoarray[plaintxt]]==  12),key_String/;Length[stringtoarray[key]]==  9,rounds_Integer/;rounds>0,encryptQ_:1]:=Module[{new,encrypted,ptxt,keychars,output}, *)
(*ptxt=stringtoarray[plaintxt];*)
(*keychars=keygen[key,rounds];*)
(**)
(*Which[encryptQ==1,*)
(*new=encryption[ptxt,keychars,rounds],encryptQ==-1,new= decryption[ptxt,keychars,rounds]];*)
(*arraytostring[new]*)
(**)
(*]*)
