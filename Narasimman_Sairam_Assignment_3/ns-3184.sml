(* Problem 1 *)
fun checksum (list, n) =
	let fun sum (list) =
		if list = nil then 0
		else hd(list) + sum(tl(list))
	in
		(sum(list) = n)
	end;

(* Problem 2 *)
fun length list = foldl (fn (_,x) => 1 + x) 0 list;	

(* Problem 3 *)
fun reverse list = foldr (fn (x,y) => y @ [x]) [] list;

(* Problem 4 *)
exception Mismatch
fun zip ([], []) = []
| zip (headfirst::tailfirst,headsecond::tailsecond) = (headfirst,headsecond) :: zip (tailfirst,tailsecond)
| zip _ = raise Mismatch;

(* Problem 5 *)
fun unzip list = foldl (fn((x,y),(u,v))=>(u @ [x],v @ [y])) (nil,nil) list;

(*
checksum ([1,2,3,4], 11);
length([1,2,3,4]);
reverse([1,2,3,4]);
zip([1,2,3,4], [5,6,7,8]);
unzip([(1,5),(2,6),(3,7),(4,8)]);
*)