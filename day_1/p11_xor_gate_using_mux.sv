module mux
(
  input  d0, d1,
  input  sel,
  output y
);

  assign y = sel ? d1 : d0;

endmodule

//----------------------------------------------------------------------------

module xor_gate_using_mux
(
    input  a,
    input  b,
    output o
);

  // TODO

  // Implement xor gate using instance(s) of mux,
  // constants 0 and 1, and wire connections
  wire mux1y_mux2d1;
  
  mux mux1(.d0(b), .d1(1'b0), .sel(a), .y(mux1y_mux2d1));
  mux mux2(.d0(a), .d1(mux1y_mux2d1), .sel(b), .y(o));
  
  // mux mux1(.d0(1'b0), .d1(1'b1), .sel(a ^ b), .y(o));


endmodule

//----------------------------------------------------------------------------

module testbench;

  logic a, b, o;
  int i, j;

  xor_gate_using_mux inst (a, b, o);

  initial
    begin
      for (i = 0; i <= 1; i++)
      for (j = 0; j <= 1; j++)
      begin
        a = i;
        b = j;

        # 1;

        $display ("TEST %b ^ %b = %b", a, b, o);
    
        if (o !== (a ^ b))
          begin
            $display ("%s FAIL: %h EXPECTED", `__FILE__, a ^ b);
            $finish;
          end
      end
      
      $display ("%s PASS", `__FILE__);
      $finish;
    end

endmodule
