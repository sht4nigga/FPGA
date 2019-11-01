module h_sh (
  input [9:0] I,
  input [3:0] D,
  reg output[1023:0] Q
	
);

always @ (posedge C or posedge R)
begin
	if (R)
	Q = 0;
	else
	case(M)
		0: Q= Q;
		1: Q= D;
		2: Q= Q+1;
		3: Q= Q-1;
		4: Q= { Q[2:0], 1'b0 };
		5: Q= { 1'b0, Q[3:1] };
		6: Q= { Q[2:0], Q[3] };
		7: Q= { Q[0], Q[3:1] };
	endcase
end

endmodule


