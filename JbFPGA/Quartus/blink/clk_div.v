module clk_div #(parameter X = 0) (
  input clk, 				//clk in
  input rst,                //rst in
  output clk_out  			// clk out, devided by 2^X
  );


reg [X-1:0]cnt = 0;
assign clk_out = cnt[X-1];

always @(posedge clk or posedge rst) 
begin

	if (rst)
	begin
		cnt= 0;
	end
	
	else
	begin
		if (clk_out)
		begin
		  cnt<= 0;
		end
		
		else
		begin
			cnt<= cnt + 1;
		end
	end
end

 /*always @(posedge clk) begin
    if (clk_out)
      cnt <= 0;

    else
      cnt <= cnt + 1;
 end*/
endmodule
