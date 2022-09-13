module data_request(input clk,
    input pls_data_request_complete, // aqui estamos dividiendo pls request en sus 5 formas que puede tener un bit por entrada.
    input pls_data_request_extend,  // otra forma que tenia planeado es tipo one hot, pero puedo preguntar al profe
    input pls_data_request_extenderror,
    input pls_data_request_zero,
    input pls_data_request_one,
    output reg [7:0]txd,
    output reg tx_en,
    output reg tx_er,
    output reg gt_clk
);
//en este always empezaremos a montar la tabla 35-1
always @(posedge clk) begin
 // complete
 if (pls_data_request_complete && !pls_data_request_extend && !pls_data_request_extenderror && !pls_data_request_zero && !pls_data_request_one) begin
    tx_en = 0;
    tx_er = 0;
    //txd puede ser todos los números excepto 0f y 1f
    txd = 8'h3F;
 end

// extend
else if(!pls_data_request_complete && pls_data_request_extend && !pls_data_request_extenderror && !pls_data_request_zero && !pls_data_request_one) begin
  tx_en = 0;
    tx_er = 1;
    //txd puede ser todos los números excepto 0f y 1f
    txd = 8'h0F;
end

//extend error
else if(!pls_data_request_complete && !pls_data_request_extend && pls_data_request_extenderror && !pls_data_request_zero && !pls_data_request_one) begin
  tx_en = 0;
    tx_er = 1;
    //txd puede ser todos los números excepto 0f y 1f
    txd = 8'h1F;
end

//zero
else if(!pls_data_request_complete && !pls_data_request_extend && !pls_data_request_extenderror && pls_data_request_zero && !pls_data_request_one) begin
  tx_en = 1; //tranmisión normal significa este
    tx_er = 0;
    //txd puede ser todos los números excepto 0f y 1f
    txd = 8'h5F;
end

//one
else if(!pls_data_request_complete && !pls_data_request_extend && !pls_data_request_extenderror && !pls_data_request_zero && pls_data_request_one) begin
  tx_en = 1; //trasmision normal
    tx_er = 0;
    //txd puede ser todos los números excepto 0f y 1f
    txd = 8'h6F;
end

end


endmodule