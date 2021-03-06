open Base
open OUnit
open Big_int
open BigIntUtil

let _ = begin "bigNumUtil.ml" >::: [
  "BigEndianで文字列に変換できる" >:: begin fun () ->
    assert_equal ~printer:Std.dump "\000" @@ pack ~n:1 (big_int 0);
    assert_equal ~printer:Std.dump "\000\000" @@ pack ~n:2 (big_int 0);
    assert_equal ~printer:Std.dump "\000\000\001\001" @@ pack ~n:4 (big_int 257);
  end;
  "文字列からBig_intに変換できる" >:: begin fun () ->
    let open BigIntOp in
      "1 byte"  @? (big_int 0 = unpack "\000");
      "2 bytes" @? (big_int 1 = unpack "\000\001");
      "4 bytes" @? (big_int 257 = unpack "\000\000\001\001");
  end;
  "四則演算を持ってる" >:: begin fun () ->
    let open BigIntOp in
      "add"  @? (big_int 3 = big_int 1 + big_int 2);
      "sub"  @? (big_int 1 = big_int 2 - big_int 1);
      "mult" @? (big_int 2 = big_int 2 * big_int 1);
      "div"  @? (big_int 2 = big_int 4 / big_int 2);
  end
] end +> run_test_tt_main
